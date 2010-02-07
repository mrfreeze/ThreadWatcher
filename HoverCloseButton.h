//
//  HoverCloseButton.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "hover_close_button.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>


@interface HoverCloseButton : NSButton 
{
	NSTrackingArea *closeTrackingArea_;
}

// Enables or disables the |NSTrackingRect|s for the button.
- (void)setTrackingEnabled:(BOOL)enabled;

// Sets up the button's images, tracking areas, and accessibility info
// when instantiated via initWithFrame or awakeFromNib.
- (void)commonInit;

// Checks to see whether the mouse is in the button's bounds and update
// the image in case it gets out of sync.  This occurs when you close a
// tab so the tab to the left of it takes its place, and drag the button
// without moving the mouse before you press the button down.
- (void)checkImageState;

@end
