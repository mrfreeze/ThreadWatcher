//
//  TabController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_controller.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "HoverCloseButton.h"
#import "TabView.h"
#import "FRTabBadge.h"

enum TabLoadingState {
	kTabDone,
	kTabLoading,
	kTabWaiting,
	kTabCrashed,
};

@class TabView;

@interface TabController : NSViewController 
{
	IBOutlet NSView *iconView_;
	IBOutlet NSTextField *titleView_;
	IBOutlet HoverCloseButton *closeButton_;
	FRTabBadge *tabBadge_;
	
	NSString *title_;
	enum TabLoadingState loadingState_;
	
	NSRect originalIconFrame_;
	BOOL isIconShowing_;
	
	BOOL selected_;
	CGFloat iconTitleXOffset_;  // between left edges of icon and title
	CGFloat titleCloseWidthOffset_;  // between right edges of icon and close btn.
									
	SEL action_;  // selector sent when tab is selected by clicking
	id target_;
}

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) id target;
@property (assign, nonatomic) SEL action;
@property (readwrite, retain) NSString *title;
@property (assign) IBOutlet	FRTabBadge *tabBadge;
@property (assign) enum TabLoadingState loadingState;

// Minimum and maximum allowable tab width. The minimum width does not show
// the icon or the close button. The selected tab always has at least a close
// button so it has a different minimum width.
+ (CGFloat)minTabWidth;
+ (CGFloat)maxTabWidth;
+ (CGFloat)minSelectedTabWidth;
+ (CGFloat)pinnedTabWidth;

// The view associated with this controller, pre-casted as a TabView
- (TabView *)tabView;

// Closes the associated TabView by relaying the message to |target_| to
// perform the close.
- (IBAction)closeTab:(id)sender;

// Replace the current icon view with the given view. |iconView| will be
// resized to the size of the current icon view.
- (void)setIconView:(NSView *)iconView;
- (NSView *)iconView;

// Called by the tabs to determine whether we are in rapid (tab) closure mode.
// In this mode, we handle clicks slightly differently due to animation.
// Ideally, tabs would know about their own animation and wouldn't need this.
- (BOOL)inRapidClosureMode;

// Updates the visibility of certain subviews, such as the icon and close
// button, based on criteria such as the tab's selected state and its current
// width.
- (void)updateVisibility;

// Update the title color to match the tabs current state.
- (void)updateTitleColor;

// set if the icon is shown.
- (BOOL)shouldShowIcon;

// set the number to be shown in the tab badge
- (void)setCount:(NSInteger)newCount;

@end
