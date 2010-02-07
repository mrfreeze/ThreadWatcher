//
//  ToolbarView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 30/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "toolbar_view.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "ToolbarView.h"
#import "GTMTheme.h"

@implementation ToolbarView

@synthesize dividerOpacity = dividerOpacity_;

// Prevent mouse down events from moving the parent window around.
- (BOOL)mouseDownCanMoveWindow 
{
	return NO;
}

- (void)drawRect:(NSRect)rect 
{
	// The toolbar's background pattern is phased relative to the
	// tab strip view's background pattern.
	NSPoint phase = [self gtm_themePatternPhase];
	[[NSGraphicsContext currentContext] setPatternPhase:phase];
	[self drawBackground];
}

// Override of |-[BackgroundGradientView strokeColor]|; make it respect opacity.
- (NSColor*)strokeColor 
{
	return [[super strokeColor] colorWithAlphaComponent:[self dividerOpacity]];
}

- (BOOL)accessibilityIsIgnored 
{
	return NO;
}

- (id)accessibilityAttributeValue:(NSString*)attribute 
{
	if ([attribute isEqual:NSAccessibilityRoleAttribute])
		return NSAccessibilityToolbarRole;
	
	return [super accessibilityAttributeValue:attribute];
}





@end
