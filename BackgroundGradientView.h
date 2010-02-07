//
//  BackgroundGradientView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "background_gradient_view.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>


@interface BackgroundGradientView : NSView 
{
	BOOL showsDivider_;
}

// The color used for the bottom stroke. Public so subclasses can use.
- (NSColor *)strokeColor;

// Draws the background for this view. Make sure that your patternphase
// is set up correctly in your graphics context before calling.
- (void)drawBackground;

// Controls whether the bar draws a dividing line at the bottom.
@property(assign) BOOL showsDivider;

@end
