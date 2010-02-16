//
//  FRTextView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 17/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRTextView.h"
#import "FRPostedImage.h"
#import "FRFullThreadCollectionView.h"

@interface FRTextView ()

- (void)copyOrigURL;
- (void)gotoPost;

@end


@implementation FRTextView

- (void)mouseDown:(NSEvent *)theEvent
{
	[box mouseDown:theEvent];
	[box mouseUp:theEvent];
	[super mouseDown:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent
{
	[super mouseUp:theEvent];
}

// ------------------------------------------------------------------------------------------
#pragma mark internal links

// user clicked on an internal link, so tell delegate
- (void)clickedOnLink:(id)aLink atIndex:(NSUInteger)charIndex
{
	[[self delegate] textView:self clickedOnLink:(id)aLink atIndex:(NSUInteger)charIndex];
}

// -----------------------------------------------------------------------------------------------
#pragma mark right click menu

// open right click menu
- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{	
	NSMenu *theMenu = [[self class] defaultMenu];
	
	// if the clicked item was not already selected, deselect all items, and select it
	if (![[box collectionItem] isSelected]) 
	{
		[[[box collectionItem] collectionView] deselectAll:self];
		[(FRFullThreadCollectionView *)[[box collectionItem] collectionView] 
					selectItemsForObjects:[NSArray arrayWithObject:[[box collectionItem] representedObject]]];
	}
	
	return theMenu;
}

// setup right click menu
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
	NSString *origURL = [(FRPostedImage *)[[box collectionItem] representedObject] imageURL];
	NSArray *objects = [NSArray arrayWithObjects:origURL, nil];
	[pb writeObjects:objects];
}

// open url of post in browser
- (void)gotoPost
{
	[[NSWorkspace sharedWorkspace] openURL:[(FRPostedImage *)[[box collectionItem] representedObject] postURL]];
}




@end
