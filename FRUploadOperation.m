//
//  FRUploadOperation.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRUploadOperation.h"
#import "ASIHTTPRequest/ASIFormDataRequest.h"
#import "FRDumpDocument.h"
#import "FRWatcherTabContentsController.h"
#import "FRPreferenceController.h"

// private methods
@interface FRUploadOperation ()

- (int)examineResponse:(NSString *)res;
- (NSString *)errorDescriptionFromCode:(int)code response:(NSString *)response;
- (NSString *)attemptPostinOldThread:(BOOL)old;
- (void)delayThread;
- (NSString *)board;
- (void)growlNewThreadLink;
@end
// ---------------------------------------------------------------------------------

@implementation FRUploadOperation

/*!
    @method     initWithTargetURL:(NSURL *)target andLocalImage:(FRLocalImage *)im fromQueue:(NSOperationQueue *)q
    @abstract   initialise
    @discussion initialise with a target url (the reply url for the board)
				and a FRLocalImage (which must contain the url of a local image file)
				q is the operationqueue to which the operation will be added
*/
- (id)initWithTargetURL:(NSURL *)target andLocalImage:(FRLocalImage *)im fromQueue:(NSOperationQueue *)q
{
	self = [super init];
	if (self)
	{
		delay = 20;
		theName = nil;
		email = nil;
		subject = nil;
		theComment = nil;
		uploadTargetURL = target;
		local = im;
		queue = q;
		threadNumber = nil;
		oldThreadNumber = nil;
		newThread = FALSE;
		delegate = nil;
		isPaused = FALSE;
		
		
		growling = [GrowlApplicationBridge isGrowlRunning];
	}
	return self;
}


/*!
    @method     attemptPostinOldThread:
    @abstract   attempts to make a post
    @discussion constructs post using ivars, sends it and returns the response string
				from the server. if there was an error, returns nil
				if linkInOldThread is true, it just posts a link to the new thread in the old thread
*/
- (NSString *)attemptPostinOldThread:(BOOL)linkInOldThread
{
	ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:[self uploadTargetURL]];
	[postRequest setRequestMethod:@"POST"];
	
	if (threadNumber) 
		[postRequest setPostValue:[self threadNumber] forKey:@"resto"];
	else 
	{
		// we are creating a new thread
		[self setNewThread:TRUE];
	}
	
	// check if we are just posting a link to the new thread in an old thread
	if (linkInOldThread) 
	{
		[self setTheComment:[NSString stringWithFormat:@"continued in >>%@", [self threadNumber]]];
		if ([self oldThreadNumber])
			[postRequest setPostValue:[self oldThreadNumber] forKey:@"resto"];
		else 
			return nil;
	}
	else 
		[postRequest setFile:[[local localURL] path] forKey:@"upfile"];

	[postRequest setPostValue:[self theName] forKey:@"name"];
	[postRequest setPostValue:[self email] forKey:@"email"];
	[postRequest setPostValue:[self subject] forKey:@"sub"];
	[postRequest setPostValue:[self theComment] forKey:@"com"];
	[postRequest addRequestHeader:@"User-Agent" 
							value:[[NSUserDefaults standardUserDefaults] stringForKey:FRUserAgent]];
	
	[postRequest setPostValue:@"" forKey:@"pwd"];
	[postRequest setPostValue:@"regist" forKey:@"mode"];
	[postRequest setPostValue:@"submit" forKey:@"submit"];
	[postRequest setUseCookiePersistance:NO];
	[postRequest setUploadProgressDelegate:[self uploadProgressDelegate]];
	
	// send the post
	[postRequest startSynchronous];
	
	NSError *err = [postRequest error];
	if (err) 
	{
		NSLog(@"Error sending post: %@", err);
		return nil;
	}

	return [postRequest responseString];
}

/*!
    @method     examineResponse:(NSString *)response
    @abstract   examine a response string
    @discussion returns 0 if post was sucessful
				1 if flood detected, higher numbers represent other errors
*/
- (int)examineResponse:(NSString *)response
{
	int code;
	NSRange no = NSMakeRange(NSNotFound, 0);
	
	NSRange success = [response rangeOfString:uploadedResponse];
	NSRange dupl = [response rangeOfString:duplicateResponse];
	NSRange flood = [response rangeOfString:floodResponse];
	NSRange limit = [response rangeOfString:limitResponse];
	NSRange abnormal = [response rangeOfString:abnormalReplyResponse];
	NSRange four = [response rangeOfString:fourohfourResponse];
	NSRange nothread = [response rangeOfString:noThreadResponse];
	NSRange banned = [response rangeOfString:bannedResponse];
	NSRange toolong = [response rangeOfString:tooLongResponse];
	NSRange large = [response rangeOfString:largeFileResponse];
	NSRange malicious = [response rangeOfString:maliciousResponse];
	NSRange highres = [response rangeOfString:highResResponse];
	
	if (success.location != no.location)
		code = 0;
	else if (dupl.location != no.location)
		code = 2;
	else if (flood.location != no.location)
		code = 1;
	else if (limit.location != no.location)
		code = 3;
	else if (abnormal.location != no.location)
		code = 4;
	else if (four.location != no.location)
		code = 5;
	else if (nothread.location != no.location)
		code = 6;
	else if (banned.location != no.location)
		code = 7;
	else if (toolong.location != no.location)
		code = 8;
	else if (large.location != no.location)
		code = 9;
	else if (malicious.location != no.location)
		code = 10;
	else if (highres.location != no.location)
		code = 11;
	else 
		code = 12;
	
	if (code == 0) 
	{
		if (newThread) 
		{
			// we were trying to post a new thread
			// so get the number of the thread we created
			NSArray *c = [response componentsSeparatedByString:@"thread:0,no:"];
			if ([c count] > 0) 
			{
				NSArray *com = [[c objectAtIndex:1] componentsSeparatedByString:@" "];
				NSString *num = [com objectAtIndex:0];
				[self setThreadNumber:num];
				
				// tell use where the new thread is
				[self growlNewThreadLink];
			}
		}
	}
	
	// TODO: error modes that mean we should cancel
	// for example if we get a banned reply, we might want to cancel the dump
	
	return code;
}

//TODO: test that this works
- (void)growlNewThreadLink
{
	if (growling)
	{
		NSString *desc = [NSString stringWithFormat:@"http://boards.4chan.org/%@/res/%@", [self board], threadNumber];
		NSMutableString *fullDesc = [NSMutableString stringWithString:desc];
		[fullDesc appendString:@"\r Click to open..."];
		
		[GrowlApplicationBridge notifyWithTitle:@"Created New Thread"
									description:fullDesc
							   notificationName:@"New Thread"
									   iconData:[NSData data] 
									   priority:1 
									   isSticky:NO 
								   clickContext:desc];
	}
}

// return the board as a string just containing the board letters, e.g. @"g" for /g/
- (NSString *)board
{
	NSString *target = [[self uploadTargetURL] absoluteString];
	NSString *string = [target substringFromIndex:20];
	NSArray *subComponents = [string componentsSeparatedByString:@"/"];
	return [subComponents objectAtIndex:1];
}


/*!
    @method     
    @abstract   generates human readable error string from error code number
    @discussion response is used to print the full reponse to the log if
				error was of undefined type
*/
- (NSString *)errorDescriptionFromCode:(int)code response:(NSString *)response
{
	NSString *description;
	switch (code) 
	{
		case 2:
			description = @"File was a duplicate.";
			break;		
		case 3:
			description = @"Thread limit reached.";
			break;
		case 4:
			description = @"Abnormal reply.";
			break;
		case 5:
			description = @"404 - Thread not found.";
			break;
		case 6:
			description = @"Thread does not exist";
			break;
		case 7:
			description = @"You were banned ;_;";
			break;
		case 8:
			description = @"Field too long.";
			break;
		case 9:
			description = @"File was too large.";
			break;
		case 10:
			description = @"Possible malicious code in image :O";
			break;
		case 11:
			description = @"File resolution too high";
			break;
		default:		
			description = @"Failed to upload file";
			NSLog(@"Image upload failed, server response was: %@", response);
			break;
	}	
	return description;	
}

/*!
	@method	
	@abstract   delay thread
	@discussion delays the operation to avoid hitting the floodlimit when the next operation posts
				delays forever is we are paused, also checks if we are cancelled
*/
- (void)delayThread
{
	int initialDelay = [self delay];
	for (int i = 0; i < initialDelay; i++)
	{
		// check if we are cancelled
		if ([self isCancelled])
			return;
		
		// check if we are paused, if we are, sleep indefinately
		if ([self isPaused])
			initialDelay++;
		
		[NSThread sleepForTimeInterval:1.0];
	}
}

/*!
    @method     
    @abstract   starts the operation
    @discussion this is run when the operation is started by the queue
*/
- (void)main
{
	// update ui to show we are starting
	NSInteger oldnum = [delegate numberPosted];
	[local setPosted:@"posting"];
	NSInteger newnum = oldnum +1;
	NSInteger total = [[delegate imageURLs] count];
	NSString *stat = [NSString stringWithFormat:@"Posting Image %d of %d…", newnum, total];
	[delegate performSelectorOnMainThread:@selector(updateUIWithString:)
							   withObject:stat
							waitUntilDone:YES];
	
	int additionalDelay = 0;
	while (TRUE) 
	{
		// sleep for any additional delay required
		for (int i = 0; i < additionalDelay; i++)
		{
			if ([self isCancelled])
				return;
			
			[NSThread sleepForTimeInterval:1.0];
		}
		
		// attempt post
		NSString *response = [self attemptPostinOldThread:NO];
		if (response == nil)
		{
			// on error, retry, unless user cancels. going to fill their logs up nicely :3
			// probably should inform user here, since this is probably due to network being down
			// or 4chan being down
			if ([self isCancelled])
				break;
			else 
				continue;
		}
		
		// examine reply
		int replycode = [self examineResponse:response];
		if (replycode != 0) 
		{
			// there was some kind of error
			// TODO: handle other error cases
			// 5,6,7 should probably stop everything (banned, 404, nothread)
			if (replycode == 1)
			{
				// flood detected
				additionalDelay += 5;
			}
			else if (replycode == 3)
			{
				// thread limit was reached, so start a new thread
				// if the user told us to start a new thread, do so
				if ([delegate createNewThreads]) 
				{
					[self setOldThreadNumber:[self threadNumber]];
					// add a link to the old thread to the comment
					NSMutableString *newComment = [NSMutableString stringWithString:@"continued from: >>"];
					[newComment appendString:oldThreadNumber];
					[newComment appendString:[self theComment]]; 
					[self setTheComment:newComment];
					
					// reset the thread number so we create a enw thread next time
					[self setThreadNumber:nil];
				}
			}
			else 
			{
				// some other kind of error, tell user about it
				[local setColor:[NSColor redColor]];
				[local setPosted:nil];
				NSString *description = [self errorDescriptionFromCode:replycode response:response];
				[local setError:description];
				[delegate performSelectorOnMainThread:@selector(updateUIWithString:)
										   withObject:description 
										waitUntilDone:YES];
				break;
			}
		}
		else 
		{
			// post was successful
			[local setPosted:@"posted"];
			[local setPostedBOOL:TRUE];
			NSInteger newtotal = [[delegate imageURLs] count];
			NSString *status = [NSString stringWithFormat:
								@"%d of %d Images Posted. Waiting…", newnum, newtotal];
			[delegate performSelectorOnMainThread:@selector(updateUIWithString:)
									   withObject:status 
									waitUntilDone:YES];
			[delegate performSelectorOnMainThread:@selector(imagePosted)
									   withObject:nil 
									waitUntilDone:YES];
			break;
		}
	}
	
	// check if we started a new thread, and if so, go post a link to the new thread in the old thread
	if (oldThreadNumber)
	{
		// wait first to avoid flood
		[self delayThread];
		
		// tell user what we are doing
		NSString *s = @"Posting link in old thread";
		[delegate performSelectorOnMainThread:@selector(updateUIWithString:)
								   withObject:s 
								waitUntilDone:YES];
		
		// post it
		// (don't worry about the reply, if it didn't get posted, we just move on)
		[self attemptPostinOldThread:YES];
	}
	
	// add the next operation to the queue
	BOOL foundNext = [delegate enqueueNextImageWithDelay:([self delay]+additionalDelay) 
											threadNumber:[self threadNumber]];
	
	if (foundNext)
		[self delayThread];
	
	return;
}


@synthesize delay;
@synthesize email;
@synthesize theName;
@synthesize subject;
@synthesize theComment;
@synthesize uploadTargetURL;
@synthesize newThread;
@synthesize threadNumber;
@synthesize uploadProgressDelegate;
@synthesize queue;
@synthesize delegate;
@synthesize isPaused;
@synthesize oldThreadNumber;

@end
