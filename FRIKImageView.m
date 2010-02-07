//
//  FRIKImageView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 07/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRIKImageView.h"
#import "TabStripController.h"
#import "FRPreferenceController.h"


@implementation FRIKImageView

- (id)initWithFrame:(NSRect)frameRect
{
	[super initWithFrame:frameRect];
	[self registerForDraggedTypes:[NSArray arrayWithObject:NSURLPboardType]];
	imageFileURL = nil;
	boardMaxSize = 0;
	 return self;
}

// get a url from a pasteboard, and update the view with the image
// represented by the url
- (BOOL)readFromPasteboard:(NSPasteboard *)pb
{
	NSArray *types = [pb types];
	if ([types containsObject:NSURLPboardType]) 
	{
		NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
		
		// set up options so we only recieve urls for local files, and only for images
		NSMutableDictionary *options = 
			[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
																forKey:NSPasteboardURLReadingFileURLsOnlyKey];
		[options setObject:[NSImage imageTypes]
					forKey:NSPasteboardURLReadingContentsConformToTypesKey];
		
		NSArray *urls = [pb readObjectsForClasses:classes
										  options:options];
		
		if ([urls count] == 0)
		{
			[containingBox setHighlighted:NO];
			[containingBox setNeedsDisplay:YES];
			return NO;
		}
		
		// only get the first url, ignore others if the user has dragged a group of images
		NSURL *url = [urls objectAtIndex:0];
		[self setImageWithURL:url];
		return YES;
	}
	else 
	{
		[containingBox setHighlighted:NO];
		[containingBox setNeedsDisplay:YES];
	}

	return NO;
}

- (void)setImageWithURL:(NSURL*)url
{
	[self setImageFileURL:url];
	NSImage *new = [[NSImage alloc] initWithContentsOfURL:url];
	[self setImage:new];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	if ([sender draggingSource] == self) 
		return NSDragOperationNone;
	
	NSPasteboard *pb = [sender draggingPasteboard];
	NSArray *types = [pb types];
	if ([types containsObject:NSURLPboardType]) 
	{
		// check the pasteboard contains an image
		NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
		NSMutableDictionary *options = [NSMutableDictionary dictionary];
		NSArray *acceptedTypes = [NSImage imageTypes];
		
		[options setObject:acceptedTypes
					forKey:NSPasteboardURLReadingContentsConformToTypesKey];
		[options setObject:[NSNumber numberWithBool:YES] 
					forKey:NSPasteboardURLReadingFileURLsOnlyKey];
		
		NSArray *urls = [pb readObjectsForClasses:classes
										  options:options];
		if ([urls count] == 1) 
		{
			// found one image, so allow drag
			[containingBox setHighlighted:YES];
			[containingBox setNeedsDisplay:YES];
			[containingBox setFocusRect:[self frame]];
			NSCursor *dragCursor = [NSCursor dragCopyCursor];
			[dragCursor push];
			return NSDragOperationEvery;
		}
	}
	
	// did not contain an image, so do not allow drag
	return NSDragOperationNone;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	[NSCursor pop];
	[containingBox setHighlighted:NO];
	[theWindow display];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{	
	if ([sender draggingSource] == self) 
		return NO;
	
	NSPasteboard *pb = [sender draggingPasteboard];
	NSArray *types = [pb types];
	if ([types containsObject:NSURLPboardType]) 
	{
		// check the pasteboard contains an image
		NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
		NSMutableDictionary *options = [NSMutableDictionary dictionary];
		NSArray *acceptedTypes = [NSImage imageTypes];
		
		[options setObject:acceptedTypes
					forKey:NSPasteboardURLReadingContentsConformToTypesKey];
		[options setObject:[NSNumber numberWithBool:YES] 
					forKey:NSPasteboardURLReadingFileURLsOnlyKey];
		
		NSArray *urls = [pb readObjectsForClasses:classes
										  options:options];
		if ([urls count] == 1) 
			return YES;
	}
	
	return NO;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *pb = [sender draggingPasteboard];
	if (![self readFromPasteboard:pb]) 
	{
		// we only register for urls, so this shouldn't happen unless
		// something goes badly wrong
		NSLog(@"Drag pasteboard did not contain any URLs");
		return NO;
	}
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	[containingBox setHighlighted:NO];
	[theWindow display];
	[NSCursor pop];
}

/*!
    @method     
    @abstract   on mouse down allow user to select file
    @discussion clicking opens a modal open dialog that only 
				allows selection of image files
*/
/*- (void)mouseDown:(NSEvent *)theEvent
{
	// set up open panel
	NSOpenPanel *oPanel = [NSOpenPanel openPanel];
	[oPanel setCanChooseDirectories:NO];
	[oPanel setCanChooseFiles:YES];
	[oPanel setCanCreateDirectories:NO];
	[oPanel setAllowsMultipleSelection:NO];
	NSArray *types = [NSImage imageTypes];
	[oPanel setAllowedFileTypes:types];
	
	GTMWindowSheetController *sheetController = 
	[[[[[self delegate] ourView] window] windowController] sheetController];
	
	SEL didEndSelector = @selector(openPanelDidEnd:returnCode:contextInfo:);
	NSValue *selectorValue = [NSValue valueWithPointer:didEndSelector];
	NSString *dirPath = [[NSUserDefaults standardUserDefaults] 
						 objectForKey:FRLastSaveLocation];
	
	NSArray *parameters = [NSArray arrayWithObjects:dirPath, @"", 
						   types, [NSNull null], self, 
						   selectorValue, self, nil];
	
	[sheetController beginSystemSheet:oPanel 
						 modalForView:[[self delegate] ourView] 
					   withParameters:parameters];

	[super mouseDown:theEvent];
}

- (void)openPanelDidEnd:(NSOpenPanel *)panel 
			 returnCode:(int)returnCode  
			contextInfo:(void  *)contextInfo
{
	if (returnCode == NSFileHandlingPanelOKButton) 
	{
		[self setImageWithURL:[panel URL]];
		NSString *location = 
		[[[panel URL] path] stringByDeletingLastPathComponent];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:location forKey:FRFinderCommentKey];
	}
}*/

@synthesize imageFileURL;
@synthesize boardMaxSize;
@end


@implementation FRPostImageBox

// draw the highlight ring if required
// this still seems to be drawn in the wrong place (a few pixels out)
// TODO: draw in correct location
- (void)drawRect:(NSRect)dirtyRect
{
	if (highlighted) 
	{
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[[NSBezierPath bezierPathWithRect:NSInsetRect([self focusRect], 0, 0)] fill];
		[NSGraphicsContext restoreGraphicsState];
	}
	
	[super drawRect:dirtyRect];
}

@synthesize focusRect;
@synthesize highlighted;
@end


