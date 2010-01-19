//
//  FRLinkFetcher.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 08/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "FRLinkFetcher.h"
#import "ASIHTTPRequest/ASIHTTPRequest.h"
#import "FRDumpDocument.h"
#import "WatcherDocument.h"

// private methods
@interface FRLinkFetcher ()
- (NSString *)createTempFolder;
- (BOOL)shouldContinue;
- (NSArray *)imageURLAndNameFromNode:(NSXMLElement *)node;
- (BOOL)addImageWithInfo:(NSArray *)info postURL:(NSURL *)theURL postText:(NSString *)text postNum:(NSString *)postNum date:(NSString *)date;
@end

@implementation FRLinkFetcher

- (id)initWithURLString:(NSString *)newURLString delegate:(id)d directory:(NSString *)dir
{
	self = [super init];
	if (self)
	{
		baseURL = [[NSURL URLWithString:newURLString] URLByDeletingLastPathComponent];
		instanceURL = [NSURL URLWithString:newURLString];
		_delegate = d;
		dirPath = [dir copy];
		receivedData = nil;
		folderPath = nil;
	}
	return self;
}

// -----------------------------------------------------------------------------------------

- (void)setDelegate:(id)newDelegate
{	
	@synchronized(self)
	{
		if (_delegate != newDelegate) 
			_delegate = newDelegate;
	}
}

- (id)delegate
{
	return _delegate;
}

// --------------------------------------------------------------------------------------------

-(BOOL)generateLinks
{	
	NSError *docError;
    NSXMLDocument *document = [[NSXMLDocument alloc] initWithData:receivedData 
														  options:NSXMLDocumentTidyHTML 
															error:&docError];
    // ignore the error: with most HTML it will be filled with "tidy" warnings
	
	NSXMLElement *rootNode = [document rootElement];
	
	// a query to find the name of the thread, if possible
	// ignore any errors. if something goes wrong we just don't send it
	// and we will generate a name using the numebr of the op post
	NSString *nameQueryString = @"//span[@class='filetitle']";  
	NSError *nameNodeError = nil;
	NSArray *nameNode = [rootNode nodesForXPath:nameQueryString 
										  error:&nameNodeError];
	if ([nameNode count] > 0 && !nameNodeError) 
	{
		NSString *name = [[nameNode objectAtIndex:0] stringValue];
		[_delegate performSelectorOnMainThread:@selector(setWindowNameTo:)
								   withObject:name
								waitUntilDone:YES];
	}
	
	// find all reply nodes 
	NSString *xpathQueryString = @"//table/tr/td[@class='reply']";
	NSError *nodeError;
	NSArray *replyNodes = [rootNode nodesForXPath:xpathQueryString 
											error:&nodeError];	
    if (nodeError)
    {
        [[NSAlert alertWithError:nodeError] runModal];
		[_delegate performSelectorOnMainThread:@selector(returnedError:)
								   withObject:@"Error parsing page." 
								waitUntilDone:NO];
        return FALSE;
    }
	
	folderPath = [self createTempFolder];
	
	// get the OP image from the thread (it won't be included in the reply nodes)
	NSString *xpathQueryOP = @"//span[@class='filesize']";
	NSError *opNodeError;
	NSArray *opNodes = [rootNode nodesForXPath:xpathQueryOP 
										 error:&opNodeError];
	NSArray *opImageInfo = nil;
	if ([opNodes count] > 0) 
	{
		NSXMLElement *opNode = [opNodes objectAtIndex:0];
		opImageInfo = [self imageURLAndNameFromNode:opNode];
	}
	else 
		return TRUE;
	
	// get text of op post (should be first blockquote)
	NSString *opBlockQuoteQuery = @"//blockquote";
	NSError *opBlockQuoteError;
	NSArray *opBlockquoteNodes = [rootNode nodesForXPath:opBlockQuoteQuery 
										 error:&opBlockQuoteError];
	NSString *opPostText = [[opBlockquoteNodes objectAtIndex:0] stringValue];
	
	// get the url of the op post
	NSString *xpathQueryOPName = @"//a[@name]";
	NSError *opNameNodeError;
	NSArray *opNameNodes = [rootNode nodesForXPath:xpathQueryOPName 
										 error:&opNameNodeError];
	NSString *opPostNumber = [[[opNameNodes objectAtIndex:0] attributeForName:@"name"] stringValue];
	NSMutableString *posturl = [FRLinkFetcher cleanBaseURLAsMutableString:[self instanceURL]];
	[posturl appendString:@"#"];
	[posturl appendString:opPostNumber];
	NSURL *opURL = [NSURL URLWithString:posturl];
	
	// get OP post number, which is also the thread number
	NSMutableString *threadNumber = [NSMutableString stringWithString:@"Thread #"];
	[threadNumber appendString:opPostNumber];
	
	// tell the document the thread number
	[_delegate performSelectorOnMainThread:@selector(setThreadNumber:)
								withObject:opPostNumber
							 waitUntilDone:YES];
	
	// if we didn't find a thread name, use the op post number as the thread name
	if ([nameNode count] == 0) 
	{
		
		[_delegate performSelectorOnMainThread:@selector(setWindowNameTo:)
									withObject:threadNumber
								 waitUntilDone:YES];
	}
	
	[_delegate performSelectorOnMainThread:@selector(pageWasLoaded:)
								withObject:[NSNumber numberWithInt:[opBlockquoteNodes count]]
							 waitUntilDone:YES];
	
	[self addImageWithInfo:opImageInfo 
				   postURL:opURL 
				  postText:opPostText
				   postNum:opPostNumber
					  date:nil];

	
	// go through all reply nodes and get the text, image urls and image names
    for (NSXMLElement *node in replyNodes)
    {
		// check if the user has cancelled downloads
		if (![self shouldContinue]) 
			return FALSE;
		
		// get the number of the post and construct the url from it
		NSArray *input = [node elementsForName:@"input"];
		NSString *postNum = [[[input lastObject] attributeForName:@"name"] stringValue];
		NSMutableString *postURLString = [FRLinkFetcher cleanBaseURLAsMutableString:[self instanceURL]];
		[postURLString appendString:@"#"];
		[postURLString appendString:postNum];
		NSURL *postURL = [NSURL URLWithString:postURLString];
		
		// get the node containing info about the image
		NSString *xpathQueryFileSize = @"span[@class='filesize']";
		NSError *fsNodeError = nil;
		NSArray *filesizeNodes = [node nodesForXPath:xpathQueryFileSize 
											   error:&fsNodeError];
		
		// get the post text
		NSString *postText;
		NSString *textQuery = @"blockquote";
		NSError *textError = nil;
		NSArray *text = [node nodesForXPath:textQuery 
									  error:&textError];
		postText = [[text lastObject] stringValue];
		
		// get post time/date
		// the date is at a different child node index, depending on if there
		// is an email, trip code ect. this should pick the right node for all possibilities
		NSString *date = nil;
		if ([node childCount] == 9) 
			date = [[node childAtIndex:5] stringValue];
		else if ([node childCount] == 14)
			date = [[node childAtIndex:5] stringValue];
		else 
			date = [[node childAtIndex:3] stringValue];
		
		if ([filesizeNodes count] == 0) 
		{
			// create a FRPostObject with no image
			if (![self addImageWithInfo:nil 
								postURL:postURL
							   postText:postText
								postNum:postNum
								   date:date])
				return FALSE;
		}
		else 
		{
			// create an FRPostObject with an image
			[self addImageWithInfo:[self imageURLAndNameFromNode:[filesizeNodes lastObject]] 
						   postURL:postURL
						  postText:postText
						   postNum:postNum
							  date:date];
		}
    }
	
	return TRUE;
}
		
// returns a base url that has quote/postnumber bits removed
// should be something like: "http://boards.4chan.org/g/res/"
+ (NSMutableString *)cleanBaseURLAsMutableString:(NSURL *)orig
{
	NSMutableString *newurl;
	NSString *originalURL = [orig absoluteString];
	NSRange hashRange = [originalURL rangeOfString:@"#"];
	if (hashRange.location ==  NSNotFound) 
	{
		// no junk on the end
		newurl = [NSMutableString stringWithString:originalURL];
	}
	else 
	{
		// clean junk
		NSArray *temp = [originalURL componentsSeparatedByString:@"#"];
		NSURL *tempURL = [NSURL URLWithString:[temp objectAtIndex:0]];
		newurl = [NSMutableString stringWithString:[tempURL absoluteString]];
	}
	return newurl;
}
													 
// returns the name and url of an image from a 'filesize' node
// first element of returned array is url, second is name
- (NSArray *)imageURLAndNameFromNode:(NSXMLElement *)node
{
	NSArray *childrenLinks = [node elementsForName:@"a"];
	NSArray *childrenNames = [node elementsForName:@"span"];
	
	NSString *relativeString = [[[childrenLinks lastObject] attributeForName:@"href"] stringValue];
	NSString *origName = [[[childrenNames lastObject] attributeForName:@"title"] stringValue];
	NSURL *url = [NSURL URLWithString:relativeString relativeToURL:baseURL];
	
	return [NSArray arrayWithObjects:url, origName, nil];
}

// method to construct and add the image to the array in the delegate
// returns true if sucessful, false if we were cancelled during progress or there was an error
- (BOOL)addImageWithInfo:(NSArray *)info 
				 postURL:(NSURL *)theURL 
				postText:(NSString *)text 
				 postNum:(NSString *)postNum 
					date:(NSString *)date
{
	NSURL *url = nil;
	NSString *origName = nil;
	
	if (info) 
	{
		url = [info objectAtIndex:0];
		origName = [info objectAtIndex:1];
	}
	
	
	FRPostedImage *i = [[FRPostedImage alloc] initWithURLString:[url absoluteString]];
	if (origName) 
		[i setImageName:origName];
	
	// set the info about the post
	[i setPostURL:theURL];
	[i setPostText:text];
	[i setPostNumber:postNum];
	[i setDate:date];
	
	// check that we haven't already downloaded the image
	NSMutableArray *currentPosts = [_delegate allPosts];
	if ([currentPosts containsObject:i]) 
		return TRUE;
	
	// before adding the FRPostedImage, tell it to download the image data
	if(![i downloadImageToFolder:folderPath 
				   animatedThumb:[_delegate wantsAnimation]
		   withProgressIndicator:[self downloadBar]])
		return FALSE;
	
	// check if the user has cancelled downloads
	if (![self shouldContinue]) 
		return FALSE;
	
	// send the image to the NSMutableSet in the delegate
	[_delegate performSelectorOnMainThread:@selector(addNewImage:)
								withObject:i
							 waitUntilDone:YES];

	return TRUE;
}

// create a temp folder to store downloads if one does not already exist
- (NSString *)createTempFolder
{
	NSFileManager *fm = [[NSFileManager alloc] init];;
	
	BOOL dir;
	if (![fm fileExistsAtPath:dirPath isDirectory:&dir])
	{
		if (!dir) 
		{
			NSError *e = nil;
			[fm createDirectoryAtPath:dirPath 
		  withIntermediateDirectories:YES 
						   attributes:nil
								error:&e];
			if (e) 
				NSLog(@"Error creating temp directory: %@", e);
		}
	}
	return dirPath;
}

// checks if we have been cancelled, and updates the UI if we have
- (BOOL)shouldContinue
{
	if ([self isCancelled]) 
	{
		[_delegate performSelectorOnMainThread:@selector(wasCancelled)
								   withObject:nil 
								waitUntilDone:NO];
		
		return FALSE;
	}
	return TRUE;
}

// -------------------------------------------------------------------------------

// this gets run when we add the operation to an nsoperationqueue
- (void)main
{	
	[_delegate performSelectorOnMainThread:@selector(loadingPage)
								withObject:nil 
							 waitUntilDone:YES];
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:instanceURL];
	[request startSynchronous];
	
	if ([request error])
	{
		[_delegate performSelectorOnMainThread:@selector(returnedError:)
									withObject:@"Error fetching page." 
								 waitUntilDone:NO];
		return;
	}
	
	// check for 404
	int statuscode = [request responseStatusCode];
	if (statuscode == 404)
	{
		[_delegate performSelectorOnMainThread:@selector(returnedError:)
									withObject:@"Thread 404'd." 
								 waitUntilDone:NO];
		return;
	}
	
	// get the response data
	[self setReceivedData:[request responseData]];
	
	// get the posts and download the images
	if ([self generateLinks]) 
	{
		[_delegate performSelectorOnMainThread:@selector(fetchedAllImages)
									withObject:nil
								 waitUntilDone:YES];
	}
	
	[_delegate setFetcher:nil];
	return;
}

@synthesize baseURL, instanceURL, dirPath, downloadBar, receivedData;

@end
