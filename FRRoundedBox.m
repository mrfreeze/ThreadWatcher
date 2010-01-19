//
//  FRRoundedBox.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 13/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRRoundedBox.h"
#import "FRPostedImage.h"
#import "FRFullThreadCollectionView.h"


@implementation FRRoundedBox

- (void) awakeFromNib 
{		
    [self setTitlePosition:NSNoTitle];
    [self setBoxType:NSBoxCustom];
    [self setCornerRadius:14.0];
}

// make sure we recieve mouse click events, unless click was on the post text
- (NSView *)hitTest:(NSPoint)aPoint
{
	if ([postTextView hitTest:aPoint] == postTextView) 
		return postTextView;

	return self;
}

// right click menu
- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{	
	/*if ([self isTransparent]) 
	{
		[super menuForEvent:theEvent];
	}*/
	
	NSMenu *theMenu = [[self class] defaultMenu];
	
	// if the clicked item was not already selected, deselect all items, and select it
	if (![collectionItem isSelected]) 
	{
		[[collectionItem collectionView] deselectAll:self];
		[super mouseDown:theEvent];
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

// validate right click menu, so image url 
// doesn't appear if post has no image
- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	BOOL result = TRUE;
	
	if ([menuItem action] ==@selector(copyOrigURL)) 
	{
		if (![[collectionItem representedObject] theImage]) 
			result = FALSE;
	}
	
	return result;
}


- (void)copyOrigURL
{
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSGeneralPboard];
	[pb clearContents];
	NSString *origURL = [(FRPostedImage *)[collectionItem representedObject] imageURL];
	NSArray *objects = [NSArray arrayWithObjects:origURL, nil];
	[pb writeObjects:objects];
}

// open url of post in browser
- (void)gotoPost
{
	[[NSWorkspace sharedWorkspace] openURL:[(FRPostedImage *)[collectionItem representedObject] postURL]];
}

@synthesize collectionItem;
@end





