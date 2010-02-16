//
//  TabbedWindowController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
//  Based on "browser_window_controller.h" and "tab_window_controller.h" from 
//  the Chromium project
//  Copyright (c) 2009 The Chromium Authors. All rights reserved.
//  Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "TabStrip.h"
#import "MyDocument.h"
#import "TabStripController.h"
#import "TabView.h"
#import "TabbedWindow.h"
#import "GTMTheme.h"
#import "ToolbarController.h"
#import "FRWatcherTabContentsController.h"
#import "GTMWindowSheetController.h"

@class TabStripModel;
@class MyDocument;
@class TabStripController;
@class TabView;
@class ToolbarController;
@class FRWatcherTabContentsController;

@interface TabbedWindowController : NSWindowController <NSWindowDelegate, 
														QLPreviewPanelDelegate, 
														QLPreviewPanelDataSource,
														GTMWindowSheetControllerDelegate>
{
	IBOutlet NSView *tabContentsArea;
	IBOutlet TabStrip *tabStripView;
	IBOutlet NSApplication *theApp;
	
	TabStripModel *tabStripModel;
	
	GTMTheme *theme_;
	
	// For managing our tab-modal sheets
	GTMWindowSheetController *sheetController_;
	
	// Used during dragging for window opacity tricks
	NSWindow *overlayWindow_;
	
	// Used during dragging for identifying which
	// view is the proper content area in the overlay (weak)
	NSView *cachedContentView;
	
	// set to hold tabs that currently can't be dragged
	NSMutableSet *lockedTabs;
	
	BOOL closeDeferred; // If YES, call performClose: in removeOverlay:.
	
	// -----------------------------
	// stuff from BrowserWindowController
	
	MyDocument *myDocument;
	__weak TabStripController *tabStripController;
	__weak ToolbarController *toolbarController;
	
	BOOL initializing;  // YES while we are currently in initWithDocument:
}

@property (readonly, nonatomic) TabStrip *tabStripView;
@property (readonly, nonatomic) NSView *tabContentsArea;
@property (readonly, assign) __weak ToolbarController *toolbarController;
@property (readonly, retain) GTMWindowSheetController *sheetController;
@property (readonly) TabStripModel *tabStripModel;

// create a window for the given document, and create a single new blank tab
- (id)initWithMyDocument:(MyDocument *)document;

// create a window for the given document, and create a single tab with contents |newContents|
- (id)initWithDocument:(MyDocument *)document tabContents:(FRWatcherTabContentsController *)newContents takeOwnership:(BOOL)own;

// Layout the tabs based on the current ordering of the model.
- (void)layoutTabs;

// Show or hide the new tab button. The button is hidden immediately, but
// waits until the next call to |-layoutTabs| to show it again.
- (void)showNewTabButton:(BOOL)show;

// Returns whether or not |tab| can still be fully seen in the tab strip or if
// its current position would cause it be obscured by things such as the edge
// of the window or the window decorations. Returns YES only if the entire tab
// is visible. The default implementation always returns YES.
- (BOOL)isTabFullyVisible:(TabView *)tab;

// Returns YES if it is ok to constrain the window's frame to fit the screen.
- (BOOL)shouldConstrainFrameRect;

// Number of tabs in the tab strip. Useful, for example, to know if we're
// dragging the only tab in the window.
- (NSInteger)numberOfTabs;

// Return the view of the selected tab.
- (NSView *)selectedTabView;

// The title of the selected tab.
- (NSString*)selectedTabTitle;

// Brings this controller's window to the front.
- (void)activate;

// Return a weak pointer to the tab strip controller.
- (TabStripController *)tabStripController;

// insert a placeholder at the location given by |frame| that represents |tab|
- (void)insertPlaceholderForTab:(TabView *)tab
                          frame:(NSRect)frame
                  yStretchiness:(CGFloat)yStretchiness;

// remove any placeholder tabs in the strip
- (void)removePlaceholder;

// the overlay window is used to allow part of the window to be transparent when dragging tabs
- (void)showOverlay;
- (NSWindow *)overlayWindow;
- (void)removeOverlay;

// returns yes if the given |tabView |is draggable. tabs are generally draggable unless they have an open sheet
- (BOOL)isTabDraggable:(NSView *)tabView;

// returns yes if the strip can recieve tabs from |source|. returns yes as long as the source 
// is of the correct class. if it returns no, something bad has happened
- (BOOL)canReceiveFrom:(TabbedWindowController *)source;

// returns yes if tabs can be dragged around in th estrip, and detatched from the strip
- (BOOL)tabDraggingAllowed;

// removes the tab represented by |tabView| from the strip and the model, and returns it,
// ready to be inserted into a new window
- (TabbedWindowController *)detachTabToNewWindow:(TabView *)tabView;

// move a tab view from |dragController| to the surrent location of the placeholder
- (void)moveTabView:(NSView *)view
     fromController:(TabbedWindowController *)dragController;

// returns the theme being used by the window
- (GTMTheme *)theme;

// sadd the |tabView| to our list of locked tabs
- (void)setTab:(NSView*)tabView isDraggable:(BOOL)draggable ;

// action to create a new tab. inserts the new tab at the end of the strip
- (IBAction)newTab:(id)sender;

// action to close the currently selected tab
- (IBAction)closeCurrentTab:(id)sender;

// scripting
- (FRWatcherTabContentsController *)currentTab;
- (NSArray *)tabs;

// ==================================================
// actions we forward to the selected tab contents controller

- (IBAction)startFetcher:(id)sender;
- (IBAction)saveFiles:(id)sender;
- (IBAction)fetchBrowserURL:(id)sender;
- (IBAction)saveSelected:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)switchToIconView:(id)sender;
- (IBAction)switchToFullThreadView:(id)sender;
- (IBAction)postReply:(id)sender;
- (IBAction)fetchBrowserURL:(id)sender;

@end
