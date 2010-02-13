//
//  TabbedWindowController.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
//  Based on "browser_window_controller.mm" and "tab_window_controller.mm" from 
//  the Chromium project
//  Copyright (c) 2009 The Chromium Authors. All rights reserved.
//  Use of this source code is governed by a BSD-style license.

#import "TabbedWindowController.h"
#import "GTMTheme.h"
#import "FRPreferenceController.h"

const int kScrollbarWidth = 25;

@interface TabbedWindowController ()

// Repositions the window's subviews.
- (void)layoutSubviews;

// Lays out the tab content area between the given minimum and maximum
// y-coordinates, with the given width.
- (void)layoutTabContentAreaAtMinY:(CGFloat)minY
                              maxY:(CGFloat)maxY
                             width:(CGFloat)width;
- (void)setUseOverlay:(BOOL)useOverlay;
- (MyDocument *)myDocument;
- (void)detachTabView:(NSView*)view;
- (CGFloat)layoutToolbarAtMaxY:(CGFloat)maxY width:(CGFloat)width;
- (void)selectTabWithOpenSheet;
@end


@implementation TabbedWindowController

@synthesize tabStripView;
@synthesize tabContentsArea;
@synthesize toolbarController;
@synthesize sheetController = sheetController_;
@synthesize tabStripModel;

- (id)initWithWindow:(NSWindow*)window 
{
	if ((self = [super initWithWindow:window]) != nil) 
	{
		lockedTabs = [[NSMutableSet alloc] initWithCapacity:10];
	}
	return self;
}

- (id)initWithDocument:(MyDocument *)document tabContents:(FRWatcherTabContentsController *)newContents takeOwnership:(BOOL)own
{
	self = [super initWithWindowNibName:@"MyDocument" owner:self];
	if (self) 
	{
		initializing = YES;
		
		theme_ =  [GTMTheme defaultTheme];
		myDocument = document;
		tabStripModel = [myDocument tabStripModel];
		
		// force the loading of the nib by asking for the window
		TabbedWindow *theWindow = (TabbedWindow *)[self window];
		
		// create the tab strip and it's controller
		tabStripController = [[TabStripController alloc] initWithView:[self tabStripView]
														   switchView:[self tabContentsArea]
															 document:document];
		
		// create the toolbar and add it to the window
		toolbarController = [[ToolbarController alloc] initWithMyDocument:myDocument];
		[[[self window] contentView] addSubview:[toolbarController view]];
		[toolbarController setupInitialStates];
		[tabStripModel setToolbarController:toolbarController];
		
		// Force a relayout of all the various bars.
		[self layoutSubviews];
		
		// Create the sheet controller
		sheetController_ = [[GTMWindowSheetController alloc] initWithWindow:[self window]
																   delegate:self];
		
		// if we are given the contents of the first tab, create it
		// otherwise create a blank new tab
		if (newContents) 
			[tabStripModel appendTabContents:newContents bringToFront:YES];
		else 
			[tabStripModel addNewTab];
		
		initializing = NO;
	}
	return self;
}

- (void)windowDidLoad 
{
	// Place the tab bar above the content box and add it to the view hierarchy
	// as a sibling of the content view so it can overlap with the window frame.
	NSRect tabFrame = [tabContentsArea frame];
	tabFrame.origin = NSMakePoint(0, NSMaxY(tabFrame));
	tabFrame.size.height = NSHeight([tabStripView frame]);
	
	[tabStripView setFrame:tabFrame];
	[[(TabbedWindow *)[self window] frameView] addSubview:tabStripView];
	[tabStripView setNeedsDisplay:YES];
	
	[[self window] setContentBorderThickness:24.0 forEdge:NSMinYEdge];
}

- (void)showOverlay 
{
	[self setUseOverlay:YES];
}

- (void)removeOverlay 
{
	[self setUseOverlay:NO];
	if (closeDeferred) 
	{
		[[self window] orderOut:self];
		[[self window] performClose:self];  // Autoreleases the controller.
	}
}

// if |useOverlay| is true, we're moving views into the overlay's content
// area. If false, we're moving out of the overlay back into the window's
// content.
- (void)moveViewsBetweenWindowAndOverlay:(BOOL)useOverlay 
{
	if (useOverlay) 
	{
		[[[overlayWindow_ contentView] superview] addSubview:[self tabStripView]];
		// Add the original window's content view as a subview of the overlay
		// window's content view.  We cannot simply use setContentView: here because
		// the overlay window has a different content size (due to it being
		// borderless).
		[[overlayWindow_ contentView] addSubview:cachedContentView];
	} 
	else 
	{
		[[[[self window] contentView] superview] addSubview:[self tabStripView]];
		[[self window] setContentView:cachedContentView];
		[[[[self window] contentView] superview] updateTrackingAreas];
	}
}


// If |useOverlay| is YES, creates a new overlay window and puts the tab strip
// and the content area inside of it. This allows it to have a different opacity
// from the title bar. If NO, returns everything to the previous state and
// destroys the overlay window until it's needed again. The tab strip and window
// contents are returned to the original window.
- (void)setUseOverlay:(BOOL)useOverlay 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(removeOverlay)
											   object:nil];
	NSWindow* window = [self window];
	if (useOverlay && !overlayWindow_) 
	{
		overlayWindow_ = [[NSPanel alloc] initWithContentRect:[[self window] frame]
													styleMask:NSBorderlessWindowMask
													  backing:NSBackingStoreBuffered
														defer:YES];
		[overlayWindow_ setTitle:@"overlay"];
		[overlayWindow_ setBackgroundColor:[NSColor clearColor]];
		[overlayWindow_ setOpaque:NO];
		[overlayWindow_ setDelegate:self];
		cachedContentView = [window contentView];
		[self moveViewsBetweenWindowAndOverlay:useOverlay];
		[window addChildWindow:overlayWindow_ ordered:NSWindowAbove];
		[overlayWindow_ orderFront:nil];
	} 
	else if (!useOverlay && overlayWindow_) 
	{
		[window setContentView:cachedContentView];
		[self moveViewsBetweenWindowAndOverlay:useOverlay];
		[window makeFirstResponder:cachedContentView];
		[window display];
		[window removeChildWindow:overlayWindow_];
		[overlayWindow_ orderOut:nil];
		[overlayWindow_ release];
		overlayWindow_ = nil;
		cachedContentView = nil;
	}
}

- (NSWindow*)overlayWindow 
{
	return overlayWindow_;
}


- (id)initWithMyDocument:(MyDocument *)document
{
	return [self initWithDocument:document tabContents:nil takeOwnership:YES];
}

- (BOOL)windowShouldClose:(id)sender 
{	
	// check if there are any open sheets, if there are, close tabs without sheets
	// but leave tabs wiht sheets open. but how to alert the user about what we did?
	if ([[sheetController_ viewsWithAttachedSheets] count] > 0) 
	{
		[self selectTabWithOpenSheet];
		return NO;
	}
	
	if ([tabStripModel count] > 0) 
	{
		// Tab strip isn't empty.  
		
		// Check for any unsaved changes, and prompt the user
		NSArray *tabs = [self tabs];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		for (FRWatcherTabContentsController *t in tabs)
		{
			if (([t changeCount] != 0) && [defaults boolForKey:FRShowCloseWindowAlert]) 
			{
				NSAlert *unsavedAlert = [[NSAlert alloc] init];
				[unsavedAlert setMessageText:@"Are you sure you want to close this window?"];
				[unsavedAlert setInformativeText:@"There are unsaved images downloaded in some of the tabs in this window. Do you want to close the window anyway?"];
				[unsavedAlert addButtonWithTitle:@"Close"];
				[unsavedAlert addButtonWithTitle:@"Cancel"];
				[unsavedAlert setShowsSuppressionButton:YES];
				
				NSInteger returnValue = [unsavedAlert runModal];
				
				if (returnValue == NSAlertFirstButtonReturn)
				{
					if ([[unsavedAlert suppressionButton] state] == NSOnState) 
						[defaults setBool:NO forKey:FRShowCloseWindowAlert];
					
					break;
				}
				if (returnValue == NSAlertSecondButtonReturn)
					return NO;
			}
		}
		
		// Hide the frame (so it appears to have closed
		// immediately) and close all the tabs, allowing the tab contents to close.
		// When the tab strip is empty we'll be called back again.
		[[self window] orderOut:self];
		[tabStripModel closeAllTabs];
		[myDocument close];
		return NO;
	}
	
	// the tab strip is empty, it's ok to close the window
	return YES;
}

// Selects the first tab with an open sheet
- (void)selectTabWithOpenSheet
{
	NSArray *theTabs = [tabStripModel tabs];
	for (FRWatcherTabContentsController *t in theTabs)
	{
		if ([t sheetOpen]) 
		{
			int indexu = [tabStripModel getIndexOfController:t];
			[tabStripModel selectTabContentsAtIndex:indexu userGesture:NO];
			return;
		}
	}
}

// Called right after our window became the main window.
- (void)windowDidBecomeMain:(NSNotification*)notification 
{	
	// TODO(dmaclach): Instead of redrawing the whole window, views that care
	// about the active window state should be registering for notifications.
	[[self window] setViewsNeedDisplay:YES];
	
	// tell the currently selected tab that it become main
	[[tabStripModel selectedTabContents] didBecomeMain];
}

- (void)windowDidResignMain:(NSNotification*)notification 
{
	// TODO(dmaclach): Instead of redrawing the whole window, views that care
	// about the active window state should be registering for notifications.
	[[self window] setViewsNeedDisplay:YES];
	
	// tell the currently selected tab that it became a background window
	[[tabStripModel selectedTabContents] didResignMain];
}

- (void)activate 
{
	[[self window] makeKeyAndOrderFront:self];
}

// Main method to resize browser window subviews.  This method should be called
// when resizing any child of the content view, rather than resizing the views
// directly.  If the view is already the correct height, does not force a
// relayout.
- (void)resizeView:(NSView*)view newHeight:(float)height 
{	
	// Change the height of the view and call |-layoutSubViews|. We set the height
	// here without regard to where the view is on the screen or whether it needs
	// to "grow up" or "grow down."  The below call to |-layoutSubviews| will
	// position each view correctly.
	NSRect frame = [view frame];
	if (frame.size.height == height)
		return;
	
	frame.size.height = height;
	// TODO(rohitrao): Determine if calling setFrame: twice is bad.
	[view setFrame:frame];
	[self layoutSubviews];
}

- (BOOL)hasTabStrip
{
	return YES;
}

- (NSView *)selectedTabView 
{
	return [tabStripController selectedTabView];
}

- (TabStripController *)tabStripController 
{
	return tabStripController;
}

- (void)layoutTabs 
{
	[tabStripController layoutTabs];
}

- (BOOL)isTabFullyVisible:(TabView *)tab 
{
	return [tabStripController isTabFullyVisible:tab];
}

- (void)showNewTabButton:(BOOL)show 
{
	[tabStripController showNewTabButton:show];
}

- (NSInteger)numberOfTabs 
{
	return [[myDocument tabStripModel] count];
}

- (NSString*)selectedTabTitle 
{
	FRWatcherTabContentsController *contents = [[myDocument tabStripModel] selectedTabContents];
	return [contents title];
	return nil;
}

- (void)layoutSubviews 
{
	NSWindow* window = [self window];
	NSView* contentView = [window contentView];
	NSRect contentFrame = [contentView frame];
	CGFloat maxY;
	CGFloat minY = NSMinY(contentFrame);
	CGFloat width = NSWidth(contentFrame);
	maxY = NSMinY([[self tabStripView] frame]);
	
	// Suppress title drawing if necessary.
	if ([[self window] respondsToSelector:@selector(setShouldHideTitle:)])
		[(id)[self window] setShouldHideTitle:YES];
	
	// Place the toolbar at the top of the reserved area.
	maxY = [self layoutToolbarAtMaxY:maxY width:width];
	
	// Finally, the content area takes up all of the remaining space.
	[self layoutTabContentAreaAtMinY:minY maxY:maxY width:width];
}

- (void)layoutTabContentAreaAtMinY:(CGFloat)minY
                              maxY:(CGFloat)maxY
                             width:(CGFloat)width 
{
	NSView *tabContentView = [self tabContentsArea];
	NSRect tabContentFrame = [tabContentView frame];
	tabContentFrame.origin.y = minY;
	tabContentFrame.size.height = maxY - minY;
	tabContentFrame.size.width = width;
	[tabContentView setFrame:tabContentFrame];
}

- (BOOL)shouldConstrainFrameRect
{
	return NO;
}

- (NSRect)windowWillUseStandardFrame:(NSWindow*)window
                        defaultFrame:(NSRect)frame 
{
	// |frame| already fills the current screen. Never touch y and height since we
	// always want to fill vertically.
	
	// If the shift key is down, maximize. Hopefully this should make the
	// "switchers" happy.
	if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask) 
		return frame;
	
	// To prevent strange results on portrait displays, the basic minimum zoomed
	// width is the larger of: 60% of available width, 60% of available height
	// (bounded by available width).
	const CGFloat kProportion = 0.6;
	CGFloat zoomedWidth =
	MAX(kProportion * frame.size.width,
			 MIN(kProportion * frame.size.height, frame.size.width));
	
	FRWatcherTabContentsController *contents = [[myDocument tabStripModel] selectedTabContents];
	if (contents) 
	{
		// If the intrinsic width is bigger, then make it the zoomed width.
		const int kScrollbarWidth = 16;
		CGFloat intrinsicWidth = (CGFloat)[[contents view] frame].size.width + kScrollbarWidth;
		zoomedWidth = MAX(zoomedWidth,
							   MIN(intrinsicWidth, frame.size.width));
	}
	
	// Never shrink from the current size on zoom (see above).
	NSRect currentFrame = [[self window] frame];
	zoomedWidth = MAX(zoomedWidth, currentFrame.size.width);
	
	// |frame| determines our maximum extents. We need to set the origin of the
	// frame -- and only move it left if necessary.
	if (currentFrame.origin.x + zoomedWidth > frame.origin.x + frame.size.width)
		frame.origin.x = frame.origin.x + frame.size.width - zoomedWidth;
	else
		frame.origin.x = currentFrame.origin.x;
	
	// Set the width. Don't touch y or height.
	frame.size.width = zoomedWidth;
	
	return frame;
}

- (void)insertPlaceholderForTab:(TabView *)tab
                          frame:(NSRect)frame
                  yStretchiness:(CGFloat)yStretchiness 
{
	[self showNewTabButton:NO];
	[tabStripController insertPlaceholderForTab:tab
										  frame:frame
								  yStretchiness:yStretchiness];
}

- (void)removePlaceholder 
{
	[self showNewTabButton:YES];
	[tabStripController insertPlaceholderForTab:nil
										  frame:NSZeroRect
								  yStretchiness:0];
}

- (BOOL)isTabDraggable:(NSView *)tabView 
{
	return ![lockedTabs containsObject:tabView];
}

- (void)setTab:(NSView*)tabView isDraggable:(BOOL)draggable 
{
	if (!draggable)
		[lockedTabs addObject:tabView];
	else
		[lockedTabs removeObject:tabView];
}

// Accept tabs from a BrowserWindowController with the same Profile.
- (BOOL)canReceiveFrom:(TabbedWindowController *)source 
{
	if (![source isKindOfClass:[TabbedWindowController class]])
		return NO;

	return YES;
}

- (BOOL)tabDraggingAllowed
{
	return [tabStripController tabDraggingAllowed];
}

- (TabbedWindowController *)detachTabToNewWindow:(TabView *)tabView 
{
	// Disable screen updates so that this appears as a single visual change.
	NSDisableScreenUpdates();

	// Fetch the tab contents for the tab being dragged
	int index = [tabStripController modelIndexForTabView:tabView];
	
	// Set the window size. Need to do this before we detach the tab so it's
	// still in the window. We have to flip the coordinates as that's what
	// is expected by the Browser code.
	NSWindow* sourceWindow = [tabView window];
	NSRect windowRect = [sourceWindow frame];
	NSScreen* screen = [sourceWindow screen];
	windowRect.origin.y =
	[screen frame].size.height - windowRect.size.height -
	windowRect.origin.y;
	NSRect browserRect = NSMakeRect(windowRect.origin.x, windowRect.origin.y,
						  windowRect.size.width, windowRect.size.height);
	
	NSRect tabRect = [tabView frame];
	
	// Select a different tab. This will do nothing if there is only 1 tab.
	[tabStripModel selectNextSelectedTabAfter:index];
	
	// Detach the tab from the source window, which just updates the model without
	// deleting the tab contents. Make sure nothing else tries to talk to the 
	// tabStripModel while we do this.
	TabbedWindowController *controller = nil;
	@synchronized (tabStripModel)
	{
		FRWatcherTabContentsController *contents = 
		[tabStripModel detachTabContentsAtIndex:index];
		
		[contents setMyDocument:nil];
		// Create the new window with a single tab in its model, the one being
		// dragged.
		MyDocument *newDocument =
		[tabStripModel tearOffTabContents:contents rect:browserRect];
		
		// Get the new controller
		controller = 
			(TabbedWindowController *)[[newDocument windowControllers] objectAtIndex:0];
		
		// Force the added tab to the right size (remove stretching.)
		tabRect.size.height = [TabStripController defaultTabHeight];
		
		// And make sure we use the correct frame in the new view.
		[[controller tabStripController] setFrameOfSelectedTab:tabRect];
	}
	// Remove the tab from the old tab strip, which will close the old window if required.
	[tabStripController removeTabAtIndex:index];
	
	NSEnableScreenUpdates();
	return controller;
}

// Move a given tab view to the location of the current placeholder. If there is
// no placeholder, it will go at the end. |controller| is the window controller
// of a tab being dropped from a different window. It will be nil if the drag is
// within the window, otherwise the tab is removed from that window before being
// placed into this one. The implementation will call |-removePlaceholder| since
// the drag is now complete.  This also calls |-layoutTabs| internally so
// clients do not need to call it again.
- (void)moveTabView:(NSView *)view
     fromController:(TabbedWindowController *)dragController 
{
	if (dragController) 
	{
		// Moving between windows. Figure out the TabContents to drop into our tab
		// model from the source window's model.
		BOOL isBrowser =
        [dragController isKindOfClass:[TabbedWindowController class]];

		if (!isBrowser) return;
		TabbedWindowController *dragTWC = (TabbedWindowController *)dragController;
		int index = [[dragTWC tabStripController] modelIndexForTabView:view];
		FRWatcherTabContentsController* contents =
        [[[dragTWC myDocument] tabStripModel] getTabContentsAt:index];
		// The tab contents may have gone away if given a window.close() while it
		// is being dragged. If so, bail, we've got nothing to drop.
		if (!contents)
			return;
		
		// Convert |view|'s frame (which starts in the source tab strip's coordinate
		// system) to the coordinate system of the destination tab strip. This needs
		// to be done before being detached so the window transforms can be
		// performed.
		NSRect destinationFrame = [view frame];
		NSPoint tabOrigin = destinationFrame.origin;
		tabOrigin = [[dragController tabStripView] convertPoint:tabOrigin
														 toView:nil];
		tabOrigin = [[view window] convertBaseToScreen:tabOrigin];
		tabOrigin = [[self window] convertScreenToBase:tabOrigin];
		tabOrigin = [[self tabStripView] convertPoint:tabOrigin fromView:nil];
		destinationFrame.origin = tabOrigin;
		
		// Now that we have enough information about the tab, we can remove it from
		// the dragging window. We need to do this *before* we add it to the new
		// window as this will remove the TabContents' delegate.
		[dragController detachTabView:view];
		
		// Deposit it into our model at the appropriate location (it already knows
		// where it should go from tracking the drag). Doing this sets the tab's
		// delegate to be the Browser.
		[tabStripController dropTabContents:contents withFrame:destinationFrame];
	} 
	else 
	{
		// Moving within a window.
		int index = [tabStripController modelIndexForTabView:view];
		[tabStripController moveTabFromIndex:index];
	}
	
	// Remove the placeholder since the drag is now complete.
	[self removePlaceholder];
}

- (MyDocument *)myDocument
{
	return myDocument;
}

// Tells the tab strip to forget about this tab in preparation for it being
// put into a different tab strip, such as during a drop on another window.
- (void)detachTabView:(NSView*)view 
{
	int index = [tabStripController modelIndexForTabView:view];
	[[myDocument tabStripModel] detachTabContentsAtIndex:index];
}

- (BOOL)hasToolbar
{
	return YES;
}

- (CGFloat)layoutToolbarAtMaxY:(CGFloat)maxY width:(CGFloat)width 
{
	NSView *toolbarView = [toolbarController view];
	NSRect toolbarFrame = [toolbarView frame];
	if ([self hasToolbar]) 
	{
		// The toolbar is present in the window, so we make room for it.
		toolbarFrame.origin.x = 0;
		toolbarFrame.origin.y = maxY - NSHeight(toolbarFrame);
		toolbarFrame.size.width = width;
		maxY -= NSHeight(toolbarFrame);
	} 
	[toolbarView setFrame:toolbarFrame];
	return maxY;
}

- (GTMTheme *)theme
{
	return theme_;
}

- (void)gtm_systemRequestsVisibilityForView:(NSView*)view 
{
	// This implementation is required by GTMWindowSheetController.
	
	// Raise window...
	[[self window] makeKeyAndOrderFront:self];
	
	// ...and raise a tab with a sheet.
	NSInteger index = [tabStripController modelIndexForContentsView:view];
	if (index >= 0)
		[tabStripModel selectTabContentsAtIndex:index userGesture:FALSE];
}


- (IBAction)newTab:(id)sender
{
	[tabStripController newTab:sender];
}

- (IBAction)nextTab:(id)sender
{
	[tabStripModel selectNextTab];
}

- (IBAction)previousTab:(id)sender
{
	[tabStripModel selectPreviousTab];
}

- (IBAction)closeCurrentTab:(id)sender
{
	NSView *tab = [tabStripController viewAtIndex:[tabStripModel selectedIndex]];
	[tabStripController closeTab:tab];
}

// ==============================================================================
#pragma mark menu validation and forwarding

- (BOOL)validateMenuItem:(NSMenuItem *)theMenuItem
{
	BOOL enabled = TRUE; // default state unless one 
						 // of below criteria is met
	
	// Fetch Images menu item
	if ([theMenuItem action] == @selector(startFetcher:))
	{
		// if we are already fetching, menu is disabled
		if ([[[tabStripModel selectedTabContents] operationQueue] operationCount] > 0) 
			enabled = FALSE;
	}
	// Cancel Downloads menu item
	if ([theMenuItem action] == @selector(cancel:)) 
	{
		// if we aren't fetching, menu is disabled
		if ([[[tabStripModel selectedTabContents] operationQueue] operationCount] == 0) 
			enabled = FALSE;
	}
	// Save All… menu item
	if ([theMenuItem action] == @selector(saveFiles:))
	{
		// diable if no images downloaded yet
		if ([[[tabStripModel selectedTabContents] postedImages] count] == 0) 
			enabled = FALSE;
	}
	// Save Selected… menu item
	if ([theMenuItem action] == @selector(saveSelected:))
	{
		// diable if no images selected
		if ([[[tabStripModel selectedTabContents] selectedIndexes] count] == 0) 
			enabled = FALSE;
	}
	// Clear All Tags
	if ([theMenuItem action] == @selector(clearAllTags:))
	{
		// diable if no images downloaded
		if ([[[tabStripModel selectedTabContents] postedImages] count] == 0)
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(clearSelectedTags:))
	{
		// diable if no images selected
		if ([[[tabStripModel selectedTabContents] selectedIndexes] count] == 0) 
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(showPostSheet:)) 
	{
		// disable if we haven't got a thread to post to yet
		if ([[tabStripModel selectedTabContents] threadNumber] == nil)
			enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(switchToIconView:) )
	{
		if ([[[tabStripModel selectedTabContents] 
			  viewSwitcher] selectedTabViewItem] == 
			[[tabStripModel selectedTabContents] iconTabItem]) 
			[theMenuItem setState:NSOnState];
		else 
			[theMenuItem setState:NSOffState];
	}	
	if ([theMenuItem action] == @selector(switchToFullThreadView:))
	{
		// disable if we are already in full thread view
		if ([[[tabStripModel selectedTabContents] 
			  viewSwitcher] selectedTabViewItem] == 
			[[tabStripModel selectedTabContents] iconTabItem]) 
			[theMenuItem setState:NSOffState];
		else 
			[theMenuItem setState:NSOnState];
	}
	if ([theMenuItem action] == @selector(closeCurrentTab:))
	{
		if ([tabStripModel count] < 2)
			 enabled = FALSE;
	}
	if ([theMenuItem action] == @selector(fetchBrowserURL:))
	{
		// disable if we are downloading images
		if ([[[tabStripModel selectedTabContents] 
			  operationQueue] operationCount] > 0) 
			enabled = FALSE;
	}
	
	return enabled;
}

- (IBAction)startFetcher:(id)sender
{
	[[tabStripModel selectedTabContents] startFetcher:sender];
}

- (IBAction)cancel:(id)sender
{
	[[tabStripModel selectedTabContents] cancel:sender];
}

- (IBAction)saveFiles:(id)sender
{
	[[tabStripModel selectedTabContents] saveFiles:sender];
}

- (IBAction)saveSelected:(id)sender
{
	[[tabStripModel selectedTabContents] saveSelected:sender];
}

- (IBAction)clearAllTags:(id)sender
{
	[[tabStripModel selectedTabContents] clearAllTags:sender];
}

- (IBAction)clearSelectedTags:(id)sender
{
	[[tabStripModel selectedTabContents] clearSelectedTags:sender];
}

- (IBAction)showPostSheet:(id)sender
{
	[[tabStripModel selectedTabContents] showPostSheet:sender];
}

- (IBAction)switchToIconView:(id)sender
{
	[[tabStripModel selectedTabContents] switchToIconView:sender];
}

- (IBAction)switchToFullThreadView:(id)sender
{
	[[tabStripModel selectedTabContents] switchToFullThreadView:sender];
}

- (IBAction)fetchBrowserURL:(id)sender
{
	[[tabStripModel selectedTabContents] fetchBrowserURL:sender];
}

- (IBAction)postReply:(id)sender
{
	[[tabStripModel selectedTabContents] postReply:sender];
}

// ============================================================================
#pragma mark scripting 

- (NSArray *)tabs
{
	return [tabStripModel tabs];
}

- (FRWatcherTabContentsController *)currentTab
{
	return [tabStripModel selectedTabContents];
}

// ============================================================================
#pragma mark quicklook
// forward quicklook messages to the active tab

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
	return [[tabStripModel selectedTabContents] acceptsPreviewPanelControl:panel];
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
	[[tabStripModel selectedTabContents] beginPreviewPanelControl:panel];
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
	[[tabStripModel selectedTabContents] endPreviewPanelControl:panel];
}

- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
	return [[tabStripModel selectedTabContents] numberOfPreviewItemsInPreviewPanel:panel];
}

- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)anindex
{
	return [[tabStripModel selectedTabContents] previewPanel:panel previewItemAtIndex:anindex];
}
- (BOOL)previewPanel:(QLPreviewPanel *)panel handleEvent:(NSEvent *)event
{
	return [[tabStripModel selectedTabContents] previewPanel:panel handleEvent:event];
}

- (NSRect)previewPanel:(QLPreviewPanel *)panel sourceFrameOnScreenForPreviewItem:(id <QLPreviewItem>)item
{
	return [[tabStripModel selectedTabContents] previewPanel:panel sourceFrameOnScreenForPreviewItem:item];
}
- (id)previewPanel:(QLPreviewPanel *)panel transitionImageForPreviewItem:(id <QLPreviewItem>)item 
	   contentRect:(NSRect *)contentRect
{
	return [[tabStripModel selectedTabContents] previewPanel:panel 
							   transitionImageForPreviewItem:item 
												 contentRect:contentRect];
}


@end
