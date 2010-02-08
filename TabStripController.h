//
//  TabStripController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_strip_controller.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "TabStrip.h"
#import "MyDocument.h"
#import "FRWatcherTabContentsController.h"
#import "TabView.h"
#import "TabStripModel.h"

extern NSString *const kTabStripNumberOfTabsChanged;

@class MyDocument;
@class TabStripModel;
@class TabView;
@class TabController;
@class FRWatcherTabContentsController;

@interface TabStripController : NSObject
{
	FRWatcherTabContentsController *currentTab_;
	TabStrip *tabStripView_;
	NSView *switchView_;
	NSView *dragBlockingView_; // avoid bad window server drags
	NSButton *newTabButton_; // weak, obtained from the nib.
	
	// TRacks the newTabButton for rollovers
	NSTrackingArea *newTabTrackingArea_;
	MyDocument *document_; // weak
	TabStripModel *tabStripModel_; // weak
	
	// Access to the TabContentsControllers (which own the parent view
	// for the toolbar and associated tab contents) given an index. Call
	// |indexFromModelIndex:| to convert a |tabStripModel_| index to a
	// |tabContentsArray_| index. Do NOT assume that the indices of
	// |tabStripModel_| and this array are identical, this is e.g. not true while
	// tabs are animating closed (closed tabs are removed from |tabStripModel_|
	// immediately, but from |tabContentsArray_| only after their close animation
	// has completed).
	NSMutableArray *tabContentsArray_;
	
	// An array of TabControllers which manage the actual tab views.
	NSMutableArray *tabArray_;
	
	// Set of TabControllers that are currently animating closed.
	NSMutableSet *closingControllers_;
	
	// These values are only used during a drag, and override tab positioning.
	TabView *placeholderTab_;  // weak. Tab being dragged
	NSRect placeholderFrame_;  // Frame to use
	CGFloat placeholderStretchiness_; // Vertical force shown by streching tab.
	NSRect droppedTabFrame_;
	NSMutableDictionary *targetFrames_;
	NSRect newTabTargetFrame_;
	
	// If YES, do not show the new tab button during layout.
	BOOL forceNewTabButtonHidden_;
	// YES if we've successfully completed the initial layout. When this is
	// NO, we probably don't want to do any animation because we're just coming
	// into being.
	BOOL initialLayoutComplete_;
	
	// Width available for resizing the tabs (doesn't include the new tab
	// button). Used to restrict the available width when closing many tabs at
	// once to prevent them from resizing to fit the full width. If the entire
	// width should be used, this will have a value of |kUseFullAvailableWidth|.
	float availableResizeWidth_;
	// A tracking area that's the size of the tab strip used to be notified
	// when the mouse moves in the tab strip
	NSTrackingArea *trackingArea_;
	TabView *hoveredTab_;  // weak. Tab that the mouse is hovering over
	
	// Array of subviews which are permanent (and which should never be removed),
	// such as the new-tab button, but *not* the tabs themselves.
	NSMutableArray *permanentSubviews_;
	
	// Is the mouse currently inside the strip;
	BOOL mouseInside_;
}

// Initialize the controller with a view and browser that contains
// everything else we'll need. |switchView| is the view whose contents get
// "switched" every time the user switches tabs. The children of this view
// will be released, so if you want them to stay around, make sure
// you have retained them.
- (id)initWithView:(TabStrip *)view
        switchView:(NSView*)switchView
		  document:(MyDocument *)document;

// Return the view for the currently selected tab.
- (NSView*)selectedTabView;

// Set the frame of the selected tab, also updates the internal frame dict.
- (void)setFrameOfSelectedTab:(NSRect)frame;

// Returns the index of the subview |view|. Returns -1 if not present. Takes
// closing tabs into account such that this index will correctly match the tab
// model. If |view| is in the process of closing, returns -1, as closing tabs
// are no longer in the model.
- (NSInteger)modelIndexForTabView:(NSView*)view;

// Return the view at a given index.
- (NSView*)viewAtIndex:(NSUInteger)index;

// Returns whether or not |tab| can still be fully seen in the tab strip or if
// its current position would cause it be obscured by things such as the edge
// of the window or the window decorations. Returns YES only if the entire tab
// is visible.
- (BOOL)isTabFullyVisible:(TabView *)tab;

// Show or hide the new tab button. The button is hidden immediately, but
// waits until the next call to |-layoutTabs| to show it again.
- (void)showNewTabButton:(BOOL)show;

// Force the tabs to rearrange themselves to reflect the current model.
- (void)layoutTabs;

// Are we in rapid (tab) closure mode? I.e., is a full layout deferred (while
// the user closes tabs)? Needed to overcome missing clicks during rapid tab
// closure.
- (BOOL)inRapidClosureMode;

// Called by the CAAnimation delegate when the tab completes the closing
// animation.
- (void)animationDidStopForController:(TabController *)controller
                             finished:(BOOL)finished;

// Called when a notification is received from the model to insert a new tab
// at |modelIndex|.
- (void)insertTabWithContents:(FRWatcherTabContentsController *)contents
                      atIndex:(NSInteger)modelIndex
                 inForeground:(BOOL)inForeground;

// Called when a notification is received from the model to select a particular
// tab. Swaps in the content area associated with |newContents|.
- (void)selectTabWithContents:(FRWatcherTabContentsController *)newContents
             previousContents:(FRWatcherTabContentsController *)oldContents
                      atIndex:(NSInteger)modelIndex
                  userGesture:(BOOL)wasUserGesture;

// remove a tab from the strip and animate it out
- (void)removeTabAtIndex:(int)indexu;

// insert a placefolder at position given by |frame|
// will relayout the tabs to make space
- (void)insertPlaceholderForTab:(TabView *)tab
                          frame:(NSRect)frame
                  yStretchiness:(CGFloat)yStretchiness;

// this will return no if there are pending animations
- (BOOL)tabDraggingAllowed;

// Move the given tab at index |from| in this window to the location of the
// current placeholder.
- (void)moveTabFromIndex:(NSInteger)from;

// drop tab contents at the poitino of the current placeholder. Goes to the end if there 
// is no placholder
- (void)dropTabContents:(FRWatcherTabContentsController *)contents withFrame:(NSRect)frame;

// Called when a tab is moved (usually by drag&drop). Keep our parallel arrays
// in sync with the tab strip model.
- (void)tabMovedWithContents:(FRWatcherTabContentsController *)contents
                   fromIndex:(NSInteger)modelFrom
                     toIndex:(NSInteger)modelTo;

// Finds the Tab Contents Controller associated with the given index into the tab
// model and swaps out the sole child of the contentArea to display its
// contents.
- (void)swapInTabAtIndex:(NSInteger)modelIndex;

// Handles setting the title of the tab at |index| 
- (void)setTabTitle:(NSString *)newTitle forTab:(int)index;

// Handles setting the image count for the tab badge of the tab at |index| 
- (void)setNewImageCount:(int)newCount forTab:(int)index;

- (NSInteger)modelIndexForContentsView:(NSView*)view;

// attaches the given |window| as a sheet to the contents of the tab
- (void)attachConstrainedWindow:(NSWindow *)window 
						  toTab:(FRWatcherTabContentsController *)tabController;

// called by the tab contents controller to let us know that a sheet ended
// makes the tab draggable again
- (void)sheetDidEnd:(NSWindow *)sheet 
		 returnCode:(NSInteger)returnCode 
		contextInfo:(void *)contextInfo;

// Handles changing the throbber state
- (void)updateThrobberForTabContents:(FRWatcherTabContentsController *)tabContentsController
							 atIndex:(NSInteger)modelIndex;

// tells the model to create a new tab and add it to the end of the tabstrip
- (void)newTab:(id)sender;

// Called when the user closes a tab. Asks the model to close the tab. |sender|
// is the TabView that is potentially going away.
- (void)closeTab:(id)sender;

// Default height for tabs.
+ (CGFloat)defaultTabHeight;

@end
