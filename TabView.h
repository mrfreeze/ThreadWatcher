//
//  TabView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_view.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "BackgroundGradientView.h"
#import "TabController.h"
#import "HoverCloseButton.h"
#import "TabbedWindowController.h"

@class TabController;
@class TabbedWindowController;

@interface TabView : BackgroundGradientView 
{
	IBOutlet TabController* controller_;
	IBOutlet HoverCloseButton *closeButton_;
	IBOutlet NSTextField *titleField_;
	BOOL closing_;
	
	BOOL frameExpanded;
	
	// Tracking area for close button mouseover images.
	NSTrackingArea *closeTrackingArea_;
	
	BOOL isMouseInside_;  // Is the mouse hovering over?
	
	CGFloat hoverAlpha_;  // How strong the hover glow is.
	NSTimeInterval hoverHoldEndTime_;  // When the hover glow will begin dimming.
	
	CGFloat alertAlpha_;  // How strong the alert glow is.
	NSTimeInterval alertHoldEndTime_;  // When the hover glow will begin dimming.
	
	NSTimeInterval lastGlowUpdate_;  // Time either glow was last updated.
	
	NSPoint hoverPoint_;  // Current location of hover in view coords.

	// All following variables are valid for the duration of a drag.
	// These are released on mouseUp:
	BOOL moveWindowOnDrag_;  // Set if the only tab of a window is dragged.
	BOOL tabWasDragged_;  // Has the tab been dragged?
	BOOL draggingWithinTabStrip_;  // Did drag stay in the current tab strip?
	BOOL chromeIsVisible_;
	
	NSTimeInterval tearTime_;  // Time since tear happened
	NSPoint tearOrigin_;  // Origin of the tear rect
	NSPoint dragOrigin_;  // Origin point of the drag
						  // TODO(alcor): these references may need to be strong to avoid crashes
						  // due to JS closing windows
	TabbedWindowController *sourceController_;  // weak. controller starting the drag
	NSWindow* sourceWindow_;  // weak. The window starting the drag
	NSRect sourceWindowFrame_;
	NSRect sourceTabFrame_;
	
	TabbedWindowController *draggedController_;  // weak. Controller being dragged.
	NSWindow* dragWindow_;  // weak. The window being dragged
	NSWindow* dragOverlay_;  // weak. The overlay being dragged
	
	TabbedWindowController *targetController_;  // weak. Controller being targeted
	NSCellStateValue state_;
}

@property (assign, nonatomic) NSCellStateValue state;
@property (assign, nonatomic) CGFloat hoverAlpha;
@property (assign, nonatomic) CGFloat alertAlpha;

// Determines if the tab is in the process of animating closed. It may still
// be visible on-screen, but should not respond to/initiate any events. Upon
// setting to NO, clears the target/action of the close button to prevent
// clicks inside it from sending messages.
@property(assign, nonatomic, getter=isClosing) BOOL closing;

// Enables/Disables tracking regions for the tab.
- (void)setTrackingEnabled:(BOOL)enabled;

- (TabController *)controller;

// grow or shrink the fram of the title text box, depending on if
// the badge needs to be shown or not
- (void)expandTitleFrame;
- (void)reduceTitleFrame;

@end
