//
//  FRTabBadge.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 03/02/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
//  Based on BDBadgeCell by Brian Duncan
//  http://www.bdunagan.com/2008/11/10/cocoa-tutorial-source-list-badges-part-2/
//  This code is under the MIT License: http://www.opensource.org/licenses/mit-license.php

#import "FRTabBadge.h"
#import "TabView.h"

// Badge variables, based on Apple Mail.
#define BADGE_BUFFER_LEFT 4
#define BADGE_BUFFER_SIDE 3
#define BADGE_BUFFER_TOP 3
#define BADGE_BUFFER_LEFT_SMALL 2
#define BADGE_CIRCLE_BUFFER_RIGHT 5
#define BADGE_TEXT_HEIGHT 14
#define BADGE_X_RADIUS 7
#define BADGE_Y_RADIUS 8
#define BADGE_TEXT_MINI 8
#define BADGE_TEXT_SMALL 20
#define ICON_WIDTH 16
#define ICON_HEIGHT_OFFSET 2

@implementation FRTabBadge

@synthesize count = count_;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
        count_ = 0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect 
{
	if ([self count] == 0)
		return;
	
	NSRect aRect = dirtyRect;
	
	NSString *badge = [NSString stringWithFormat:@"%d", [self count]];
	NSFont *badgeFont = [NSFont fontWithName:@"Helvetica-Bold" size:11];
	NSSize badgeNumSize = [badge sizeWithAttributes:nil];
	
	// Calculate the badge's coordinates.
	NSInteger badgeWidth = badgeNumSize.width + BADGE_BUFFER_SIDE * 2;
	NSInteger bufferLeft = BADGE_BUFFER_LEFT;
	if (badgeNumSize.width < BADGE_TEXT_MINI)
	{
		// Make sure the width is at least the minimum size
		badgeWidth = BADGE_TEXT_SMALL;
		bufferLeft = 5;
	}
	
	NSInteger badgeX = aRect.origin.x + aRect.size.width - BADGE_CIRCLE_BUFFER_RIGHT - badgeWidth;
	NSInteger badgeNumX = badgeX + bufferLeft;
	NSInteger badgeY = aRect.origin.y + BADGE_BUFFER_TOP;
	if (badgeNumSize.width < BADGE_TEXT_MINI)
		badgeNumX += BADGE_BUFFER_LEFT_SMALL;

	NSRect badgeRect = NSMakeRect(badgeX, badgeY, badgeWidth, BADGE_TEXT_HEIGHT);
	
	// Draw the badge and number.
	NSBezierPath *badgePath = [NSBezierPath bezierPathWithRoundedRect:badgeRect 
															  xRadius:BADGE_X_RADIUS 
															  yRadius:BADGE_Y_RADIUS];
	
	BOOL isWindowFront = [[self window] isMainWindow];
	BOOL isTabSelected = [[(TabView *)[self superview] controller] selected];
	
	if (isWindowFront && isTabSelected) // selected. we don't use this
	{
		[[NSColor colorWithCalibratedRed:.53 green:.60 blue:.74 alpha:1.0] set];
		[badgePath fill];
		NSDictionary *dict = [[NSMutableDictionary alloc] init];
		[dict setValue:badgeFont forKey:NSFontAttributeName];
		[dict setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[badge drawAtPoint:NSMakePoint(badgeNumX,badgeY) withAttributes:dict];
	}
	else if (!isWindowFront && isTabSelected) // window not focused and tab selected
	{
		[[NSColor whiteColor] set];
		[badgePath fill];
		NSDictionary *dict = [[NSMutableDictionary alloc] init];
		[dict setValue:badgeFont forKey:NSFontAttributeName];
		[dict setValue:[NSColor disabledControlTextColor] forKey:NSForegroundColorAttributeName];
		[badge drawAtPoint:NSMakePoint(badgeNumX,badgeY) withAttributes:dict];
	}
	else // window not focused and tab not selected
	{
		[[NSColor disabledControlTextColor] set];
		[badgePath fill];
		NSDictionary *dict = [[NSMutableDictionary alloc] init];
		[dict setValue:badgeFont forKey:NSFontAttributeName];
		[dict setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[badge drawAtPoint:NSMakePoint(badgeNumX,badgeY) withAttributes:dict];
	}
}

@end


