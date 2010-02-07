//
//  TabbedWindow.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "chrome_browser_window.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>

// Offset from the top of the window frame to the top of the window controls
// (zoom, close, miniaturize) for a window with a tabstrip.
extern const NSInteger kTabbedWindowButtonsWithTabStripOffsetFromTop;

// Offset from the top of the window frame to the top of the window controls
// (zoom, close, miniaturize) for a window without a tabstrip.
extern const NSInteger kTabbedWindowButtonsWithoutTabStripOffsetFromTop;

// Offset from the left of the window frame to the top of the window controls
// (zoom, close, miniaturize).
extern const NSInteger kTabbedWindowButtonsOffsetFromLeft;

// Offset between the window controls (zoom, close, miniaturize).
extern const NSInteger kFRTabbedWindowButtonsInterButtonSpacing;

@interface TabbedWindow : NSWindow 
{
	BOOL shouldHideTitle;
	NSButton *closeButton;
	NSButton *minimiseButton;
	NSButton *zoomButton;
	BOOL entered;
	NSTrackingArea *widgetTrackingArea;
}

// Tells the window to suppress title drawing.
- (void)setShouldHideTitle:(BOOL)flag;

// Return true if the mouse is currently in our tracking area for our window
// widgets.
- (BOOL)mouseInGroup:(NSButton *)widget;

// Update the tracking areas for our window widgets as appropriate.
- (void)updateTrackingAreas;

- (NSView *)frameView;

@end


@interface TabbedWindow (UndocumentedAPI)

// Undocumented Cocoa API to suppress drawing of the window's title.
// -setTitle: still works, but the title set only applies to the
// miniwindow and menus (and, importantly, Expose).  Overridden to
// return |shouldHideTitle_|.
-(BOOL)_isTitleHidden;

@end




