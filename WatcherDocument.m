//
//  WatcherDocument.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "WatcherDocument.h"
#import "FRPostedImage.h"
#import "FRPreferenceController.h"
#include <sys/xattr.h>
#import <objc/objc-auto.h>
#import "ASIHTTPRequest/ASIFormDataRequest.h"


// strings for checking against server response when posting
NSString *const uploadedResponse = @"Post successful!";
NSString *const noImageResponse = @"Post successful!";
NSString *const duplicateResponse = @"Error: Duplicate file entry detected";
NSString *const floodResponse = @"Error: Flood detected";
NSString *const limitResponse = @"Max limit of";
NSString *const abnormalReplyResponse = @"Abnormal Reply";
NSString *const fourohfourResponse = @"404 - Not Found";
NSString *const noThreadResponse = @"Thread specified does";
NSString *const bannedResponse = @"You are banned! ;_;";
NSString *const tooLongResponse = @"Field too long.";
NSString *const largeFileResponse = @"Error: File too large.";
NSString *const maliciousResponse = @"Detected possible malicious code in image file.";
NSString *const highResResponse = @"Image resolution too large.";
NSString *const failedResponse = @"Error: Upload failed.";

//-----------------------------------------------------------------------------------
@interface FRPostedImage (QLPreviewItem) <QLPreviewItem>
@end

@implementation FRPostedImage (QLPreviewItem)

// some additional methods for FRPostedImage that are 
// required by quicklook to get the image url and image name
- (NSURL *)previewItemURL
{
	return [self localURL];
}

- (NSString *)previewItemTitle
{
	return [self imageName];
}
@end
//--------------------------------------------------------------------------------------------------

// private methods
@interface WatcherDocument ()
// cleanup
- (void)removeDownloadedFiles;

// timer stuff
- (NSDictionary *)userInfo;

// add posts
- (void)addPostObject:(id)anObject;
- (void)addLinksObject:(id)anObject;

// saving
- (void)saveImages:(NSArray *)images withURL:(NSURL *)target;
- (BOOL)attemptToCopyFileWithFM:(NSFileManager *)fm proposedURL:(NSURL *)url source:(NSURL *)source tags:(NSMutableSet *)tags rating:(double)rate;
- (NSString *)incrementSingleLastNumber:(NSString *)input;
- (NSString *)incrementDoubleLastNumber:(NSString *)input;
- (void)writeFinderCommentToFile:(NSURL *)url tags:(NSMutableArray *)tags;
- (void)writeTagsToFile:(NSURL *)url tags:(NSMutableSet *)tags rating:(double)rating;

// url stuff
- (BOOL)validURL:(NSString *)u;

// updating UI
- (void)updateStatusLabel:(NSString *)newStatus;
- (void)updateDownloadBar:(NSArray *)numbers;


// methods for updating the preview view
- (void)changePreviewImageTo:(NSImage *)newImage;
- (void)changeSelectedFileURLTo:(NSURL *)aURL;

// tags stuff
- (void)startObservingTag:(tag *)t;
- (void)stopObservingTag:(tag *)t;
- (void)addTags:(NSMutableArray *)newTags toImages:(NSArray *)targetImages;

// scripting stuff
- (void)resetScriptParameters;
- (void)addScriptTagsToAllImages;
- (void)addScriptRatingToAllImages;
- (void)checkForTags:(NSDictionary *)args;
- (void)checkForRating:(NSDictionary *)args;

// posting stuff
- (void)postSent;
- (void)uploadErrorTypeFromResponse:(NSString *)response;
- (void)identifyBoard:(NSString *)s;
@end


@implementation WatcherDocument

- (id)init
{
	self = [super init];
	if (self) 
	{
		links = [[NSMutableArray alloc] init];
		allPosts = [[NSMutableArray alloc] init];
		
		operationQueue = [[NSOperationQueue alloc] init];
		fetcher = nil;
		prevQueue = [[NSOperationQueue alloc] init];
		
		// create a unique string to label the temp 
		// directory associated with this window
		tempDirPath = [NSString stringWithFormat:@"/tmp/threadwatcher/%d", time(0)];
		
		// info about the thread
		threadName = [NSString stringWithString:@"Untitled"];
		sizeOfAllFiles = 0;
		numberBeforeDownload = 0;
		newImages = 0;
		numberPostsBeforeDownload = 0;
		
		// don't need timers yet, create when they are needed
		repeatingTimer = nil;
		
		// growl stuff
		growling = [GrowlApplicationBridge isGrowlRunning];
		
		// initialise our appscript objects
		safari = [[SFApplication alloc] initWithBundleID:@"com.apple.safari"];
		webkit = [[WKApplication alloc] initWithBundleID:@"org.webkit.nightly.WebKit"];
		firefox = nil;
		systemEvents = nil;
		
		// selection stuff
		selectedIndexes = nil;
		
		// tags stuff
		tagsOfSelectedImages = [[NSMutableArray alloc] init];
		removedTags = [[NSMutableSet alloc] init];
		
		// post stuff
		postComment = nil;
		
		// ivars used when user sends commands with applescript
		willSave = FALSE;
		scriptSaveSheet = FALSE;
		scriptSaveLocation = nil;
		scriptTags = nil;
		scriptRating = nil;
		
		selecting = FALSE;
	}
	return self;
}
// ---------------------------------------------------------------------------------
#pragma mark selection methods
// methods related to images being selected in the collectionview

// update which posts are selected
// also syncs which images are selected

- (void)selectionDidChange:(NSNotification *)aNotification
{
	NSIndexSet *s = [fullThreadView selectionIndexes];
	[self setSelectedPosts:s];
}

- (void)setSelectedPosts:(NSIndexSet *)indexset
{
	if (![indexset isEqualToIndexSet:selectedPosts]) 
	{
		selectedPosts = [indexset copy];
		
		// now work out which items in the links array are selected
		// so we can pass the correct indexset to setSelectedIndexes
		// and fill the selectedImages array with the correct objects
		// this is going to be ugly ..... 
		NSMutableIndexSet *newIndexSet = [[NSMutableIndexSet alloc] init];
		
		NSInteger current_index = [indexset firstIndex];
		while (current_index != NSNotFound)
		{
			NSInteger j = 0;
			NSInteger k = 0;
			for (FRPostedImage *i in allPosts)
			{
				if ([i theImage]) 
				{
					if (k == current_index) 
					{
						// we have reached the index item. the number of images so far (j)
						// gives us the index in the links array

						[newIndexSet addIndex:j];
						break;
					}
					j++;
				}
				k++;
			}
			current_index = [indexset indexGreaterThanIndex: current_index];
		}

		selecting = TRUE;
		[theController setSelectionIndexes:newIndexSet];
		selecting = FALSE;
	}
}

// for the array controller to inform us about image selection changes
// also where we manually update the preview view
// will update the selected posts, unless this was run as part of updating the posts selection
- (void)setSelectedIndexes:(NSIndexSet *)indexset
{
	if (![indexset isEqualToIndexSet:selectedIndexes])
	{
		selectedIndexes = [indexset copy];
		[self setSelectedImages:[links objectsAtIndexes:selectedIndexes]];
		
		// update our tags array with the tags that are 
		// shared by all selected images
		NSMutableSet *tempSet = [NSMutableSet set];
		for (FRPostedImage *selected in selectedImages)
		{
			[tempSet unionSet:[selected tags]];
			[tempSet intersectSet:[selected tags]];
		}

		[self setTagsOfSelectedImages:[NSMutableArray arrayWithArray:[tempSet allObjects]]];
		
		// if a single image is selected, diplay it in the preview panel
		// otherwise clear the view
		if ([indexset count] == 1) 
		{
			// a block to read the image from disk and then
			// change the image in the preview view
			void (^getImageFromDisk)(void) = ^(void)
			{
				FRPostedImage *im = [[self selectedImages] lastObject];
				NSURL *theURL = [im localURL];
				NSImage *new = [[NSImage alloc] initWithContentsOfURL:theURL];
				
				// make sure the image size is as big as possible
				// (needed since some image have sizes that differ 
				// from their pixel dimensions)
				[new setSize:[im size]];
				
				[self performSelectorOnMainThread:@selector(changePreviewImageTo:)
									   withObject:new 
									waitUntilDone:YES];
				[self performSelectorOnMainThread:@selector(changeSelectedFileURLTo:)
									   withObject:theURL 
									waitUntilDone:YES];
			};
			
			[prevQueue addOperationWithBlock:getImageFromDisk];
			[saveSelectedButton setEnabled:YES];
		}	
		else 
		{
			// multiple selection or no selection, display nothing
			[self changePreviewImageTo:nil];
			[self changeSelectedFileURLTo:nil];
			
			// make sure save button is in the correct state
			if ([indexset count] == 0)
				[saveSelectedButton setEnabled:NO];
			else
				[saveSelectedButton setEnabled:YES];
		}
		
		if(!selecting)
		{
			// update allPosts selection so the selections stay in sync
			NSMutableIndexSet *newIndexSet = [[NSMutableIndexSet alloc] init];
			NSInteger current_index = [indexset firstIndex];
			while (current_index != NSNotFound)
			{
				NSInteger j = 0;
				NSInteger k = 0;
				for (FRPostedImage *i in allPosts)
				{
					if ([i theImage]) 
					{
						if (j == current_index) 
						{
							[newIndexSet addIndex:k];
							break;
						}
						j++;
					}
					k++;
				}
				current_index = [indexset indexGreaterThanIndex: current_index];
			}
			[fullThreadView setSelectionIndexes:newIndexSet];
		}
	}
}

// update the images being displayed in the right hand side of the app
- (void)changePreviewImageTo:(NSImage *)newImage
{
	[previewViewer setImage:newImage];
}

// tell the imageview the url of the image it is displaying
// so it can use that url for drag operations
- (void)changeSelectedFileURLTo:(NSURL *)aURL
{
	[previewViewer setLocalURLOfImage:aURL];
}

- (void)setSelectedImages:(NSArray *)array
{
	if (array != selectedImages) 
	{
		array = [array copy];
		selectedImages = array;
		[previewPanel reloadData];
	}
}

// -----------------------------------------------------------------------------------------
#pragma mark private

// this provides info that our timer object requires
- (NSDictionary *)userInfo 
{
    return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

// check that the string is a 4chan thread url 
// (does not allow front pages or board pages, only threads)
// other validity of url is not checked
// the aim here is merely to rule out urls
// that are obviously incorrect
- (BOOL)validURL:(NSString *)u
{
	//this should be characters 11 to 19
	NSString *chan = [NSString stringWithString:@"boards.4chan.org"];
	NSRange correct = NSMakeRange(7, 16);
	NSRange no = NSMakeRange(NSNotFound, 0);
	
	NSRange r = [u rangeOfString:chan];
	if (r.location == no.location 
		|| r.location != correct.location
		|| r.length != correct.length)
	{
		return FALSE;
	}
	
	NSString *res = [NSString stringWithString:@"res"];
	NSRange resRange = [u rangeOfString:res];
	if (resRange.location == no.location) 
		return FALSE;
	else
		return TRUE;
}

#pragma mark add posts

// method to use when adding objects to ensure the
// array controller is notified
- (void)addLinksObject:(id)anObject
{
	NSIndexSet *ind = [NSIndexSet indexSetWithIndex:[links count]]; 
	[self willChange:NSKeyValueChangeInsertion valuesAtIndexes:ind forKey:@"links"];
	
	[links addObject:anObject];
	
	// if a scripter has supplied tags and rating, apply them
	if (scriptTags) 
		[self addTags:scriptTags toImages:[NSArray arrayWithObjects:anObject, nil]];
	if (scriptRating) 
		[anObject setRating:[scriptRating doubleValue]];
	
	[self didChange:NSKeyValueChangeInsertion valuesAtIndexes:ind forKey:@"links"];
}

- (void)addPostObject:(id)anObject
{
	NSIndexSet *ind = [NSIndexSet indexSetWithIndex:[allPosts count]]; 
	[self willChange:NSKeyValueChangeInsertion valuesAtIndexes:ind forKey:@"allPosts"];
	[allPosts addObject:anObject];
	[self didChange:NSKeyValueChangeInsertion valuesAtIndexes:ind forKey:@"allPosts"];
}

// -----------------------------------------------------------------------------------
#pragma mark file renaming and saving methods

- (void)save:(NSArray *)images
{	
	NSOpenPanel *oPanel = [NSOpenPanel openPanel];
	[oPanel setCanChooseDirectories:YES];
	[oPanel setCanChooseFiles:NO];
	[oPanel setCanCreateDirectories:YES];
	[oPanel setAllowsMultipleSelection:NO];

	void (^saveTriggerBlock)(NSInteger) = ^(NSInteger result)
	{
		if (result == NSFileHandlingPanelOKButton) 
		{
			[self saveImages:images withURL:[oPanel URL]];
		}
	};
	
	[oPanel beginSheetModalForWindow:theWindow 
				   completionHandler:saveTriggerBlock];
}
	  
// this gets run from a block when user clicks ok in the save sheet
// so ui updates should be run back on the main thread
- (void)saveImages:(NSArray *)images withURL:(NSURL *)target
{
	[self performSelectorOnMainThread:@selector(updateStatusLabel:) withObject:@"Saving…" waitUntilDone:YES];
	NSNumber *current = [NSNumber numberWithDouble:0.0];
	NSNumber *max = [NSNumber numberWithDouble:(double)[images count]];
	NSArray *barStats = [NSArray arrayWithObjects:current, max, nil];
	[self performSelectorOnMainThread:@selector(updateDownloadBar:) 
						   withObject:barStats 
						waitUntilDone:YES];
	
	int numberOfFilesSaved = 0;
	int numberOfTagsUpdated = 0;
	NSFileManager *fm = [[NSFileManager alloc] init];
	
	for (FRPostedImage *i in images)
	{			
		// get our URLs
		NSURL *source = [i localURL];
		NSURL *namedTarget = [target URLByAppendingPathComponent:[i imageName]];
		
		// check if we have already saved this file
		// if we have, only update the tags
		if (![[NSUserDefaults standardUserDefaults] boolForKey:FRResaveKey])
		{
			if ([[i savedURL] isEqual:namedTarget]) 
			{
				[self writeTagsToFile:namedTarget 
								 tags:[i tags] 
							   rating:[i rating]];
				numberOfTagsUpdated++;
				continue;
			}
		}
		
		// attempt copy
		BOOL copied = [self attemptToCopyFileWithFM:fm 
										proposedURL:namedTarget
											 source:source
											   tags:[i tags]
											 rating:[i rating]];
		if (copied) 
		{
			numberOfFilesSaved++;
			[i setSavedURL:namedTarget];
			
			current = [NSNumber numberWithInt:numberOfFilesSaved];
			barStats = [NSArray arrayWithObjects:current, max, nil];
			[self performSelectorOnMainThread:@selector(updateDownloadBar:) 
								   withObject:barStats 
								waitUntilDone:YES];
		}			
	}
	
	if ([images isEqual:links]) // we saved all images, so mark the doc as clean
		[self updateChangeCount:NSChangeCleared];
	
	// update UI to show result
	NSString *s;
	if (numberOfFilesSaved == 1) 
		s = [NSString stringWithFormat:@"Saved %d File.", numberOfFilesSaved];
	else if (numberOfFilesSaved == 0 && numberOfTagsUpdated == 1)
		s = [NSString stringWithFormat:@"Updated Tags on %d File.", numberOfTagsUpdated];
	else if (numberOfFilesSaved == 0 && numberOfTagsUpdated > 1)
		s = [NSString stringWithFormat:@"Updated Tags on %d Files.", numberOfTagsUpdated];
	else
		s = [NSString stringWithFormat:@"Saved %d Files.", numberOfFilesSaved];
	
	[self performSelectorOnMainThread:@selector(updateStatusLabel:) withObject:s waitUntilDone:YES];
	
	if (growling) 
	{
		[GrowlApplicationBridge notifyWithTitle:@"Saved Files"
									description:s
							   notificationName:@"Saved Files"
									   iconData:[NSData data] 
									   priority:0 
									   isSticky:NO 
								   clickContext:nil];
	}
	
	current = [NSNumber numberWithDouble:0.0];
	barStats = [NSArray arrayWithObjects:current, max, nil];
	[self performSelectorOnMainThread:@selector(updateDownloadBar:) 
						   withObject:barStats 
						waitUntilDone:YES];
}

// methods so that we can update the UI from other threads
- (void)updateStatusLabel:(NSString *)newStatus
{
	[statusText setTitleWithMnemonic:newStatus];
	return;
}

- (void)updateDownloadBar:(NSArray *)numbers
{
	[downloadBar setMaxValue:[[numbers lastObject] doubleValue]];
	[downloadBar setDoubleValue:[[numbers objectAtIndex:0] doubleValue]];
	return;
}

// attempt to write file to url
// if a file already exists, a new file is created names original-1.png
// if there is already a numbered file, it will add a number on
// giving original-2.png and original-3.png and so on
// Note: only considers numbers up to 99, after that it will
// start adding -1 again, giving original-100-1.png
- (BOOL)attemptToCopyFileWithFM:(NSFileManager *)fm proposedURL:(NSURL *)url source:(NSURL *)source tags:(NSMutableSet *)tags rating:(double)rating
{
	BOOL written = FALSE;
	// copy file
	NSError *error = nil;
	written = [fm copyItemAtURL:source
						  toURL:url 
						  error:&error];
	
	if (!written) 
	{
		if (error) 
		{
			if ([error code] == 17) // the error code for file already exists
			{
				// file with the same name exists, adjust our url
				NSString *name = [url lastPathComponent];
				
				// remove the extension
				NSArray *arr = [name componentsSeparatedByString:@"."];
				NSString *oldName = [arr objectAtIndex:0];
				
				// check if the name already has a number on the end
				// check for one or two digit numbers on the end
				// otherwise just as "-1"
				BOOL terminalNumberS = FALSE;
				BOOL terminalNumberD = FALSE;
				if ([oldName characterAtIndex:[oldName length]-2] == 45
					&& [oldName characterAtIndex:[oldName length]-1] > 47
					&& [oldName characterAtIndex:[oldName length]-1] < 58) 
					terminalNumberS = TRUE;
				else if ([oldName characterAtIndex:[oldName length]-3] == 45
						 && [oldName characterAtIndex:[oldName length]-2] > 47
						 && [oldName characterAtIndex:[oldName length]-2] < 58
						 && [oldName characterAtIndex:[oldName length]-1] > 47
						 && [oldName characterAtIndex:[oldName length]-1] < 58) 
					terminalNumberD = TRUE;
				
				NSString *newName;
				if (terminalNumberS) 
					newName = [self incrementSingleLastNumber:oldName];
				else if (terminalNumberD)
					newName = [self incrementDoubleLastNumber:oldName];
				else
					newName = [oldName stringByAppendingString:@"-1"];
				
				// add the extension back on and recreate the URL
				NSString *dot = [newName stringByAppendingString:@"."];
				NSString *new = [dot stringByAppendingString:[arr lastObject]];
				NSURL *oldBase = [url URLByDeletingLastPathComponent];
				NSURL *newURL = [oldBase URLByAppendingPathComponent:new];
				
				// try again with new URL
				written = [self attemptToCopyFileWithFM:fm 
											proposedURL:newURL
												 source:source
												   tags:tags
												 rating:rating];
			}
			else 
			{
				// some other unknown error, just alert the user
				[[NSAlert alertWithError:error] runModal];
			}
		}
	}
	else // files were written, so add the tags
		[self writeTagsToFile:url tags:tags rating:rating];

	return written;
}

// write openmeta tags to a file
- (void)writeTagsToFile:(NSURL *)url tags:(NSMutableSet *)tags rating:(double)rating
{
	if (rating <= 0.0)
		rating = 0.0;
	if (rating > 5.0)
		rating = 5.0;
	
	NSError *ratingError = [OpenMeta setRating:rating path:[url path]];
	if (rating > 0.0) // problem with openmeta - it will return an error when setting ratings to 0.0, so we ignore it
	{
		if (ratingError)
			NSLog(@"error adding rating to file: %@ reason: %@", url, ratingError);
	}
	
	// convert our array of tag objects into an array of strings
	NSMutableArray *tempTagArray = [NSMutableArray array];
	for (tag *t in tags)
		[tempTagArray addObject:[t tagString]];
	
	NSError *tagerror = [OpenMeta setUserTags:tempTagArray path:[url path]];
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:FRFinderCommentKey]) 
		[self writeFinderCommentToFile:url tags:tempTagArray];
	
	if (tagerror) 
		NSLog(@"Error setting tags on %@ reason: %@", url, tagerror);
}

- (void)writeFinderCommentToFile:(NSURL *)url tags:(NSMutableArray *)tags
{
	int result;
	NSString *name = @"com.apple.metadata:kMDItemFinderComment";
	NSString *path = [url path];
	
	// turn the array of comments into a single string, each item prefixed 
	// by the user set prefix
	NSString *prefix = [[NSUserDefaults standardUserDefaults] stringForKey:FRCommentTagPrefix];
	NSMutableString *comment = [NSMutableString string];
	for	(NSString *aTag in tags)
	{
		[comment appendString:prefix];
		[comment appendString:aTag];
		[comment appendString:@" "];
	}
	
	NSString *errorString = nil;
	NSData *data = [NSPropertyListSerialization dataFromPropertyList:comment
															  format:kCFPropertyListBinaryFormat_v1_0 
													errorDescription:&errorString];
	if (!data)
	{
		if (errorString)
			NSLog(@"Failed to convert string of tags into binary plist: %@", errorString);
	}
	else 
	{
		result = setxattr([path fileSystemRepresentation], [name fileSystemRepresentation], 
						  [data bytes], [data length], 0, XATTR_NOFOLLOW);
		if (result != 0)
			NSLog(@"Error writing spotlight comment to file: %@", path);
	}
}

// method used for renaming files when there
// is already a single number digit
- (NSString *)incrementSingleLastNumber:(NSString *)input
{
	NSRange numRange = NSMakeRange([input length]-1, 1);
	
	NSString *n = [input substringWithRange:numRange];
	int oldNum = [n intValue];
	
	NSString *temp = [input substringToIndex:[input length]-1];
	NSString *new = [temp stringByAppendingFormat:@"%d", oldNum+1];
	return new;
}

// method used for renaming files when there are
// two number digits
- (NSString *)incrementDoubleLastNumber:(NSString *)input
{
	NSRange numRange = NSMakeRange([input length]-2, 2);
	
	NSString *n = [input substringWithRange:numRange];
	int oldNum = [n intValue];
	
	NSString *temp = [input substringToIndex:[input length]-2];
	NSString *new = [temp stringByAppendingFormat:@"%d", oldNum+1];
	return new;
}

// this is run by the default "do you want to save" sheet that appears when closing a document
// with unsaved changes (if the user clicks save)
- (void)saveDocumentWithDelegate:(id)delegate didSaveSelector:(SEL)didSaveSelector contextInfo:(void *)contextInfo
{
	[self save:links];
	if ([delegate respondsToSelector:didSaveSelector]) 
	{
		void (*delegateMethod)(id, SEL, id, BOOL, void *);
		delegateMethod = (void (*)(id, SEL, id, BOOL, void *))[delegate methodForSelector:didSaveSelector];
		delegateMethod(delegate, didSaveSelector, self, YES, contextInfo);
	}
}

// ------------------------------------------------------------------------------------
#pragma mark action methods

// get the url of the front webkit, safari or firefox page
// looks for webkit first, then safari then firefox
- (IBAction)fetchBrowserURL:(id)sender
{
	// TODO: support more browsers.
	id url = nil;
	NSError *error = nil;
	
	if ([webkit isRunning]) 
	{
		WKReference *docRef = [[webkit documents] at:1];
		url = [[[docRef URL] get] sendWithError:&error];
	}
	else if ([safari isRunning]) 
	{
		SFReference *docRef = [[safari documents] at:1];
		url = [[[docRef URL] get] sendWithError:&error];
	}
	else  // begin pile of shit required by failfox
	{
		if (!firefox)
			firefox = [[FRApplication alloc] initWithBundleID:@"org.mozilla.firefox"];
		if (!systemEvents)
			systemEvents = [[SEApplication alloc] initWithName:@"System Events"];
		
		if ([firefox isRunning])
		{
			// we will use systemevents to manually copy the url from firefox,
			// since it has no applescript suppport. well done failfox
			[[firefox activate] sendWithError:&error];
			if (error) 
				NSLog(@"Error activating firefox");
			else 
			{
				// switch to the addressbar and copy the url
				[[[systemEvents keystroke: @"l"] using:[SEConstant commandDown]] send];
				[[[systemEvents keystroke: @"c"] using:[SEConstant commandDown]] send];
				
				// get the url from the pasteboard
				NSPasteboard *pb = [NSPasteboard generalPasteboard];
				NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
				NSDictionary *options = [NSDictionary dictionary];
				NSArray *copiedItems = [pb readObjectsForClasses:classes 
														 options:options];
				url = [copiedItems lastObject];
				
				// bring ourselves back to the front
				[NSApp activateIgnoringOtherApps:YES];
				[[[self windowControllers] lastObject] showWindow:self]; // does this work properly when
																		 // there are several windows open?
			}
		}
	}
	
	if (url)
	{
		NSString *browserURLString = [NSString stringWithFormat:@"%@", url];
		
		// check the url is a 4chan url
		if ([self validURL:browserURLString])
		{
			[URLInput setStringValue:browserURLString];
			[self startFetcher:self];
		}
		else 
		{
			[statusText setTitleWithMnemonic:@"Front window is not a 4chan thread."];
			[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
			[self resetScriptParameters];
		}
	}
	else 
	{
		[statusText setTitleWithMnemonic:@"No browser window open."];
		[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
		[self resetScriptParameters];
		if (error)
			NSLog(@"Error retrieving URL from browser: %@", error);
	}
}

- (IBAction)startFetcher:(id)sender
{
	// get the url the user typed in
	NSString *s = [URLInput stringValue];
	
	// if the urltext box is empty, do nothing
	if ([s length] == 0)
	{
		[statusText setTitleWithMnemonic:@"Please enter a URL."];
		[[URLInput window] makeFirstResponder:URLInput];
		return;
	}
	
	//find out which board we are on
	[self identifyBoard:s];
	
	// check we aren't already fetching images incase this method was called by
	// the timer while a fetch was already happening
	if ([operationQueue operationCount] > 0) 
	{
		if (sender == repeatingTimer) 
			return;
	}
	
	// check that the URL is a 4chan URL
	if (![self validURL:s])
	{
		[statusText setTitleWithMnemonic:@"Not a 4chan thread URL."];
		return;
	}
	
	// record how many images we already have
	numberBeforeDownload = [links count];
	numberPostsBeforeDownload = [allPosts count];
	
	// go fetch the images on another thread
	fetcher = [[FRLinkFetcher alloc] initWithURLString:s 
											  delegate:self
											 directory:tempDirPath];
	[fetcher setDownloadBar:smallDownloadBar];
	[operationQueue addOperation:fetcher];
	
	// set first responder to the collectionview to make
	// using quicklook easier and avoid extra input into url text box
	[[ourCollectionView window] makeFirstResponder:ourCollectionView];
}


// save all images
- (IBAction)saveFiles:(id)sender
{
	[self save:[self links]];
}

// save selected images
- (IBAction)saveSelected:(id)sender
{
	[self save:[self selectedImages]];
}

// action that is run when the user clicks the watch thread checkbox
- (IBAction)toggleTimer:(id)sender
{
	if ([timerToggleCheckBox state] == NSOnState) 
	{
		double interval = [[NSUserDefaults standardUserDefaults] boolForKey:FRIntervalKey];
		NSTimeInterval t = interval * 60.0; // t is in seconds, interval is in mins
		if (!repeatingTimer) 
		{
			NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:t 
															  target:self
															selector:@selector(startFetcher:)
															userInfo:[self userInfo]
															 repeats:YES];
			[self setRepeatingTimer:timer];
		}

		[timerSpinner startAnimation:self];
	}
	else if ([timerToggleCheckBox state] == NSOffState)
	{
		// if the user started the timer from a script
		// but then manually turned it off, automatic saving is turned off
		[self resetScriptParameters];
		
		[[self repeatingTimer] invalidate];
		[self setRepeatingTimer:nil];
		[timerSpinner stopAnimation:self];
	}
}

// cancel file downloads
- (IBAction)cancel:(id)sender
{
	// tell the FRLinkFetcher operation to cancel.
	// don't update the UI yet, we let the FRLinkFetcher 
	// do that when it has cancelled itself
	if ([operationQueue operationCount] > 0) 
		[statusText setTitleWithMnemonic:@"Cancelling…"];
	
	[operationQueue cancelAllOperations];
}

// clears all tags on the FRPostedImage objects, and if they have been saved
// clears the tags on the saved files
- (IBAction)clearAllTags:(id)sender
{
	[self setTagsOfSelectedImages:[NSMutableArray array]];
	[self willChangeValueForKey:@"links"];
	for (FRPostedImage *i in links)
	{
		[i setTags:[NSMutableSet set]];
		if ([i savedURL]) 
		{
			[self writeTagsToFile:[i savedURL] 
							 tags:[NSMutableSet set]
						   rating:[i rating]];
		}
	}
	[self didChangeValueForKey:@"links"];
}

// clear the tags on the selected images, and any tags
// on the files if they have been written
- (IBAction)clearSelectedTags:(id)sender
{
	[self setTagsOfSelectedImages:[NSMutableArray array]];
	[self willChangeValueForKey:@"links"];
	for (FRPostedImage *i in selectedImages)
	{
		[i setTags:[NSMutableSet set]];
		if ([i savedURL]) 
		{
			[self writeTagsToFile:[i savedURL] 
							 tags:[NSMutableSet set]
						   rating:[i rating]];
		}
	}
	[self didChangeValueForKey:@"links"];
}

// -------------------------------------------------------------------------
#pragma mark list/icon view switching

- (IBAction)changeViewClicked:(id)sender
{
	int clickedSegment = [sender selectedSegment];
	if (clickedSegment == 0) 
	{
		[viewSwitcher selectFirstTabViewItem:sender];
		[theWindow makeFirstResponder:ourCollectionView];
	}
	else if (clickedSegment == 1)
	{
		[viewSwitcher selectLastTabViewItem:sender];
		[theWindow makeFirstResponder:fullThreadView];
	}
}

- (void)switchToIconView:(id)sender
{
	[viewToggle setSelectedSegment:0];
	[viewSwitcher selectFirstTabViewItem:sender];
	[theWindow makeFirstResponder:ourCollectionView];
}

- (void)switchToFullThreadView:(id)sender
{
	[viewToggle setSelectedSegment:1];
	[viewSwitcher selectLastTabViewItem:sender];
	[theWindow makeFirstResponder:fullThreadView];
}


// --------------------------------------------------------------------------------------
#pragma mark scripting methods

- (void)applescriptGetURL:(NSScriptCommand *)command
{
	if ([command isWellFormed]) 
	{
		NSScriptCommandDescription *desc = [command commandDescription];
		NSString *comName = [desc commandName];
		
		NSDictionary *args = [command evaluatedArguments];
		scriptSaveLocation = [args objectForKey:@"ToLocation"];
		scriptSaveSheet = [[args objectForKey:@"WantSaveSheet"] boolValue];

		[self checkForTags:args];
		[self checkForRating:args];
		
		if ([comName isEqual:@"fetchThreadFromBrowser"])
		{
			[self fetchBrowserURL:self];
		}
		else if ([comName isEqual:@"watchThreadFromBrowser"]) 
		{
			willSave = TRUE;
			[self fetchBrowserURL:self];
			[timerToggleCheckBox setState:NSOnState];
			[self toggleTimer:self];
		}
	}
	else
		NSLog(@"applescript command was not well formed"); // we should return a proper error to the applescripter here
}

- (void)checkForTags:(NSDictionary *)args
{
	NSString *scriptTagString = [args objectForKey:@"Tags"];
	NSArray *scriptTagArray;
	
	if (scriptTagString) 
		scriptTagArray = [scriptTagString componentsSeparatedByString:@", "];
	else 
		scriptTagArray = [args objectForKey:@"TagList"];
	
	if (scriptTagArray) 
	{
		scriptTags = [[NSMutableArray alloc] init];
		
		for (NSString *t in scriptTagArray)
		{
			tag *atag = [[tag alloc] init];
			[atag setTagString:t];
			[scriptTags addObject:atag];
		}
	}
}

- (void)checkForRating:(NSDictionary *)args
{
	scriptRating = [args objectForKey:@"Rating"];
	
	if (scriptRating)
	{
		if ([scriptRating doubleValue] > 5.0) 
			scriptRating = [NSNumber numberWithDouble:5.0];
	}
}

- (void)scriptSaveAll:(NSScriptCommand *)command
{
	if ([command isWellFormed]) 
	{
		NSDictionary *args = [command evaluatedArguments];
		scriptSaveLocation = [args objectForKey:@"ToLocation"];
		
		[self checkForTags:args];
		[self checkForRating:args];
		[self addScriptTagsToAllImages];
		[self addScriptRatingToAllImages];
		
		if (scriptSaveLocation) 
		{
			[self saveImages:links withURL:scriptSaveLocation];
			scriptSaveLocation = nil;
		}
		else
			[self save:links];
	}
	else
		NSLog(@"applescript command was not well formed"); // we should return a proper error to the applescripter here
}

- (void)scriptFetch:(NSScriptCommand *)command
{
	if ([command isWellFormed]) 
	{
		NSDictionary *args = [command evaluatedArguments];
		NSString *scriptURL = [args objectForKey:@"URL"];
		scriptSaveLocation = [args objectForKey:@"ToLocation"];
		scriptSaveSheet = [[args objectForKey:@"WantSaveSheet"] boolValue];
		
		if (scriptSaveLocation)
			[URLInput setStringValue:scriptURL];
		
		[self checkForTags:args];
		[self checkForRating:args];
		
		if ([args objectForKey:@"Watch"]) 
		{
			willSave = [[args objectForKey:@"Watch"] boolValue];
			[timerToggleCheckBox setState:NSOnState];
			[self toggleTimer:self];
		}
		
		[self startFetcher:self];
	}
	else
		NSLog(@"applescript command was not well formed"); // we should return a proper error to the applescripter here
}
					  
- (void)resetScriptParameters
{
	willSave = FALSE;
	scriptSaveSheet = FALSE;
	scriptSaveLocation = nil;
	scriptTags = nil;
}

// ---------------------------------------------------------------------------------------
#pragma mark FRLinkFetcherDelegate methods

- (void)addNewImage:(id)i
{	
	// get the existing number in the dock badge
	// (we can't use 'numberBeforeDownload' since there 
	// may be other windows open)
	NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
	NSString *oldBadge = [tile badgeLabel];
	unsigned int oldNumber;
	if (oldBadge == nil || [oldBadge length] == 0)
		 oldNumber = 0;
	else 
		oldNumber = [oldBadge intValue];
	
	if ([i class] == [FRPostedImage class]) 
	{
		// add the object to our arrays
		if ([i theImage]) 
			[self addLinksObject:i];
		
		[self addPostObject:i];
		[fullThreadView setContent:allPosts];
		
		[downloadBar incrementBy:1.0];
		[self setSizeOfAllFiles:(sizeOfAllFiles+[i filebytes])];
		[saveButton setEnabled:YES];
		
		if ([links count] == 1)
		{
			NSString *newLabel = [NSString stringWithFormat:
								  @"1 Image, %@", [FRPostedImage stringFromFileSize:[i filebytes]]];
			[numberOfImages setTitleWithMnemonic:newLabel];
		}
		else
		{
			NSString *newLabel = [NSString stringWithFormat:
								  @"%d Images, %@", [links count],
								  [FRPostedImage stringFromFileSize:[self sizeOfAllFiles]]];
			[numberOfImages setTitleWithMnemonic:newLabel];
		}
		
		// update dock badge if we added a new image, and we are not the main window
		if (![theWindow isMainWindow] && [i theImage]) // should we update for new text only posts as well?
		{
			oldNumber++;
			newImages++;
			NSString *newBadge = [NSString stringWithFormat:@"%d", oldNumber];
			[tile setBadgeLabel:newBadge];
		}
		
		// increment change count, to make sure document gets marked as drity
		[self updateChangeCount:NSChangeDone];
	}
}

// methods to update UI to show we are working
- (void)loadingPage
{
	[goButton setImage:[NSImage imageNamed:NSImageNameStopProgressTemplate]];
	[goButton setAction:@selector(cancel:)];
	[progressSpinner startAnimation:self];
	[statusText setTitleWithMnemonic:@"Fetching Page…"];
}

// method to run when the page has been parsed and
// we are about to start downlaoding images
- (void)pageWasLoaded:(NSNumber *)max
{
	double newnum;
	// if max is smaller, the user probably
	// changed the url to a different thread
	// so show show full progress, otherwise, 
	// try to show how many additional files are going to be downloaded
	if ([max doubleValue] < [links count]) 
		newnum = [max doubleValue];
	else 
		newnum = [max doubleValue] - (double)[allPosts count];
	
	[statusText setTitleWithMnemonic:@"Images found, downloading…"];
	[downloadBar setMinValue:0];
	[downloadBar setMaxValue:newnum];
	[downloadBar setDoubleValue:0.0];
	[postButton setEnabled:YES];
}

// run when finished downloading all images
- (void)fetchedAllImages
{
	[progressSpinner stopAnimation:self];
	[downloadBar setMaxValue:1.0];
	[downloadBar setDoubleValue:1.0];
	[smallDownloadBar setDoubleValue:0.0];
	[goButton setImage:[NSImage imageNamed:NSImageNameRefreshTemplate]];
	[goButton setAction:@selector(startFetcher:)];
	if ([allPosts count] > numberPostsBeforeDownload)
	{
		int numDownloaded = [links count] - numberBeforeDownload;
		int numPostsDownloaded = [allPosts count] - numberPostsBeforeDownload;
		numberBeforeDownload = [links count];
		numberPostsBeforeDownload = [allPosts count];
		
		NSString *growlstat = [NSString stringWithFormat:
						  @"%d new posts.\r Downloaded %d images.", numPostsDownloaded, numDownloaded];
		NSString *stat= [NSString stringWithFormat: @"Downloaded %d images.", numDownloaded];
		[statusText setTitleWithMnemonic:stat];
		if (growling) 
		{
			[GrowlApplicationBridge notifyWithTitle:[self threadName]
										description:growlstat
								   notificationName:@"Downloaded all images" 
										   iconData:[NSData data] 
										   priority:0 
										   isSticky:NO 
									   clickContext:nil];
		}
		
		// check if extra parameters were provided with a script command
		if (scriptSaveSheet)
			[self save:links];
		else if (scriptSaveLocation)
		{
			// scripter provided folder to save to
			[self saveImages:links 
					 withURL:scriptSaveLocation];
		}
		// reset the location unless we are watching the thread
		if (!willSave)
			scriptSaveLocation = nil;
	}
	else 
	{
		[statusText setTitleWithMnemonic:@"No new images to download."];
		if (!willSave) 
			[self resetScriptParameters];
	}
}

// if we found a title for the thread
// we return it here so we can use it for the window title
-(void)setWindowNameTo:(NSString *)n
{
	[self setValue:n
			forKey:@"threadName"];
}

// this method is run when FRLinkFetcher encounters a problem
// or when it has been cancelled (this should be renamed to reflect its use
// during cancelling)
- (void)returnedError:(NSString *)errorMessage
{
	[progressSpinner stopAnimation:self];
	[downloadBar setDoubleValue:0.0];
	[goButton setImage:[NSImage imageNamed:NSImageNameRefreshTemplate]];
	[statusText setTitleWithMnemonic:errorMessage];
	[self resetScriptParameters];
	
	// provide additional notification to the user
	if (growling) 
	{
		[GrowlApplicationBridge notifyWithTitle:@"Error"
									description:errorMessage
							   notificationName:@"Error"
									   iconData:[NSData data] 
									   priority:0 
									   isSticky:NO 
								   clickContext:nil];
	}
	[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
}

- (void)wasCancelled
{
	[progressSpinner stopAnimation:self];
	[downloadBar setDoubleValue:0.0];
	[goButton setImage:[NSImage imageNamed:NSImageNameRefreshTemplate]];
	[goButton setAction:@selector(startFetcher:)]; 
	[statusText setTitleWithMnemonic:@"Cancelled."];
	[self resetScriptParameters];
}

- (BOOL)wantsAnimation;
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:FRAnimatedThumbsKey];
}

// ---------------------------------------------------------------------------------------------------------
#pragma mark collectionview delegate methods

// method for allowing dragging files from the collectionview
- (BOOL)collectionView:(NSCollectionView *)collectionView 
   writeItemsAtIndexes:(NSIndexSet *)indexes 
		  toPasteboard:(NSPasteboard *)pasteboard
{
	[pasteboard clearContents];
	[pasteboard declareTypes:[NSArray arrayWithObject:NSFilenamesPboardType]
					   owner:nil];
	
	NSMutableArray *fileList = [[NSMutableArray alloc] init];
	NSArray *draggedObjects = [links objectsAtIndexes:indexes];
	for (FRPostedImage *im in draggedObjects)
	{
		[fileList addObject:[[im localURL] path]];
	}
	
	return [pasteboard setPropertyList:fileList forType:NSFilenamesPboardType];
}
		 
// -----------------------------------------------------------------------------------------------------------
#pragma mark quicklook
// all the delegate methods required for quicklook

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
	return YES;
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
	// we are now responsible for the quicklook panel
	previewPanel = panel;
	[previewPanel setDelegate:self];
	[previewPanel setDataSource:self];
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
    // This document loses its responsisibility for the preview panel
    // Until the next call to -beginPreviewPanelControl: it must not
    // change the panel's delegate, data source or refresh it.
    previewPanel = nil;
}

- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
	return [selectedImages count];
}

- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)anindex
{
	return [selectedImages objectAtIndex:anindex];
}

- (BOOL)previewPanel:(QLPreviewPanel *)panel handleEvent:(NSEvent *)event
{
    // redirect all key down events to the appropriate collectionview
    if ([event type] == NSKeyDown) 
	{
		if ([viewSwitcher selectedTabViewItem] == iconTabItem) 
		{
			[ourCollectionView keyDown:event];
			return YES;
		}
		else
		{
			[fullThreadView keyDown:event];
			return YES;
		}
    }
    return NO;
}

// provides the rect on screen from which the quicklook panel will zoom
- (NSRect)previewPanel:(QLPreviewPanel *)panel sourceFrameOnScreenForPreviewItem:(id <QLPreviewItem>)item
{		
	NSInteger indexu = [links indexOfObject:item];
	if (indexu == NSNotFound) 
		return NSZeroRect;
	
	if ([viewSwitcher selectedTabViewItem] == [viewSwitcher tabViewItemAtIndex:0]) 
	{
		NSRect iconRect = [ourCollectionView frameForItemAtIndex:indexu];
		
		// check that the icon rect is visible on screen
		NSRect visibleRect = [ourCollectionView visibleRect];
		if (!NSIntersectsRect(visibleRect, iconRect)) 
			return NSZeroRect;
		
		// convert icon rect to screen coordinates
		// since our collectionview is using a coreimage backing layer, we have to manually 
		// convert through the scrollview and adjust the mosition for some reason.
		// (there must be a proper way to convert the co-ordinates, but this works ok for now)
		
		iconRect = [ourScrollView convertRect:iconRect fromView:ourCollectionView];
		iconRect = [ourScrollView convertRectToBase:iconRect];
		iconRect.origin = [[ourScrollView window] convertBaseToScreen:iconRect.origin];
		
		NSSize imageSize = [[(FRPostedImage *)item theImage] size];
		iconRect.size = imageSize;
		
		int x = 49 - (imageSize.width / 2);
		int y = 49 - (imageSize.height / 2);
		
		// if these number seem arbritrary, it's because they are...
		iconRect.origin.y = iconRect.origin.y + y + 121;
		iconRect.origin.x = iconRect.origin.x + x + 17;
		
		return iconRect;
	}
	
	return NSZeroRect;
}

// provides the panel with an icon image for the transition
- (id)previewPanel:(QLPreviewPanel *)panel transitionImageForPreviewItem:(id <QLPreviewItem>)item contentRect:(NSRect *)contentRect
{
	FRPostedImage *theItem = (FRPostedImage *)item;
	return [theItem theImage];
}

// --------------------------------------------------------------------------------------
#pragma mark tags

- (IBAction)showTagsSheet:(id)sender
{
	[NSApp beginSheet:tagsSheet
	   modalForWindow:theWindow
		modalDelegate:nil
	   didEndSelector:NULL
		  contextInfo:NULL];
}

- (IBAction)endTagsSheet:(id)sender
{
	// end any editing
	[tagsSheet makeFirstResponder:tagsSheet];

	[NSApp endSheet:tagsSheet];
	[tagsSheet orderOut:sender];
	
	// update the selected images with the new added tags
	[self addTags:tagsOfSelectedImages toImages:selectedImages];
	
	// remove items from undo manager, since they only apply to 
	// editing tags (will need to change this to use an undo group or something
	// if we start using the undo manager elsewhere)
	[[self undoManager] removeAllActions];
}

// runs when user clicks the +/- segmented button
// we have to work out which segment they clicked on
- (IBAction)addRemoveTagWasClicked:(id)sender
{
	// in segmented control, 0 is add, 1 is remove
	int clickedSegment = [sender selectedSegment];
	if (clickedSegment == 0) 
		[self createTag:sender];
	else if (clickedSegment == 1)
		[tagsController remove:sender];
}

// set new tags on selected images.
- (void)setTagsOfSelectedImages:(NSMutableArray *)newArray
{
	if (newArray == tagsOfSelectedImages)
		return;
	
	tagsOfSelectedImages = newArray;
	
	for (tag *t in tagsOfSelectedImages)
		[self startObservingTag:t];
	
	for (FRPostedImage *selected in selectedImages)
		[selected setTags:[NSSet setWithArray:tagsOfSelectedImages]];
}

- (void)addScriptTagsToAllImages
{
	if (scriptTags)
	{
		[self addTags:scriptTags toImages:links];
	}
}

- (void)addScriptRatingToAllImages
{
	if (scriptRating) 
	{
		[self willChangeValueForKey:@"links"];
		for (FRPostedImage *i in links)
		{
			[i setRating:[scriptRating doubleValue]];
		}
		[self didChangeValueForKey:@"links"];
	}
}

// method where we update the tags on images
- (void)addTags:(NSMutableArray *)newTags toImages:(NSArray *)targetImages
{
	[self willChangeValueForKey:@"links"];
	for (FRPostedImage *im in targetImages)
	{
		NSMutableSet *oldTags = [im tags];
		[oldTags addObjectsFromArray:newTags];
		if (removedTags)
			[oldTags minusSet:removedTags];
		[im tagsWereUpdated];
	}
	[removedTags removeAllObjects];
	[self didChangeValueForKey:@"links"];
}

- (void)insertObject:(tag *)t inTagsOfSelectedImagesAtIndex:(int)indexu
{
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] removeObjectFromTagsOfSelectedImagesAtIndex:indexu];
	if (![undo isUndoing]) 
		[undo setActionName:@"Add Tag"];
	
	if ([undo isRedoing]) // we are redoing (adding back a removed tag)
		[removedTags removeObject:t];
	
	[self startObservingTag:t];
	[tagsOfSelectedImages insertObject:t atIndex:indexu];
}

- (void)removeObjectFromTagsOfSelectedImagesAtIndex:(int)indexu
{
	tag *t = [tagsOfSelectedImages objectAtIndex:indexu];
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] insertObject:t inTagsOfSelectedImagesAtIndex:(int)indexu];
	if (![undo isUndoing]) 
		[undo setActionName:@"Remove Tag"];
	
	[self startObservingTag:t];
	[self stopObservingTag:t];
	[tagsOfSelectedImages removeObjectAtIndex:indexu];
	
	[removedTags addObject:t];
}

- (void)startObservingTag:(tag *)t
{
	[t addObserver:self
		forKeyPath:@"tagString" 
		   options:NSKeyValueObservingOptionOld 
		   context:NULL];
}

- (void)stopObservingTag:(tag *)t
{
	[t removeObserver:self forKeyPath:@"tagString"];
}

- (void)changeKeyPath:(NSString *)keyPath
			 ofObject:(id)obj
			  toValue:(id)newValue
{
	//setValue:forKeyPath: will cause the key-value observing method
	//to be called, which takes care of the undo stuff
	[obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
	
    if (oldValue == [NSNull null])
	{
        oldValue = nil;
    }
	[[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
												  ofObject:object
												   toValue:oldValue];
    [undo setActionName:@"Edit"];
}

-(IBAction)createTag:(id)sender
{
	// end any editing
	[tagsSheet makeFirstResponder:tagsSheet];
	
	NSUndoManager *undo = [self undoManager];
	
	// has an edit aleady occured?
	if ([undo groupingLevel])
	{
		//close the last group
		[undo endUndoGrouping];
		//open a new group
		[undo beginUndoGrouping];
	}
	
	tag *t = [tagsController newObject];
	
	[tagsController addObject:t];
	[tagsController rearrangeObjects];
	
	// begin editing the newly added tag
	NSArray *sorted = [tagsController arrangedObjects];
	int row = [sorted indexOfObjectIdenticalTo:t];
	[tagTableView editColumn:0
						 row:row
				   withEvent:nil
					  select:YES];
}

// --------------------------------------------------------------------------------------
#pragma mark toolbar delegate methods

/*!
    @method     
    @abstract   toolbar delegate method
    @discussion returns array of allowed toolbar items
*/
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	NSArray *items = [NSArray arrayWithObjects:@"viewSwitcherTB", @"urlTB", @"goTB", @"quicklookTB", 
					  @"saveTB", @"saveAllTB", @"postReply", NSToolbarFlexibleSpaceItemIdentifier, 
					  @"watchingTB", nil];
	return items;
}

/*!
    @method     
    @abstract   returns list of toolbar identifiers
    @discussion returns list of toolbar identifiers
*/
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	NSArray *defaultItems = [NSArray arrayWithObjects:@"viewSwitcherTB", @"urlTB", @"goTB", @"quicklookTB", 
							 @"saveTB", @"saveAllTB", @"postReply", NSToolbarFlexibleSpaceItemIdentifier, 
							 @"watchingTB", nil];
	return defaultItems;
}

/*!
    @method     
    @abstract   prepare toolbar items
    @discussion constructs the toolbar items as they are requested
*/
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar 
	 itemForItemIdentifier:(NSString *)itemIdentifier 
 willBeInsertedIntoToolbar:(BOOL)flag
{
	if (itemIdentifier == @"viewSwitcherTB") 
	{
		viewSwitcherToolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"viewSwitcherTB"];
		[viewSwitcherToolbarItem setView:viewSwitcherToolbarView];
		[viewSwitcherToolbarItem setLabel:@"View"];
		[viewSwitcherToolbarItem setMaxSize:NSMakeSize(67.0, 25.0)];
		[viewSwitcherToolbarItem setMinSize:NSMakeSize(67.0, 25.0)];
		return viewSwitcherToolbarItem;
	}
	if (itemIdentifier == @"urlTB") 
	{
		urlToolbar = [[NSToolbarItem alloc] initWithItemIdentifier:@"urlTB"];
		[urlToolbar setView:urlTextBoxView];
		[urlToolbar setLabel:@"Thread URL"];
		[urlToolbar setMaxSize:NSMakeSize(374.0, 25.0)];
		[urlToolbar setMinSize:NSMakeSize(374.0, 22.0)];
		return urlToolbar;
	}
	if (itemIdentifier == @"goTB") 
	{
		goToolbarButton = [[NSToolbarItem alloc] initWithItemIdentifier:@"goTB"];
		NSImage *icon = [NSImage imageNamed:NSImageNameRefreshTemplate];
		[goButton setImage:icon];
		[goToolbarButton setView:goToolbarView];
		[goToolbarButton setMaxSize:NSMakeSize(60.0, 25.0)];
		[goToolbarButton setMinSize:NSMakeSize(60.0, 25.0)];
		return goToolbarButton;
	}
	if (itemIdentifier == @"watchingTB") 
	{
		watchingToolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"watchingTB"];
		[watchingToolbarItem setView:watchingToolbarView];
		[watchingToolbarItem setMaxSize:NSMakeSize(80.0, 22.0)];
		[watchingToolbarItem setMinSize:NSMakeSize(80.0, 22.0)];
		[watchingToolbarItem setLabel:@"Watch Thread"];
		return watchingToolbarItem;
	}
	if (itemIdentifier == @"saveTB") 
	{
		saveToolbarButton = [[NSToolbarItem alloc] initWithItemIdentifier:@"saveTB"];
		[saveToolbarButton setView:saveToolbarView];
		[saveToolbarButton setLabel:@"Save"];
		[saveToolbarButton setMaxSize:NSMakeSize(38.0, 25.0)];
		[saveToolbarButton setMinSize:NSMakeSize(38.0, 25.0)];
		return saveToolbarButton;
	}
	if (itemIdentifier == @"saveAllTB") 
	{
		saveAllToolbarButton = [[NSToolbarItem alloc] initWithItemIdentifier:@"saveAllTB"];
		[saveAllToolbarButton setView:saveAllToolbarView];
		[saveAllToolbarButton setLabel:@"Save All"];
		[saveAllToolbarButton setMaxSize:NSMakeSize(38.0, 25.0)];
		[saveAllToolbarButton setMinSize:NSMakeSize(38.0, 25.0)];
		return saveAllToolbarButton;
	}
	if (itemIdentifier == @"quicklookTB") 
	{
		quicklookToolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"quicklookTB"];
		[quicklookToolbarItem setView:quicklookToolbarView];
		[quicklookToolbarItem setLabel:@"Quicklook"];
		[quicklookToolbarItem setMaxSize:NSMakeSize(38.0, 25.0)];
		[quicklookToolbarItem setMinSize:NSMakeSize(38.0, 25.0)];
		return quicklookToolbarItem;
	}
	if (itemIdentifier == @"postReply") 
	{
		postReplyToolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"postReply"];
		[postReplyToolbarItem setView:postReplyToolbarView];
		[postReplyToolbarItem setLabel:@"Post Reply"];
		[postReplyToolbarItem setMaxSize:NSMakeSize(90.0, 25.0)];
		[postReplyToolbarItem setMinSize:NSMakeSize(90.0, 25.0)];
		return postReplyToolbarItem;
	}
	
	return nil;
}

#pragma mark posting stuff
/*!
    @method     
    @abstract   show the sheet that lets the user post a reply
    @discussion before sheet is shown, the comments field is pre-filled
				with quote strings for the selected images.
				when there is an error the user is given a chance to re-open
				this sheet, in which case the old contents are preserved
*/
- (IBAction)showPostSheet:(id)sender
{
	// if sender is the application delegate, we were told to run this method by growl,
	// which means the user clicks an alert in response to an error
	// and may wish to edit the post, so don't resent info
	if (!(sender == applicationDelegate)) 
	{
		// if imaged are selected, prefill the comment box with
		// quotes of those posts
		if ([selectedPosts count] > 0) 
		{
			NSArray *selected = [allPosts objectsAtIndexes:selectedPosts];
			NSMutableString *newComment = [[NSMutableString alloc] init];
			for (FRPostedImage *i in selected)
			{
				NSString *quoteNum = [i postNumber];
				NSMutableString *quote = [NSMutableString stringWithString:@">>"];
				[quote appendString:quoteNum];
				[newComment appendString:quote];
				[newComment appendString:@"\r"];
			}
			
			[self setPostComment:(NSString *)newComment];
		}
		else 
		{
			// make sure comment field is blank, incase user opened 
			// panel, canceled, deselected, then opened it again
			[self setPostComment:nil];
		}
	}
	
	[NSApp beginSheet:postSheet
	   modalForWindow:theWindow
		modalDelegate:nil
	   didEndSelector:NULL
		  contextInfo:NULL];
	
	[postSheet makeFirstResponder:commentView];
}

/*!
    @method     
    @abstract   close post sheet
    @discussion ends editing, then closes the post sheet
*/
- (IBAction)endPostSheet:(id)sender
{
	// end any editing
	[tagsSheet makeFirstResponder:postSheet];
	
	[NSApp endSheet:postSheet];
	[postSheet orderOut:sender];
}

/*!
    @method     
    @abstract   post a reply
    @discussion work is done on another thread
*/
- (IBAction)postReply:(id)sender
{
	[self endPostSheet:self];
	[postButton setEnabled:NO];
	[replySpinner startAnimation:self];
	
	// big block that does the work of costructing and sending the post
	void (^postImage)(void) = ^(void)
	{
		// check user has enetered a comment or image
		if (![self postComment] && ![imageToPost imageFileURL]) 
		{
			// just do nothing if there was no imput
			[postButton setEnabled:YES];
			[replySpinner stopAnimation:self];
			return;
		}
		
		ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:[self boardPostURL]];
		[postRequest setRequestMethod:@"POST"];
		[postRequest setPostValue:threadNumber forKey:@"resto"];
		[postRequest setPostValue:[[NSUserDefaults standardUserDefaults] stringForKey:FRPostName] forKey:@"name"];
		[postRequest setPostValue:[[NSUserDefaults standardUserDefaults] stringForKey:FRPostEmail] forKey:@"email"];
		[postRequest addRequestHeader:@"User-Agent" 
								value:[[NSUserDefaults standardUserDefaults] stringForKey:FRUserAgent]];
		[postRequest setPostValue:[self postSubject] forKey:@"sub"];
		[postRequest setPostValue:[self postComment] forKey:@"com"];
		if ([imageToPost imageFileURL]) 
		{
			[postRequest setFile:[[imageToPost imageFileURL] path] forKey:@"upfile"];
		}
		[postRequest setPostValue:@"" forKey:@"pwd"];
		[postRequest setPostValue:@"regist" forKey:@"mode"];
		[postRequest setPostValue:@"submit" forKey:@"submit"];
		[postRequest setUseCookiePersistance:NO];
		
		// send the post
		[postRequest startSynchronous];
		
		if ([postRequest error]) 
		{
			NSLog(@"error sending post: %@", [postRequest error]);
			return;
		}
		
		// check what the server sent back to see if the post was accepted
		NSString *response = [postRequest responseString];
		//NSLog(@"%@", response);
		NSRange no = NSMakeRange(NSNotFound, 0);
		NSRange success;
		
		// check for appropriate response, depending on if we posted an iamge
		if ([imageToPost imageFileURL]) 
			success = [response rangeOfString:uploadedResponse];
		else // we didn't post an image
			success = [response rangeOfString:noImageResponse];
		
		if ((success.location == no.location)) 
		{
			// there was some kind of error, so we have to find out what it was
			// this method will provide growl notification as well
			[self uploadErrorTypeFromResponse:response];
		}
		else // post was successful
		{
			// notify the user
			if (growling)
			{
				[GrowlApplicationBridge notifyWithTitle:@"Posted"
											description:@"Your post was sent successfully!"
									   notificationName:@"Post Sent"
											   iconData:[NSData data] 
											   priority:0 
											   isSticky:NO 
										   clickContext:nil];
			}		
			
			// clear the fields in the postSheet, ready for next time
			[self postSent];
		}
		[postButton setEnabled:YES];
		[replySpinner stopAnimation:self];
	};
	
	NSOperationQueue *postQueue = [[NSOperationQueue alloc] init];
	[postQueue addOperationWithBlock:postImage];	
}

/*!
    @method     
    @abstract   determins error type from server response to post attempt
    @discussion provides growl notification, or if growl isnot running, a modal dialog box
*/
- (void)uploadErrorTypeFromResponse:(NSString *)response
{
	NSString *err;
	NSRange no = NSMakeRange(NSNotFound, 0);
	
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
	
	if (dupl.location != no.location)
		err = @"Image was a duplicate. Click to reopen post sheet.";
	else if (flood.location != no.location)
		err = @"Flood detected. Click to reopen post sheet.";
	else if (limit.location != no.location)
		err = @"Thread has reached limit. Click to reopen post sheet.";
	else if (abnormal.location != no.location)
		err = @"Abnormal Reply. Click to reopen post sheet.";
	else if (four.location != no.location)
		err = @"Thread 404'd.  Click to reopen post sheet.";
	else if (nothread.location != no.location)
		err = @"Thread not found.  Click to reopen post sheet.";
	else if (banned.location != no.location)
		err = @"YOU ARE BANNED! Click to reopen post sheet.";
	else if (toolong.location != no.location)
		err = @"Post was too long. Click to reopen post sheet.";
	else if (large.location != no.location)
		err = @"Image was too large. Click to reopen post sheet.";
	else if (malicious.location != no.location)
		err = @"Malicious code in image file. Click to reopen post sheet.";
	else if (highres.location != no.location)
		err = @"Image resolution too large. Click to reopen post sheet.";
	else 
		err = @"Error uploading file. Click to reopen post sheet.";
	
	if (growling) 
	{
		// send growl message with clickback, the data is a pointer to self
		// so the growl delegate knows where to send the message to
		[GrowlApplicationBridge notifyWithTitle:@"Error Sending Post"
									description:err
							   notificationName:@"Post Sent"
									   iconData:[NSData data] 
									   priority:1 
									   isSticky:NO 
								   clickContext:[NSData dataWithBytes:&self length:sizeof(&self)]];
		[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
	}
	else 
	{
		// assume most users have growl, so don't worry too much about
		// the err string not quite applying to a modal dialog
		[NSAlert alertWithMessageText:@"Error sending post" 
						defaultButton:nil 
					  alternateButton:nil 
						  otherButton:nil 
			informativeTextWithFormat:err];
		[self performSelectorOnMainThread:@selector(showPostSheet:) 
							   withObject:self 
							waitUntilDone:NO];
	}
}

/*!
    @method     
    @abstract   clean up post sheet
    @discussion used after a post was sent sucessfully. name & email
				are stored in user defaults and persist across posts
				so are not cleared
*/
- (void)postSent
{
	[imageToPost setImageWithURL:nil];
	[self setPostComment:nil];
	[self setPostSubject:nil];
}

- (void)identifyBoard:(NSString *)s
{
	NSURL *base = [[NSURL URLWithString:s] URLByDeletingLastPathComponent];
	NSMutableString *clean = [FRLinkFetcher cleanBaseURLAsMutableString:base];	
	int length = [clean length];
	if ([clean replaceOccurrencesOfString:@"http://boards.4chan.org/" 
							   withString:@"" 
								  options:NSAnchoredSearch 
									range:NSMakeRange(0, length)])
	{
		// probably still has stuff on the end
		NSArray *components = [clean componentsSeparatedByString:@"/"];
		
		// we are interested in the first part which should be the board name
		// constuct a posting url with it
		NSMutableString *postingURL = [NSMutableString stringWithString:@"http://sys.4chan.org/"];
		[postingURL appendString:[components objectAtIndex:0]];
		[postingURL appendString:@"/imgboard.php"];
		[self setBoardPostURL:[NSURL URLWithString:postingURL]];
	}
	else
		NSLog(@"Error determining board from URL");
}

- (IBAction)clearImageToPost:(id)sender
{
	[imageToPost setImageWithURL:nil];
}

// ------------------------------------------------------------------------------------
#pragma mark window setup

- (NSString *)windowNibName
{
	return @"WatcherDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
	// create the border along the bottom of the window
	// and format the textbox
	[theWindow setContentBorderThickness:24.0 forEdge:NSMinYEdge];
	NSFont *smaller = [NSFont fontWithName:@"Lucida Grande" size:11.0];
	[numberOfImages setFont:smaller];
	[[numberOfImages cell] setBackgroundStyle:NSBackgroundStyleRaised];
	[numberOfImages setTitleWithMnemonic:@"No Images"];
	
	// initalise the toolbar
	theToolbar = [[NSToolbar alloc] initWithIdentifier:@"mainToolbar"];
	[theToolbar setDelegate:self];
	[theToolbar setAllowsUserCustomization:YES];
	[theWindow setToolbar:theToolbar];
	
	// initial states of buttons and text
	[progressSpinner setUsesThreadedAnimation:YES];
	[statusText setTitleWithMnemonic:@""];
	[downloadBar setIndeterminate:FALSE];
	[downloadBar setUsesThreadedAnimation:YES];
	[saveButton setEnabled:NO];
	[saveSelectedButton setEnabled:NO];
	[postButton setEnabled:NO];
	
	[fullThreadView setContent:allPosts];
	[fullThreadView setAllowsMultipleSelection:YES];
	[fullThreadView setDrawsBackground:NO];
	[fullThreadView setRowHeight:143.0];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(selectionDidChange:) 
												 name:AMCollectionViewSelectionDidChangeNotification 
											   object:nil];
	
	// give the IKImageview a blank image on startup
	// to prevent it displaying garbage from the backing store
	// see: http://openradar.appspot.com/7333961
	NSImage *blank = [[NSImage alloc] init];
	[imageToPost setImage:(CGImageRef)blank imageProperties:NULL];
	
    [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain 
										code:unimpErr 
									userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain 
										code:unimpErr 
									userInfo:NULL];
	}
    return YES;
}		

- (void)windowDidBecomeMain:(NSNotification *)notification
{
	NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
	NSString *oldBadge = [tile badgeLabel];
	if (oldBadge) 
	{
		int newNum = [oldBadge intValue] - newImages;
		if (newNum > 0) 
		{
			NSString *newBadge = [NSString stringWithFormat:@"%d", newNum];
			[tile setBadgeLabel:newBadge];
		}
		else 
			[tile setBadgeLabel:nil];
		
		newImages = 0;
	}
}

// -----------------------------------------------------------------------------------------------
#pragma mark splitview delegate methods

// restrict size of bottom half of splitview
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition 
		 ofSubviewAt:(NSInteger)dividerIndex
{
	// minimum size of the top view
	// shouold be total hight of the splitview, minus 82 (the max for the bottom view)
	NSSize splitViewSize = [splitView frame].size;
	int totalHeight = splitViewSize.height;
	
	
	return totalHeight - 83;
}

// allow collapsing of bottom view
- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview
{
	NSView *bottomView = [[splitView subviews] objectAtIndex:1];
	return ([subview isEqual:bottomView]);
}

// allow double click to collapse bottom view
- (BOOL)splitView:(NSSplitView *)splitView shouldCollapseSubview:(NSView *)subview forDoubleClickOnDividerAtIndex:(NSInteger)dividerIndex;
{
    NSView *bottomView = [[splitView subviews] objectAtIndex:1];
	return ([subview isEqual:bottomView]);
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview
{
	if ([[splitView
		  subviews] objectAtIndex:1] == subview) 
		return NO;
	else 
		return YES;
}

// ---------------------------------------------------------------------------------------
#pragma mark menu setup

- (BOOL)validateMenuItem:(NSMenuItem *)theMenuItem
{
	BOOL enabled = TRUE; // default state unless one 
						 // of below criteria is met
	
	// Fetch Images menu item
	if ([theMenuItem action] == @selector(startFetcher:))
	{
		// if we are already fetching, menu is disabled
		if ([operationQueue operationCount] > 0) 
			enabled = FALSE;
	}
	// Cancel Downloads menu item
	if ([theMenuItem action] == @selector(cancel:)) 
	{
		// if we aren't fetching, menu is disabled
		if ([operationQueue operationCount] == 0) 
			enabled = FALSE;
	}
	// Save All… menu item
	if ([theMenuItem action] == @selector(saveFiles:))
	{
		// diable if no images downloaded yet
		if ([links count] == 0) 
			enabled = FALSE;
	}
	// Save Selected… menu item
	if ([theMenuItem action] == @selector(saveSelected:))
	{
		// diable if no images selected
		if ([selectedIndexes count] == 0) 
			enabled = FALSE;
	}
	// Clear All Tags
	if ([theMenuItem action] == @selector(clearAllTags:))
	{
		// diable if no images downloaded
		if ([links count] == 0)
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(clearSelectedTags:))
	{
		// diable if no images selected
		if ([selectedIndexes count] == 0) 
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(showPostSheet:)) 
	{
		// disable if we haven't got a thread to post to yet
		if (threadNumber == nil)
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(switchToIconView:) )
	{
		if ([viewSwitcher selectedTabViewItem] == iconTabItem) 
			[theMenuItem setState:NSOnState];
		else 
			[theMenuItem setState:NSOffState];
	}	
	if ([theMenuItem action] == @selector(switchToFullThreadView:))
	{
		// disable if we are already in full thread view
		if ([viewSwitcher selectedTabViewItem] == iconTabItem) 
			[theMenuItem setState:NSOffState];
		else 
			[theMenuItem setState:NSOnState];
	}
	
	return enabled;
}

// a delegate method for the tags sheet window, so that it uses
// the nsundomanager from WatcherDocument.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
	return [self undoManager];
}

// ------------------------------------------------------------------------------------------------
#pragma mark cleanup 

// runs when the document window closes
- (void)close
{	
	// stop the fetcher
	if (fetcher) 
		[fetcher setDelegate:nil];
	[operationQueue cancelAllOperations];
	
	[self removeDownloadedFiles];
	
	// remove images from this document from the dock badge
	NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
	NSString *oldBadge = [tile badgeLabel];
	if (oldBadge) 
	{
		int newNum = [oldBadge intValue] - newImages;
		if (newNum > 0) 
		{
			NSString *newBadge = [NSString stringWithFormat:@"%d", newNum];
			[tile setBadgeLabel:newBadge];
		}
		else 
			[tile setBadgeLabel:nil];
	}
	
	if ([self repeatingTimer]) 
		[repeatingTimer invalidate];
	
	[[NSGarbageCollector defaultCollector] collectExhaustively]; 
	
	[super close];
}

// clean up the temp directory we created
- (void)removeDownloadedFiles
{
	NSLog(@"Removing Temporary Files");
	NSFileManager *fm = [[NSFileManager alloc] init];
	
	NSError *error = nil;
	if (![fm removeItemAtPath:tempDirPath error:&error]) 
	{
		// ignore the error generated when trying to
		// remove the folder if it doesn't exist
		// (as happens when quiting without downlaoding any files)
		if (![error code] == 4) 
			NSLog(@"Error removing folder: %@", error);
	}
}

// ------------------------------------------------------------------------------------

@synthesize links;
@synthesize threadName;
@synthesize repeatingTimer;
@synthesize fetcher;
@synthesize threadNumber;
@synthesize postComment; 
@synthesize postSubject;
@synthesize selectedImages; 
@synthesize selectedIndexes;
@synthesize sizeOfAllFiles;
@synthesize theWindow;
@synthesize theController;
@synthesize urlTextBoxView;
@synthesize watchingToolbarView; 
@synthesize goToolbarView;
@synthesize saveAllToolbarView;
@synthesize saveToolbarView; 
@synthesize quicklookToolbarView;
@synthesize applicationDelegate;
@synthesize ourCollectionView;
@synthesize ourScrollView;
@synthesize tagsSheet, tagTableView;
@synthesize tagsController;
@synthesize previewViewer;
@synthesize numberOfImages;
@synthesize statusText;
@synthesize downloadBar;
@synthesize timerSpinner;
@synthesize progressSpinner;
@synthesize saveSelectedButton;
@synthesize saveButton;
@synthesize URLInput;
@synthesize boardPostURL;
@synthesize allPosts;
@synthesize selectedPosts;

@end
