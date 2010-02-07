//
//  TabStrip.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_strip_view.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>


@interface TabStrip : NSView 
{
	NSTimeInterval lastMouseUp_;
	
	// Weak; the following come from the nib.
	NSButton* newTabButton_;
	
	// Whether the drop-indicator arrow is shown, and if it is, the coordinate of
	// its tip.
	BOOL dropArrowShown_;
	NSPoint dropArrowPosition_;
}

@property(assign, nonatomic) IBOutlet NSButton *newTabButton;
@property(assign, nonatomic) BOOL dropArrowShown;
@property(assign, nonatomic) NSPoint dropArrowPosition;

@end
