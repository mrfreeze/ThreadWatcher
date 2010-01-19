//
//  FRCollectionItemView.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 10/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "FRCollectionItemView.h"
#import <objc/objc-auto.h>

// NSBox subclass to show selection
@implementation FRCollectionItemViewSelectionBox

- (void) awakeFromNib 
{		
    [self setTitlePosition:NSNoTitle];
    [self setBoxType:NSBoxCustom];
    [self setCornerRadius:14.0];
    [self setBorderType:NSLineBorder];
	[self setBorderWidth:10.0];
	//[self setFillColor:[NSColor selectedTextBackgroundColor]]; // could use user highlight colour, 
																 // but it looks very ugly with my choice of green
																 // so leaving this off for now
	
	[self bind:@"collectionController" 
	  toObject:collectionController 
   withKeyPath:@"self" 
	   options:nil];
}

// deselect all images since the user clicked in white space
// and record mouse events so we can check for the size 
// of mouse movement in mouseDragged:
- (void)mouseDown:(NSEvent *)theEvent
{	
	[theEvent retain];
	[mouseDownEvent release];
	mouseDownEvent = theEvent;
	NSIndexSet *empty = [NSIndexSet indexSet];
	[[collectionController collectionView] setSelectionIndexes:empty];
}


// if the drag event is small, ignore it
// otherwise, pass on the mouse event so that it 
// gets passed up the responder chain to the collectionview
- (void)mouseDragged:(NSEvent *)theEvent
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [theEvent locationInWindow];
	float distance = hypot(down.x - drag.x, down.y - drag.y);
	
	if (distance < 3) 
		return;
	
	// we want to allow a drag to take place
	[super mouseDown:theEvent];
}

// mouse event that has been passed from the imageview 
// indicates a click on the thumbnail, so pass it on
// to allow selection of the item
- (void)mouseDown:(NSEvent *)theEvent from:(id)source
{
	[super mouseDown:theEvent];
}

@synthesize collectionController;
@end

// -------------------------------------------------------------------------------------------
// methods for the collection view
@implementation FRIconCollectionView

- (void)awakeFromNib
{
	[self setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{	
	return [super menuForEvent:theEvent];
}

// intercept presses of the spacebar so we can activate quicklook
- (void)keyDown:(NSEvent *)theEvent
{
    NSString* key = [theEvent charactersIgnoringModifiers];
	
    if([key isEqual:@" "]) 
        [[NSApp delegate] togglePreviewPanel:self];
	else
        [super keyDown:theEvent];
}

@end

// ----------------------------------------------------------------------------------------
// private methods
@interface FRImageView ()
- (void)copyOrigURL;
- (void)gotoPost;
@end

@implementation FRImageView

- (void)awakeFromNib
{
	[self bind:@"representedObject" 
	  toObject:collectionController 
   withKeyPath:@"representedObject" 
	   options:nil];
	[self bind:@"collectionController" 
	  toObject:collectionController 
   withKeyPath:@"self" 
	   options:nil];
}

// test to see if click was in the thumbnail
// and passes the mouse event on to boxView in an appropriate way
- (void)mouseDown:(NSEvent *)theEvent
{
	NSRect selfFrame = [self frame];
	NSImage *viewedImage = [representedObject theImage];
	NSSize thumbSize = [viewedImage size];
	
	NSPoint clickPoint = [self convertPoint:[theEvent locationInWindow] 
								   fromView:nil];
	
	NSPoint centre = NSMakePoint(selfFrame.size.width / 2.0, selfFrame.size.height / 2.0);
	NSSize half = NSMakeSize(thumbSize.width / 2.0, thumbSize.height / 2.0);
	
	NSRect thumbRect = NSMakeRect((centre.x - half.width), (centre.y - half.height), thumbSize.width, thumbSize.height);
	
	// if the click is inside the thumb, tell our box to select
	// otherwise tell boxview to deselect all images
	if (NSPointInRect(clickPoint, thumbRect))
		[boxView mouseDown:theEvent from:self];
	else
		[boxView mouseDown:theEvent]; // this will deselect all images
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{	
	NSMenu *theMenu = [[self class] defaultMenu];
	
	// if the clicked item was not already selected, deselect all items, and select it
	if (![collectionController isSelected]) 
	{
		[[collectionController collectionView] setSelectionIndexes:[NSIndexSet indexSet]];
		[collectionController setSelected:TRUE];
	}

	return theMenu;
}

+ (NSMenu *)defaultMenu
{
	NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
	[theMenu insertItemWithTitle:@"Copy Original Image URL" 
						  action:@selector(copyOrigURL)
				   keyEquivalent:@"" 
						 atIndex:0];
	[theMenu insertItemWithTitle:@"Open Post in Browser" 
						  action:@selector(gotoPost)
				   keyEquivalent:@"" 
						 atIndex:1];
	return theMenu;
}

- (void)copyOrigURL
{
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSGeneralPboard];
	[pb clearContents];
	NSString *origURL = [representedObject imageURL];
	NSArray *objects = [NSArray arrayWithObjects:origURL, nil];
	[pb writeObjects:objects];
}

- (void)gotoPost
{
	[[NSWorkspace sharedWorkspace] openURL:[representedObject postURL]];
}

// attempt to make sure the backing layer is gone
// and won't cause finalize errors
- (void)finalize
{
	[self setWantsLayer:NO];
	[super finalize];
}

@synthesize representedObject;
@synthesize boxView;
@synthesize collectionController;
@end

// ------------------------------------------------------------------------------------------------
@implementation FRLevelIndicatorCell

// override isHighlihted so that the dots always show
- (BOOL)isHighlighted
{
	return YES;
}
@end



