//
//  BackgroundGradientView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "background_gradient_view.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "BackgroundGradientView.h"
#import "GTMTheme.h"
#import "TabbedWindowController.h"

@interface BackgroundGradientView ()

- (GTMTheme *)theme;

@end



@implementation BackgroundGradientView
@synthesize showsDivider = showsDivider_;

- (id)initWithFrame:(NSRect)frameRect 
{
	self = [super initWithFrame:frameRect];
	if (self) 
	{
		showsDivider_ = YES;
	}
	return self;
}

- (void)awakeFromNib 
{
	showsDivider_ = YES;
}

- (void)setShowsDivider:(BOOL)show 
{
	showsDivider_ = show;
	[self setNeedsDisplay:YES];
}

- (void)drawBackground 
{
	BOOL isKey = [[self window] isKeyWindow];
	GTMTheme *theme = [self theme];
	
	CGFloat winHeight = NSHeight([[self window] frame]);
	NSGradient *gradient = [theme gradientForStyle:GTMThemeStyleToolBar
											 state:isKey];
	NSPoint startPoint =
	[self convertPoint:NSMakePoint(0, winHeight)
			  fromView:nil];
	NSPoint endPoint =
	NSMakePoint(0, winHeight);
	endPoint = [self convertPoint:endPoint fromView:nil];
	
	[gradient drawFromPoint:startPoint
					toPoint:endPoint
					options:(NSGradientDrawsBeforeStartingLocation |
							 NSGradientDrawsAfterEndingLocation)];
	
	
	if (showsDivider_) 
	{
		// Draw bottom stroke
		[[self strokeColor] set];
		NSRect borderRect, contentRect;
		NSDivideRect([self bounds], &borderRect, &contentRect, 1, NSMinYEdge);
		NSRectFillUsingOperation(borderRect, NSCompositeSourceOver);
	}
}

- (NSColor*)strokeColor 
{
	return [[self theme] strokeColorForStyle:GTMThemeStyleToolBar
									   state:[[self window] isKeyWindow]];
}

- (GTMTheme *)theme
{
	GTMTheme *windowTheme = [(TabbedWindowController *)[[self window] windowController] theme];
	
	// when a tab is being torn off, it may not be possible to get the theme from the
	// window controller. since we don't ever change themes, and always use the defualt theme
	// just create a new defualt theme
	if (!windowTheme) 
		windowTheme = [GTMTheme defaultTheme];
	
	return windowTheme;
}








@end
