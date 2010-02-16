//
//  FRDumpDocument.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 08/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRDumpDocument.h"
#import "FRUploadOperation.h"
#import "FRLinkFetcher.h"
#import "FRPreferenceController.h"
#import "FRAppDelegate.h"
#import "Growl.framework/Headers/GrowlApplicationBridge.h"
#import "FRPostedImage.h"

// initial delay between posts, in seconds
#define DELAY 25
#define BasicTableViewDragAndDropDataType @"FRDragAndDropWithinTable"

// private methods
@interface FRDumpDocument ()

- (void)startNewThreadDump;
- (void)startExistingThreadDump;
- (void)startedThreadDump;
- (void)openDialog;
- (void)addImagesWithURLs:(NSArray *)urls;
- (void)canGo;
- (void)updatedImageTotal;
- (void)postedAll;

// getting post url of board
- (BOOL)findBoardPostURLFromEnteredURL;
- (void)findBoardPostURLFromSelection;
- (void)identifyBoard:(NSString *)s;
- (BOOL)validURL:(NSString *)u;

// table view drag and drop 
- (void)addImageURLsFromDirectory:(NSURL *)dir atIndex:(NSNumber *)indexu;
- (void)addURL:(NSURL *)url atIndex:(NSNumber *)indexu;
- (BOOL)isImageFile:(NSString*)filePath;
- (BOOL)tableView:(NSTableView *)tv didDropRows:(NSIndexSet *)dragged at:(NSInteger)newRow;

// close window stuff
- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
@end

@implementation FRDumpDocument

/*!
	@method		
	@abstract	init method
	@discussion initialise FRDumpDocument
*/
- (id)init
{
	self = [super init];
	if (self) 
	{
		imageURLs = [[NSMutableArray alloc] init];
		appendNumbers = TRUE;
		createNewThreads = TRUE;
		canStart = FALSE;
		
		comment = [NSString stringWithString:@""];
		subject = [NSString stringWithString:@""];
		
		postQueue = [[NSOperationQueue alloc] init];
		[postQueue setMaxConcurrentOperationCount:1];
		
		numberPosted = 0;
		
		// initialise our appscript objects
		safari = [[SFApplication alloc] initWithBundleID:@"com.apple.safari"];
		webkit = [[WKApplication alloc] initWithBundleID:@"org.webkit.nightly.WebKit"];
		firefox = nil;
		systemEvents = nil;
		_moveRows = nil;
		
		growling = [GrowlApplicationBridge isGrowlRunning];
	}
	return self;
}

// ------------------------------------------------------------------------------------------
#pragma mark action methods

/*!
	@method		
	@abstract	start dumping the provided images
	@discussion determines if we are starting a new thread
				or dumping to an existing thread, and creates the FRUploadOperations
				appropriatly
*/
- (IBAction)startDumping:(id)sender
{
	// end any editing that might be happening in the text fields
	[theWindow makeFirstResponder:theWindow];
	
	// find out if we are dumping to a new or existing thread
	NSTabViewItem *selectedTab = [threadTypeTabView selectedTabViewItem];
	
	if (selectedTab == newThreadTab) 
		[self startNewThreadDump];
	else 
	{
		if ([self findBoardPostURLFromEnteredURL])
		{
			[self startExistingThreadDump];
		}
	}
}

/*!
	@defined 
	@abstract	start dump in new thread
	@discussion finds out which board was selected by the user
				then creates and add the first FRUploadOperation to the queue
*/
- (void)startNewThreadDump
{
	[self findBoardPostURLFromSelection];
	if ([self enqueueNextImageWithDelay:DELAY threadNumber:nil])
		[self startedThreadDump];
}

/*!
	@method		
	@abstract	start dump in existing thread
	@discussion alternative to startNewThreadDump that adds the
				user entered thread number to the initial operation object
*/
- (void)startExistingThreadDump
{	
	[self findBoardPostURLFromEnteredURL];
	// get number of thread from the url
	NSString *s = [urlTextBox stringValue];
	NSArray *components = [s componentsSeparatedByString:@"res/"];
	NSArray *numComp =  [[components lastObject] componentsSeparatedByString:@"#"];
	NSString *threadNumber = [numComp objectAtIndex:0];
	
	if ([self enqueueNextImageWithDelay:DELAY threadNumber:threadNumber])
		[self startedThreadDump];
}

/*!
	@method		
	@abstract	method that adds the operations to the queue and actually starts the dump
	@discussion updates the gui elemts to show that we are dumping, before adding all the operations
				to the queue
*/
- (void)startedThreadDump
{
	[startButton setTitle:@"Cancel"];
	[startButton setAction:@selector(cancelDump:)];
	[spinner startAnimation:self];
	[urlTextBox setEnabled:NO];
	[boardSelection setEnabled:NO];
	[overallProgressIndicator setMaxValue:(double)[imageURLs count]];
	[pauseButton setEnabled:YES];
}

/*!
	@method		
	@abstract	cancel current dump
	@discussion cancels the current image dump and updates the gui. all uncomplete operations are
				removed from the queue, and the current operation's isCancelled property
				is set to true. (the operation must check for this)
*/
- (IBAction)cancelDump:(id)sender
{
	[[self postQueue] cancelAllOperations];
	[startButton setTitle:@"Start Dump"];
	[startButton setAction:@selector(startDumping:)];
	[boardSelection setEnabled:YES];
	[spinner stopAnimation:self];
	[urlTextBox setEnabled:YES];
	[feedbackText setTitleWithMnemonic:@"Cancelled"];
	[overallProgressIndicator setDoubleValue:0.0];
	[pauseButton setEnabled:NO];
	numberPosted = 0;
}

/*!
	@method		
	@abstract	pause dump
	@discussion uses the suspend function of the queue to pause dumping
				will not affect the current operation
				sets the isPaused property on the current FRUploadOperation
				so we can indefinatly pause operations that are sleeping
*/
- (IBAction)pauseDump:(id)sender
{
	[[self postQueue] setSuspended:YES];
	// pause current operation
	if ([[self postQueue] operationCount] > 0) 
		[[[[self postQueue] operations] objectAtIndex:0] setIsPaused:YES];
	
	[pauseButton setTitle:@"Resume"];
	[pauseButton setAction:@selector(resumeDump:)];
	[startButton setEnabled:NO];
}

/*!
	@method		
	@abstract	resume dump
	@discussion the opposite of pauseDump, allows us to resume the queue
*/
- (IBAction)resumeDump:(id)sender
{
	[[self postQueue] setSuspended:NO];
	[pauseButton setTitle:@"Pause"];
	[pauseButton setAction:@selector(pauseDump:)];
	[startButton setEnabled:YES];
	// tell the current operation to unpase, incase it is paused
	if ([[self postQueue] operationCount] > 0) 
		[[[[self postQueue] operations] objectAtIndex:0] setIsPaused:NO];
}

// if theThread is nil, post is an op post. returns true if an image was added to the queue
// if there are no more images to add, returns false after updating the ui
- (BOOL)enqueueNextImageWithDelay:(int)delay threadNumber:(NSString *)theThread
{
	FRLocalImage *next = nil;
	// find next unposted image in array
	for (FRLocalImage *l in imageURLs)
	{
		if (![l posted] && ![l error])
		{
			next = l;
			break;
		}
	}
	
	if (next)
	{
		FRUploadOperation *new = [[FRUploadOperation alloc] initWithTargetURL:[self boardPostURL]
																andLocalImage:next
																	fromQueue:[self postQueue]];
		[new setSubject:[self subject]];
		
		NSMutableString *theComment = [NSMutableString string];
		if (numberPosted == 0) 
		{
			// this is the first post, so use the full comment
			if ([self comment]) 
				[theComment appendString:[self comment]];			
		}
		if (appendNumbers) 
			[theComment appendFormat:@"\r %d/%d", numberPosted+1, [imageURLs count]];
		
		[new setTheComment:theComment];
		[new setEmail:[[NSUserDefaults standardUserDefaults] stringForKey:FRPostEmail]];
		[new setTheName:[[NSUserDefaults standardUserDefaults] stringForKey:FRPostName]];
		[new setUploadProgressDelegate:uploadBar];
		[new setQueue:[self postQueue]];
		[new setDelegate:self];
		[new setDelay:delay];
		[new setThreadNumber:theThread];
		
		[[self postQueue] addOperation:new];
		return TRUE;
	}
	else 
	{
		// no more images left to post
		[self performSelectorOnMainThread:@selector(postedAll)
							   withObject:nil 
							waitUntilDone:YES];
		return FALSE;
	}
}


#pragma mark status

/*!
	@method		
	@abstract	update gui state to show we have posted all images
	@discussion this is run by an FRUploadOperation if it finds that it is the last operation
				resets gui back to starting state
*/
- (void)postedAll
{
	[startButton setTitle:@"Start Dump"];
	[startButton setAction:@selector(startDumping:)];
	[pauseButton setEnabled:NO];
	[boardSelection setEnabled:YES];
	[spinner stopAnimation:self];
	[urlTextBox setEnabled:YES];
	NSString *finalStatus;
	if (numberPosted == 1) 
		finalStatus = [NSString stringWithFormat:@"Posted %d Image.", numberPosted];
	else 
		finalStatus = [NSString stringWithFormat:@"Posted %d Images.", numberPosted];
	[feedbackText setTitleWithMnemonic:finalStatus];
	
	if (growling)
	{
		[GrowlApplicationBridge notifyWithTitle:@"Dump Completed" 
									description:[feedbackText stringValue]
							   notificationName:@"Dump Completed" 
									   iconData:[NSData data] 
									   priority:0 
									   isSticky:NO 
								   clickContext:nil];
	}
	
	numberPosted = 0;
}

/*!
	@method		
	@abstract	update the feedback text
	@discussion allows operations to update the feedback text so the user knows what's going on
*/
- (void)updateUIWithString:(NSString *)string
{
	[feedbackText setTitleWithMnemonic:string];
	[fileTableView setNeedsDisplay:YES];
}

/*!
	@method		
	@abstract	update state to show an image was posted
	@discussion update our post count, the progress indicator, and make sure the tableview
				is refreshed so the user can see changes
*/
- (void)imagePosted
{
	[self didChangeValueForKey:@"imageURLs"];
	[fileTableView setNeedsDisplay:YES];
	numberPosted++;
	[overallProgressIndicator setDoubleValue:(double)numberPosted];
}

// ---------------------------------------------------------------------------------
#pragma mark selection and sorting

/*!
	@method		
	@abstract	set the index of selected images
	@discussion set our index of slected files, and update the array containing images
				do nothing if there was no change to selection
*/
- (void)setSelectedImageIndexes:(NSIndexSet *)newIndexSet
{
	if (![newIndexSet isEqualToIndexSet:selectedImageIndexes])
	{
		selectedImageIndexes = newIndexSet;
		[self setSelectedImages:[imageURLs objectsAtIndexes:selectedImageIndexes]];
	}
}

/*!
	@method		
	@abstract	setter for the array of selected indexes
	@discussion sets the selectedIndex array to the given array. also
				updates the data in the quicklook panel
*/
- (void)setSelectedImages:(NSArray *)array
{
	if (array != selectedImages) 
	{
		array = [array copy];
		[selectedImages release];
		selectedImages = array;
		[previewPanel reloadData];
	}
}

/*!
	@method		
	@abstract	data source method for table view for changing sorting
	@discussion the table view will run this when the user resorts the contents
				this method ensures this will also re-sort the backing array
*/
- (void)tableView:(NSTableView *)aTableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
	NSArray *newDescriptors = [fileTableView sortDescriptors];
	[imageURLs sortUsingDescriptors:newDescriptors];
	[fileTableView reloadData];
}

// --------------------------------------------------------------------------------------
#pragma mark images adding/removing

/*!
	@method		
	@abstract	action method for the add/remove segmented button
	@discussion determines which segment was clicked and either opens
				an open dialog if it was + or removes selected
				image entries if -
*/
- (IBAction)addRemoveClicked:(id)sender
{
	NSInteger clickedSegment = [sender selectedSegment];
	if (clickedSegment == 0) 
		[self openDialog];
	else if (clickedSegment == 1)
	{
		[imagesController remove:sender];
		
		// now we need to recalculate total file size
		int newSize = 0;
		for (FRLocalImage *im in [self imageURLs])
			newSize += [[im numSize] intValue];

		[self setSizeOfAllFiles:newSize];
		[self updatedImageTotal];
		
		//disable start button if we removed all files
		if ([imageURLs count] == 0) 
			[startButton setEnabled:NO];
	}
}

/*!
	@method		
	@abstract	runs an open sheet to let user select images to add
	@discussion the open panel lets user select images or folders,
				multiple selections are allowed. folders will only be 
				shallowly enumerated
*/
- (void)openDialog
{
	NSOpenPanel *oPanel = [NSOpenPanel openPanel];
	NSArray *imageTypes = [NSImage imageTypes];
	[oPanel setAllowedFileTypes:imageTypes];
	[oPanel setCanChooseFiles:YES];
	[oPanel setCanChooseDirectories:YES];
	[oPanel setAllowsMultipleSelection:YES];
	
	void (^panelClosed)(NSInteger) = ^(NSInteger result)
	{
		if (result == NSFileHandlingPanelOKButton) 
		{
			[self addImagesWithURLs:[oPanel URLs]];
			[self performSelectorOnMainThread:@selector(canGo) 
								   withObject:nil 
								waitUntilDone:YES];
		}
	};
	[oPanel beginSheetModalForWindow:[self theWindow] completionHandler:panelClosed];
}

/*!
	@method		
	@abstract	takes an array of urls and adds them
	@discussion image urls are added. directory urls are opened and images within are added
				used when the we return selected items from the open panel
*/
- (void)addImagesWithURLs:(NSArray *)urls
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	for	(NSURL *url in urls)
	{
		NSError *theError = nil;
		NSDictionary *attr = [fm attributesOfItemAtPath:[url path] error:&theError];
		if ([attr fileType] == NSFileTypeDirectory) 
			[self addImageURLsFromDirectory:url atIndex:nil];
		else 
			[self addURL:url atIndex:nil];
	}
}

/*!
	@method		
	@abstract	add images from a drectory url
	@discussion examins contents of directory and adds any image files
				only does a shallow enumeration (does not look into sub directories).
				may consider letting it look a few levels deep in future
*/
- (void)addImageURLsFromDirectory:(NSURL *)dir atIndex:(NSNumber *)indexu
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *err = nil;
	NSArray *contents = [fm contentsOfDirectoryAtURL:dir
						  includingPropertiesForKeys:[NSArray arrayWithObject:@"fileType"]
											 options:NSDirectoryEnumerationSkipsHiddenFiles
											   error:&err];
	
	if (!contents) 
	{
		NSLog(@"Error reading contents of directory: %@, reason: %@", dir, err);
		return;
	}
	
	for (NSURL *f in contents)
	{
		// check file is an image before adding it
		if ([self isImageFile:[f path]]) 
			[self addURL:f atIndex:indexu];
	}
}

/*!
	@method		
	@abstract	add url to our array of images that will be uploaded
	@discussion constructs a FRLocalImage object and adds it to our array.
				if we are already posting, add it to the operation queue as well
				indexu is the inex where the item will be inserted. use nil just to add to the end
				of the array
*/
-(void)addURL:(NSURL *)url atIndex:(NSNumber *)indexu
{
	FRLocalImage *new = [[FRLocalImage alloc] initWithURL:url];
	
	// check if we have added this image already
	if ([imageURLs containsObject:new]) 
		return;
	
	[self willChangeValueForKey:@"imageURLs"];
	if (indexu)
		[[self imageURLs] insertObject:new atIndex:[indexu integerValue]];
	else 
		[[self imageURLs] addObject:new];
	[self didChangeValueForKey:@"imageURLs"];
	
	[self canGo];
	[self setSizeOfAllFiles:(sizeOfAllFiles + [[new numSize] intValue])];
	[self updatedImageTotal];
}
	
// update our record of total size of all files
- (void)updatedImageTotal
{
	if ([imageURLs count] == 1)
	{
		NSString *newLabel = [NSString stringWithFormat:
							  @"1 Image, %@", [FRPostedImage stringFromFileSize:[self sizeOfAllFiles]]];
		[numberOfImages setTitleWithMnemonic:newLabel];
	}
	else
	{
		NSString *newLabel = [NSString stringWithFormat:
							  @"%d Images, %@", [imageURLs count],
							  [FRPostedImage stringFromFileSize:[self sizeOfAllFiles]]];
		[numberOfImages setTitleWithMnemonic:newLabel];
	}
	
	// update progress bar. make sure it's blank if we have no images to post
	if ([imageURLs count] == 0) 
	{
		[overallProgressIndicator setDoubleValue:0.0];
		[overallProgressIndicator setMaxValue:1.0];
	}
	else
		[overallProgressIndicator setMaxValue:(double)[imageURLs count]];
}

/*!
	@method		
	@abstract	method that tells reciever that we have added images and are ready to start
	@discussion gets run when we add images. enables the start button
*/
- (void)canGo
{
	[startButton setEnabled:YES];
}

// -------------------------------------------------------------------------------------------
#pragma mark boardURL

/*!
	@method		
	@abstract	get the board posting url from the user entered url
	@discussion 
*/
- (BOOL)findBoardPostURLFromEnteredURL
{
	NSString *url = [urlTextBox stringValue];
	if ([self validURL:url]) 
	{
		[self identifyBoard:url];
		return TRUE;
	}
	else 
	{
		[feedbackText setTitleWithMnemonic:@"Please enter a valid 4chan thread URL"];
		return FALSE;
	}
}

- (void)findBoardPostURLFromSelection
{
	NSString *selection = [[boardSelection  selectedItem] title];
	
	// remember selection in user defaults
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInteger:[boardSelection indexOfSelectedItem]] forKey:FRDumpBoard];
	
	NSArray *components = [selection componentsSeparatedByString:@"/"];
	
	NSMutableString *newurl = [NSMutableString stringWithString:@"http://sys.4chan.org/"];
	[newurl appendString:[components objectAtIndex:1]];
	[newurl appendString:@"/imgboard.php"];
	[self setBoardPostURL:[NSURL URLWithString:newurl]];
}

- (void)identifyBoard:(NSString *)s
{
	NSURL *base = [[NSURL URLWithString:s] URLByDeletingLastPathComponent];
	NSMutableString *clean = [FRLinkFetcher cleanBaseURLAsMutableString:base];	
	NSInteger length = [clean length];
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
				[classes release];
				
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
			[urlTextBox setStringValue:browserURLString];
		}
		else 
		{
			[feedbackText setTitleWithMnemonic:@"Front window is not a 4chan thread."];
			[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
		}
	}
	else 
	{
		[feedbackText setTitleWithMnemonic:@"No browser window open."];
		[[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
		if (error)
			NSLog(@"Error retrieving URL from browser: %@", error);
	}
}

// -------------------------------------------------------------------------------------
#pragma mark table drag and drop

/*!
	@method		
	@abstract	accept a drag dropped onto the tableview
	@discussion image urls are found and added to array at the drag location
				allso deals with drags internal to the tableview
*/
- (BOOL)tableView:(NSTableView *)aTableView 
	   acceptDrop:(id <NSDraggingInfo>)info
			  row:(int)row 
	dropOperation:(NSTableViewDropOperation)operation
{
	NSPasteboard *pb = [info draggingPasteboard];
	NSArray *types = [pb types];
	if ([types containsObject:NSURLPboardType]) 
	{
		NSFileManager *fm = [NSFileManager defaultManager];

		NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
		NSArray *urls = [pb readObjectsForClasses:classes
										  options:NULL];
		
		for (NSURL *url in urls)
		{
			NSError *theError = nil;
			NSDictionary *attr = [fm attributesOfItemAtPath:[url path] error:&theError];
			if (!attr) 
			{
				NSLog(@"Error reading drag file from disk: %@", theError);
				continue;
			}
			
			if ([attr fileType] == NSFileTypeDirectory) 
				[self addImageURLsFromDirectory:url atIndex:[NSNumber numberWithInt:row]];
			else if ([self isImageFile:[url path]]) 
				[self addURL:url atIndex:[NSNumber numberWithInt:row]];
		}
		return TRUE;
	}
	else if ([types containsObject:BasicTableViewDragAndDropDataType])
	{
		// drag within tableview
		BOOL res = [self tableView:aTableView didDropRows:_moveRows at:row];
		[aTableView reloadData];
		return res;
	}
	return NO;
}
	
/*!
	@method		
	@abstract	moves the elements at dragged to the location newRow
	@discussion used when we drag items within the table view
				the set of selected items are all moved to the location newRow
*/
- (BOOL)tableView:(NSTableView *)tv didDropRows:(NSIndexSet *)dragged at:(NSInteger)newRow
{
	void (^dragBlock)(NSUInteger, BOOL *) = ^(NSUInteger idx, BOOL *stop)
	{
		if (newRow != -1 && idx != -1)
		{
			FRLocalImage *rowObject = [imageURLs objectAtIndex:idx];
			if (newRow < ((NSInteger)[imageURLs count])-1) 
			{
				[imageURLs removeObjectAtIndex:idx];
				[imageURLs insertObject:rowObject atIndex:newRow];
			}
			else
			{
				[imageURLs removeObjectAtIndex:idx];
				[imageURLs addObject:rowObject];
			}
		}
	};
	
	[self willChangeValueForKey:@"imageURLs"];
	[dragged enumerateIndexesUsingBlock:dragBlock];
	[self didChangeValueForKey:@"imageURLs"];
	
	return YES;
}


/*!
	@method		
	@abstract	validate an attempted drag onto the tableview
	@discussion checks that the dragged item(s) is an image or folder
				or is an internal table drag operation
*/
- (NSDragOperation)tableView:(NSTableView*)tv 
				validateDrop:(id <NSDraggingInfo>)info 
				 proposedRow:(int)row 
	   proposedDropOperation:(NSTableViewDropOperation)op
{
	NSPasteboard *pb = [info draggingPasteboard];
	NSArray *types = [pb types];
	if ([types containsObject:NSURLPboardType]) 
	{
		// check the pasteboard contains items of the types we accept
		NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
		NSMutableDictionary *options = [NSMutableDictionary dictionary];
		NSArray *acceptedTypes = [NSImage imageTypes];

		[options setObject:acceptedTypes
					forKey:NSPasteboardURLReadingContentsConformToTypesKey];
		[options setObject:[NSNumber numberWithBool:YES] 
					forKey:NSPasteboardURLReadingFileURLsOnlyKey];
		
		NSArray *urls = [pb readObjectsForClasses:classes
										  options:options];
		if ([urls count] > 0) 
		{
			// found at least one image, so allow drag
			return NSTableViewDropAbove;
		}
		
		// no images found, but check if a folder was dragged
		NSMutableDictionary *dirOptions = [NSMutableDictionary dictionary];
		[dirOptions setObject:[NSNumber numberWithBool:TRUE] 
					   forKey:NSPasteboardURLReadingFileURLsOnlyKey];
		NSArray *dirurls = [pb readObjectsForClasses:classes
										  options:NULL];
		NSFileManager *fm = [NSFileManager defaultManager];
		for	(NSURL *url in dirurls)
		{
			NSError *anError = nil;
			NSDictionary *attrbs = [fm attributesOfItemAtPath:[url path] error:&anError];
			if ([attrbs fileType] == NSFileTypeDirectory) 
			{
				// found a folder, so allow drag
				return NSTableViewDropAbove;
			}
		}
	}
	else if ([types containsObject:BasicTableViewDragAndDropDataType])
	{
		// we are dragging inside the tableview, so
		// check we are dragging to a different row
		if (![_moveRows containsIndex:row]) 
		{
			if (op == NSTableViewDropAbove)
				return NSTableViewDropAbove;
		}
	}
		
	return NSDragOperationNone;
}

/*!
	@method		
	@abstract	record which table view rows have been dragged
	@discussion stores the indexset of the rows that were dragged, so we can drop them
				later on
*/
- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes
											toPasteboard:(NSPasteboard*)pboard
{
	// only allow dragging if there is more than 1 image in table
	if ([imageURLs count] < 2)
		return NO;
	
	[pboard declareTypes:[NSArray arrayWithObject:BasicTableViewDragAndDropDataType]
				   owner:self];
	[pboard setPropertyList:rowIndexes forType:BasicTableViewDragAndDropDataType];
	_moveRows = rowIndexes;
	return YES;
}

/*!
	@method		
	@abstract	finds out if the file at given path is an image
	@discussion taken from: http://developer.apple.com/mac/library/qa/qa2007/qa1518.html
				so i take no responsibility for there being 8 levels of indentation!
*/
- (BOOL)isImageFile:(NSString*)filePath
{
	BOOL isImageFile = NO;
	FSRef fileRef;
	Boolean isDirectory;
	
	if (FSPathMakeRef((const UInt8 *)[filePath fileSystemRepresentation], &fileRef, &isDirectory) == noErr)
	{
		// get the content type (UTI) of this file
		CFDictionaryRef values = NULL;
		CFStringRef attrs[1] = { kLSItemContentType };
		CFArrayRef attrNames = CFArrayCreate(NULL, (const void **)attrs, 1, NULL);
		
		if (LSCopyItemAttributes(&fileRef, kLSRolesViewer, attrNames, &values) == noErr)
		{
			// verify that this is a file that the Image I/O framework supports
			if (values != NULL)
			{
				CFTypeRef uti = CFDictionaryGetValue(values, kLSItemContentType);
				if (uti != NULL)
				{
					CFArrayRef supportedTypes = CGImageSourceCopyTypeIdentifiers();
					CFIndex i, typeCount = CFArrayGetCount(supportedTypes);
					
					for (i = 0; i < typeCount; i++)
					{
						CFStringRef supportedUTI = CFArrayGetValueAtIndex(supportedTypes, i);
						
						// make sure the supported UTI conforms only to "public.image" (this will skip PDF)
						if (UTTypeConformsTo(supportedUTI, CFSTR("public.image")))
						{
							if (UTTypeConformsTo(uti, supportedUTI))
							{
								isImageFile = YES;
								break;
							}
						}
					}
					CFMakeCollectable(supportedTypes);
				}
				CFMakeCollectable(values);
			}
		}
		CFMakeCollectable(attrNames);
	}
	return isImageFile;
}

// -------------------------------------------------------------------------------------
#pragma mark quicklook
// all the delegate methods required for quicklook

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
	return YES;
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
	// we are now responsible for the quicklook panel
	previewPanel = [panel retain];
	[panel setDelegate:self];
	[panel setDataSource:self];
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
	// This document loses its responsisibility for the preview panel
	// Until the next call to -beginPreviewPanelControl: it must not
	// change the panel's delegate, data source or refresh it.
	[previewPanel release];
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
	// redirect all key down events to the collectionview
	if ([event type] == NSKeyDown) 
	{
		[fileTableView keyDown:event];
		return YES;
	}
	return NO;
}

// provides the panel with an icon image for the transition
- (id)previewPanel:(QLPreviewPanel *)panel transitionImageForPreviewItem:(id <QLPreviewItem>)item contentRect:(NSRect *)contentRect
{
	return nil;
}					 

// --------------------------------------------------------------------------------------------
#pragma mark split view delegate methods
/* 
 * limit how far the split view can be moved
 * these values should probably be tweaked
 */

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition 
														 ofSubviewAt:(NSInteger)dividerIndex
{
	return proposedMinimumPosition + 281.0;
}

-(CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition 
														ofSubviewAt:(NSInteger)dividerIndex
{
	return proposedMaximumPosition - 173;
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview
{
	if (subview == threadTypeContainer) 
		return NO;
	else 
		return YES;
}

// ---------------------------------------------------------------------------------------------
#pragma mark window setup

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController
{
	[theWindow setContentBorderThickness:24.0 forEdge:NSMinYEdge];
	NSFont *smaller = [NSFont fontWithName:@"Lucida Grande" size:11.0];
	[numberOfImages setFont:smaller];
	[[numberOfImages cell] setBackgroundStyle:NSBackgroundStyleRaised];
	[numberOfImages setTitleWithMnemonic:@"No Images"];
	
	[startButton setEnabled:NO];
	[feedbackText setTitleWithMnemonic:@""];
	[uploadBar setIndeterminate:FALSE];
	[pauseButton setEnabled:NO];
	[fileTableView registerForDraggedTypes:[NSArray arrayWithObjects:
											NSURLPboardType, BasicTableViewDragAndDropDataType, nil]];
	[boardSelection removeAllItems];
	
	NSMutableArray *boards = [NSMutableArray array];
	[boards addObject:@"/a/ - Anime & Manga"];  
	[boards addObject:@"/adv/ - Advice"];  
	[boards addObject:@"/an/ - Animals & Nature"];   
	[boards addObject:@"/b/ - Random"];              
	[boards addObject:@"/c/ - Anime/Cute"];          
	[boards addObject:@"/cgl/ - Cosplay & EGL"];
	[boards addObject:@"/ck/ - Food & Cooking"];
	[boards addObject:@"/cm/ - Cute/Male"];
	[boards addObject:@"/d/ - Hentai/Alternative"];
	[boards	addObject:@"/e/ - Ecchi"];
	[boards addObject:@"/fa/ - Fashion"];
	[boards addObject:@"/fit/ - Health & Fitness"];
	[boards addObject:@"/g/ - Technology"];
	[boards addObject:@"/gif/ - Animated GIF"];
	[boards addObject:@"/h/ - Hentai"];
	[boards addObject:@"/hr/ - High Resolution"];
	[boards addObject:@"/ic/ - Artwork/Critique"];
	[boards addObject:@"/int/ - International"];
	[boards addObject:@"/jp/ - Japan/General"];
	[boards addObject:@"/k/ - Weapons"];
	[boards addObject:@"/lit/ - Literature"];
	[boards addObject:@"/m/ - Mecha"];
	[boards addObject:@"/mu/ - Music"];
	[boards addObject:@"/n/ - Transportation"];
	[boards addObject:@"/new/ - News"];
	[boards addObject:@"/o/ - Auto"];
	[boards addObject:@"/p/ - Photo"];
	[boards addObject:@"/r/ - Request"];
	[boards addObject:@"/r9k/ - ROBOT9000"];
	[boards addObject:@"/s/ - Sexy Beautiful Women"];
	[boards addObject:@"/sci/ - Science & Maths"];
	[boards addObject:@"/sp/ - Sports"];
	[boards addObject:@"/t/ - Torrents"];
	[boards addObject:@"/tg/ - Traditional Games"];
	[boards addObject:@"/toy/ - Toys"];
	[boards addObject:@"/trv/ - Travel"];
	[boards addObject:@"/tv/ - Television & Film"];
	[boards addObject:@"/u/ - Yuri"];
	[boards addObject:@"/v/ - Video Games"];
	[boards addObject:@"/w/ - Anime/Wallpapers"];
	[boards addObject:@"/wg/ - Wallpapers/General"];
	[boards addObject:@"/x/ - Paranormal"];
	[boards addObject:@"/y/ - Yaoi"];
	[boards addObject:@"/3/ - 3DCG"];
	
	[boardSelection addItemsWithTitles:boards];
	NSUInteger selection = [[NSUserDefaults standardUserDefaults] integerForKey:FRDumpBoard];
	[boardSelection selectItemAtIndex:selection];
	
	[super windowControllerDidLoadNib:windowController];
}

- (NSString *)windowNibName 
{
	return @"DumpDocument";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{	 
	return YES;
}

// override this so that the user can always imediatly close the document, reardless of dirty state
// (document can becoem dirty due to the undo managers in the text fields, dirty state goes away once editing finishes)
- (void)canCloseDocumentWithDelegate:(id)delegate 
				 shouldCloseSelector:(SEL)shouldCloseSelector 
						 contextInfo:(void *)contextInfo
{
	// crazy stuff required just to invoke the callback with shouldClose set to YES
	NSInvocation *callBack = [NSInvocation invocationWithMethodSignature:[delegate methodSignatureForSelector:shouldCloseSelector]];
	[callBack setTarget:delegate];
	[callBack setSelector:shouldCloseSelector];
	[callBack setArgument:&self atIndex:2]; // document:
	[callBack setArgument:&contextInfo atIndex:4]; // contextInfo:
	BOOL shouldclose = TRUE;
	[callBack setArgument:&shouldclose atIndex:3]; // shouldClose:
	[callBack invoke];
}

- (BOOL)windowShouldClose:(id)sender
{
	// check if we are still dumping before closing so we can ask the user for confirmation
	if ([postQueue operationCount] > 0) 
	{
		NSAlert *closeAlert = [[NSAlert alloc] init];
		[closeAlert addButtonWithTitle:@"Close"];
		[closeAlert addButtonWithTitle:@"Cancel"];
		[closeAlert setMessageText:@"Cancel Uploads?"];
		[closeAlert setInformativeText:@"Files are still being posted, are you sure you want to close the dumper?"];
		[closeAlert setAlertStyle:NSWarningAlertStyle];
		[closeAlert beginSheetModalForWindow:theWindow
							   modalDelegate:self
							  didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
								 contextInfo:nil];
		return NO;
	}
	else
		return YES;
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
{
	if (returnCode == NSAlertFirstButtonReturn)
	{
		[self close];
	}
}

- (void)close
{
	[postQueue cancelAllOperations];
	[super close];
}

@synthesize comment;
@synthesize subject;
@synthesize imageURLs;
@synthesize theWindow;
@synthesize canStart;
@synthesize postQueue;
@synthesize boardPostURL;
@synthesize numberPosted;
@synthesize selectedImages;
@synthesize createNewThreads;
@synthesize sizeOfAllFiles;
@synthesize imagesController;
@synthesize selectedImageIndexes;

@end
