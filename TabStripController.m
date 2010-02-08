//
//  TabStripController.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_strip_controller.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "TabStripController.h"
#import "TabController.h"
#import "GTMNSAnimation+Duration.h"
#import "FRWatcherTabContentsController.h"
#import "GTMWindowSheetController.h"
#import "TabController.h"
#import "ThrobberView.h"

NSString *const kTabStripNumberOfTabsChanged = @"kTabStripNumberOfTabsChanged";

// The images names used for different states of the new tab button.
NSString* const kNewTabHoverImage = @"newtab_h.pdf";
NSString* const kNewTabImage = @"newtab.pdf";
NSString* const kNewTabPressedImage = @"newtab_p.pdf";
// A value to indicate tab layout should use the full available width of the
// view.
const CGFloat kUseFullAvailableWidth = -1.0;
// Left-side indent for tab layout so tabs don't overlap with the window
// controls.
const CGFloat kIndentLeavingSpaceForControls = 64.0;
// The amount by which tabs overlap.
const CGFloat kTabOverlap = 20.0;
// The amount by which the new tab button is offset (from the tabs).
const CGFloat kNewTabButtonOffset = 14.0;
// Time (in seconds) in which tabs animate to th
const NSTimeInterval kAnimationDuration = 0.12; // chromium source uses 0.2 here
												// but that feels a lot slower 
												// than the official chrome build
const int kPinnedTabWidth = 56;

// this is based on a C++ class in the chromium code, but probably doesn't
// make much sense in the pure obj-c version, since we don't use 
// scoped_nsobject, so we have to call end manually anyway. MF, 29/01/2010
@interface ScopedNSAnimationContextGroup : NSObject
{
@private
	BOOL animate_;
}

- (id)initWithAnimate:(BOOL)a;
- (void)setCurrentContextDuration:(NSTimeInterval)duration;
- (void)setCurrentContextShortestDuration;
- (void)end;

@end

@implementation ScopedNSAnimationContextGroup

- (id)initWithAnimate:(BOOL)a
{
	self = [super init];
	if (self)
	{
		animate_ = a;
		if (animate_)
		{
			[NSAnimationContext beginGrouping];
		}
	}
	return self;
}

// set the duration of the animations
- (void)setCurrentContextDuration:(NSTimeInterval)duration
{
	if (animate_) 
	{
		[[NSAnimationContext currentContext] gtm_setDuration:duration];
	}
}

// set the duration to be as short as possible
- (void)setCurrentContextShortestDuration
{
	if (animate_) 
	{
		// The C++ version of this class used std::numeric_limits
		// to determine the smallest finite value of an NSTimeInterval
		// variable. This is just a temporary placeholder 
		// till I find a way to do that in Obj-C
		const NSTimeInterval kMinimumTimeInterval = 0.000001;
		[[NSAnimationContext currentContext] setDuration:kMinimumTimeInterval];
	}
}

// end the grouping, and start the animation
- (void)end
{
	if (animate_) 
	{
		[NSAnimationContext endGrouping];
	}
}

@end

// A delegate, owned by the CAAnimation system, that is alerted when the
// animation to close a tab is completed. Calls back to the given tab strip
// to let it know that |controller_| is ready to be removed from the model.
// Since we only maintain weak references, the tab strip must call -invalidate:
// to prevent the use of dangling pointers.
@interface TabCloseAnimationDelegate : NSObject 
{
	@private
	__weak TabStripController *strip_;  // weak; owns us indirectly
	__weak TabController *controller_;  // weak
}

// Will tell |strip| when the animation for |controller|'s view has completed.
// These should not be nil, and will not be retained.
- (id)initWithTabStrip:(TabStripController *)strip
         tabController:(TabController *)controller;

// Invalidates this object so that no further calls will be made to
// |strip_|.  This should be called when |strip_| is released, to
// prevent attempts to call into the released object.
- (void)invalidate;

// CAAnimation delegate method
- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished;
@end


@implementation TabCloseAnimationDelegate

- (id)initWithTabStrip:(TabStripController *)strip
         tabController:(TabController *)controller 
{
	if ((self == [super init])) 
	{
		strip_ = strip;
		controller_ = controller;
	}
	return self;
}

- (void)invalidate 
{
	strip_ = nil;
	controller_ = nil;
}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished 
{
	[strip_ animationDidStopForController:controller_ finished:finished];
}

@end

@interface TabStripController ()

- (void)addSubviewToPermanentList:(NSView*)aView;
- (void)regenerateSubviewList;
- (void)layoutTabsWithAnimation:(BOOL)animate
             regenerateSubviews:(BOOL)doUpdate;
- (void)animationDidStopForController:(TabController *)controller
                             finished:(BOOL)finished;
- (NSInteger)indexFromModelIndex:(NSInteger)index;
- (NSInteger)numberOfOpenTabs;
- (void)mouseMoved:(NSEvent*)event;
- (void)setTabTrackingAreasEnabled:(BOOL)enabled;
- (void)startClosingTabWithAnimation:(TabController *)closingTab;
@end

// A simple view class that prevents the Window Server from dragging the area
// behind tabs. Sometimes core animation confuses it. Unfortunately, it can also
// falsely pick up clicks during rapid tab closure, so we have to account for
// that.
@interface TabStripControllerDragBlockingView : NSView 
{
	TabStripController* controller_;  // weak; owns us
}

- (id)initWithFrame:(NSRect)frameRect
         controller:(TabStripController*)controller;
@end

@implementation TabStripControllerDragBlockingView
- (BOOL)mouseDownCanMoveWindow {return NO;}
- (void)drawRect:(NSRect)rect {}

- (id)initWithFrame:(NSRect)frameRect
         controller:(TabStripController*)controller 
{
	if ((self = [super initWithFrame:frameRect]))
		controller_ = controller;
	return self;
}
@end

@implementation TabStripController

+ (CGFloat)defaultTabHeight 
{
	return 24.0;
}

- (void)newTab:(id)sender
{
	[tabStripModel_ addNewTab];
}

- (id)initWithView:(TabStrip *)view
        switchView:(NSView *)switchView
           document:(MyDocument *)document
{
	if ((self = [super init])) 
	{
		tabStripView_ = [view retain];
		switchView_ = switchView;
		document_ = document;
		tabStripModel_ = [document_ tabStripModel];
		[tabStripModel_ setController:self];
		
		tabContentsArray_ = [[NSMutableArray alloc] init];
		tabArray_ = [[NSMutableArray alloc] init];
		
		// Important note: any non-tab subviews not added to |permanentSubviews_|
		// (see |-addSubviewToPermanentList:|) will be wiped out.
		permanentSubviews_ = [[NSMutableArray alloc] init];
		
		// TODO(viettrungluu): WTF? "For some reason, if the view is present in the
		// nib a priori, it draws correctly. If we create it in code and add it to
		// the tab view, it draws with all sorts of crazy artifacts."
		newTabButton_ = [view newTabButton];
		[self addSubviewToPermanentList:newTabButton_];
		[newTabButton_ setTarget:self];
		[newTabButton_ setAction:@selector(newTab:)];
		[newTabButton_ setTag:34014];
		//[newTabButton_ setTag:IDC_NEW_TAB];
		// Set the images from code because Cocoa fails to find them in our sub
		// bundle during tests.
		[newTabButton_ setImage:[NSImage imageNamed:kNewTabImage]];
		[newTabButton_ setAlternateImage:[NSImage imageNamed:kNewTabPressedImage]];
		newTabTrackingArea_ = [[NSTrackingArea alloc] initWithRect:[newTabButton_ bounds]
														   options:(NSTrackingMouseEnteredAndExited |
																	NSTrackingActiveAlways)
															 owner:self
														  userInfo:nil];
		[newTabButton_ addTrackingArea:newTabTrackingArea_];
		targetFrames_ = [[NSMutableDictionary alloc] init];
		
		dragBlockingView_ = [[TabStripControllerDragBlockingView alloc] initWithFrame:NSZeroRect
																		   controller:self];
		
		[self addSubviewToPermanentList:dragBlockingView_];
		
		newTabTargetFrame_ = NSMakeRect(0, 0, 0, 0);
		availableResizeWidth_ = kUseFullAvailableWidth;
		
		closingControllers_ = [[NSMutableSet alloc] init];
		
		// Install the permanent subviews.
		[self regenerateSubviewList];
		
		// Watch for notifications that the tab strip view has changed size so
		// we can tell it to layout for the new size.
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(tabViewFrameChanged:)
													 name:NSViewFrameDidChangeNotification
												   object:tabStripView_];
		
		trackingArea_ = [[NSTrackingArea alloc] initWithRect:NSZeroRect  // Ignored by NSTrackingInVisibleRect
													 options:(NSTrackingMouseEnteredAndExited |
															  NSTrackingMouseMoved |
															  NSTrackingActiveAlways |
															  NSTrackingInVisibleRect)
													   owner:self
													userInfo:nil];
		[tabStripView_ addTrackingArea:trackingArea_];
		
		// Check to see if the mouse is currently in our bounds so we can
		// enable the tracking areas.  Otherwise we won't get hover states
		// or tab gradients if we load the window up under the mouse.
		NSPoint mouseLoc = [[view window] mouseLocationOutsideOfEventStream];
		mouseLoc = [view convertPointFromBase:mouseLoc];
		if (NSPointInRect(mouseLoc, [view bounds])) 
		{
			[self setTabTrackingAreasEnabled:YES];
			mouseInside_ = YES;
		}
	}
	return self;
}

// Finds the TabContentsController associated with the given index into the tab
// model and swaps out the sole child of the contentArea to display its
// contents.
- (void)swapInTabAtIndex:(NSInteger)modelIndex 
{
	NSInteger index = [self indexFromModelIndex:modelIndex];
	FRWatcherTabContentsController *controller = [tabContentsArray_ objectAtIndex:index];
	
	// Resize the new view to fit the window. Calling |view| may lazily
	// instantiate the TabContentsController from the nib. Until we call
	// |-ensureContentsVisible|, the controller doesn't install the RWHVMac into
	// the view hierarchy. This is in order to avoid sending the renderer a
	// spurious default size loaded from the nib during the call to |-view|.
	NSView* newView = [controller view];
	NSRect frame = [switchView_ bounds];
	[newView setFrame:frame];
	[controller ensureContentsVisible];
	
	// Remove the old view from the view hierarchy. We know there's only one
	// child of |switchView_| because we're the one who put it there. There
	// may not be any children in the case of a tab that's been closed, in
	// which case there's no swapping going on.
	NSArray* subviews = [switchView_ subviews];
	if ([subviews count])
	{
		NSView* oldView = [subviews objectAtIndex:0];
		[switchView_ replaceSubview:oldView with:newView];
	} 
	else 
		[switchView_ addSubview:newView];
	
	[newView setNeedsDisplay:YES];
	
	TabbedWindowController *windowController =
		(TabbedWindowController *)[[switchView_ window] windowController];
	GTMWindowSheetController *sheetController = [windowController sheetController];
	[sheetController setActiveView:[controller ourView]];
	
	// Tell per-tab sheet manager about currently selected tab.
	/*if (sheetController_) 
		[sheetController_ setActiveView:newView];*/
}


// Create a new tab view and set its cell correctly so it draws the way we want
// it to. It will be sized and positioned by |-layoutTabs| so there's no need to
// set the frame here. This also creates the view as hidden, it will be
// shown during layout.
- (TabController *)newTab 
{
	TabController* controller = [[[TabController alloc] init] autorelease];
	[controller setTarget:self];
	[controller setAction:@selector(selectTab:)];
	[[controller view] setHidden:YES];
	
	return controller;
}

// (Private) Returns the number of open tabs in the tab strip. This is the
// number of TabControllers we know about (as there's a 1-to-1 mapping from
// these controllers to a tab) less the number of closing tabs.
- (NSInteger)numberOfOpenTabs 
{
	return [tabStripModel_ count];
}

// Given an index into the tab model, returns the index into the tab controller
// or tab contents controller array accounting for tabs that are currently
// closing. For example, if there are two tabs in the process of closing before
// |index|, this returns |index| + 2. If there are no closing tabs, this will
// return |index|.
- (NSInteger)indexFromModelIndex:(NSInteger)index 
{
	if (index < 0)
		return index;
	
	NSInteger i = 0;
	for (TabController* controller in tabArray_) 
	{
		if ([closingControllers_ containsObject:controller]) 
		{
			++index;
		}
		if (i == index)  // No need to check anything after, it has no effect.
			break;
		++i;
	}
	return index;
}

// Returns the index of the subview |view|. Returns -1 if not present. Takes
// closing tabs into account such that this index will correctly match the tab
// model. If |view| is in the process of closing, returns -1, as closing tabs
// are no longer in the model.
- (NSInteger)modelIndexForTabView:(NSView *)view 
{
	NSInteger index = 0;
	for (TabController* current in tabArray_) 
	{
		// If |current| is closing, skip it.
		if ([closingControllers_ containsObject:current])
			continue;
		else if ([current view] == view)
			return index;
		++index;
	}
	NSLog(@"Error finding index of tab");
	return -1;
}

// Returns the index of the contents subview |view|. Returns -1 if not present.
// Takes closing tabs into account such that this index will correctly match the
// tab model. If |view| is in the process of closing, returns -1, as closing
// tabs are no longer in the model.
- (NSInteger)modelIndexForContentsView:(NSView *)view 
{
	NSInteger index = 0;
	NSInteger i = 0;
	for (FRWatcherTabContentsController *current in tabContentsArray_)
	{
		// If the TabController corresponding to |current| is closing, skip it.
		TabController *controller = [tabArray_ objectAtIndex:i];

		if ([closingControllers_ containsObject:controller]) 
		{
			++i;
			continue;
		} 
		else if ([current view] == view) 
			return index;
		
		++index;
		++i;
	}
	NSLog(@"Error finding intex of tab contents");
	return -1;
}

// Returns the view at the given index, using the array of TabControllers to
// get the associated view. Returns nil if out of range.
- (NSView *)viewAtIndex:(NSUInteger)index 
{
	if (index >= [tabArray_ count])
		return NULL;
	
	return [[tabArray_ objectAtIndex:index] view];
}

// Called when the user clicks a tab. Tell the model the selection has changed,
// which feeds back into us via a notification.
- (void)selectTab:(id)sender 
{
	int index = [self modelIndexForTabView:sender];
	if ([tabStripModel_ containsIndex:index])
		[tabStripModel_ selectTabContentsAtIndex:index userGesture:TRUE];
}

// Called when the user closes a tab. Asks the model to close the tab. |sender|
// is the TabView that is potentially going away.
- (void)closeTab:(id)sender 
{
	if ([hoveredTab_ isEqual:sender]) 
		hoveredTab_ = nil;
	
	NSInteger index = [self modelIndexForTabView:sender];
	if (![tabStripModel_ containsIndex:index])
		return;
	
	// FRWatcherTabContentsController *contents = [tabStripModel_ getTabContentsAt:index];
	
	const NSInteger numberOfOpenTabs = [self numberOfOpenTabs];
	if (numberOfOpenTabs > 1) 
	{
		BOOL isClosingLastTab = (index == numberOfOpenTabs - 1);
		if (!isClosingLastTab)
		{
			// Limit the width available for laying out tabs so that tabs are not
			// resized until a later time (when the mouse leaves the tab strip).
			// TODO(pinkerton): re-visit when handling tab overflow.
			NSView* penultimateTab = [self viewAtIndex:numberOfOpenTabs - 2];
			availableResizeWidth_ = NSMaxX([penultimateTab frame]);
		}
		else 
		{
			// If the rightmost tab is closed, change the available width so that
			// another tab's close button lands below the cursor (assuming the tabs
			// are currently below their maximum width and can grow).
			NSView* lastTab = [self viewAtIndex:numberOfOpenTabs - 1];
			availableResizeWidth_ = NSMaxX([lastTab frame]);
		}
		
		BOOL isClosingFirstTab = (index == 0);
		if (isClosingFirstTab && ([tabStripModel_ selectedIndex] == 0)) 
		{
			// make sure the new first tab is selected if 
			// we closed the first tab
			[[tabArray_ objectAtIndex:1] setSelected:YES];
		}
		
		[tabStripModel_ closeTabContentsAtIndex:index];
	} 
	else 
	{
		// Use the standard window close if this is the last tab
		// this prevents the tab from being removed from the model until after
		// the window dissapears
		[[tabStripView_ window] performClose:nil];
	}
}

- (void)insertPlaceholderForTab:(TabView *)tab
                          frame:(NSRect)frame
                  yStretchiness:(CGFloat)yStretchiness 
{
	placeholderTab_ = tab;
	placeholderFrame_ = frame;
	placeholderStretchiness_ = yStretchiness;
	[self layoutTabsWithAnimation:initialLayoutComplete_ regenerateSubviews:NO];
}

- (BOOL)isTabFullyVisible:(TabView *)tab 
{
	NSRect frame = [tab frame];
	return NSMinX(frame) >= kIndentLeavingSpaceForControls &&
	NSMaxX(frame) <= NSMaxX([tabStripView_ frame]);
}

- (void)showNewTabButton:(BOOL)show 
{
	forceNewTabButtonHidden_ = show ? NO : YES;
	if (forceNewTabButtonHidden_)
		[newTabButton_ setHidden:YES];
}

// Lay out all tabs in the order of their TabContentsControllers, which matches
// the ordering in the TabStripModel. This call isn't that expensive, though
// it is O(n) in the number of tabs. Tabs will animate to their new position
// if the window is visible and |animate| is YES.
// TODO(pinkerton): Handle drag placeholders via proxy objects, perhaps a
// subclass of TabContentsController with everything stubbed out or by
// abstracting a base class interface.
// TODO(pinkerton): Note this doesn't do too well when the number of min-sized
// tabs would cause an overflow.
- (void)layoutTabsWithAnimation:(BOOL)animate
             regenerateSubviews:(BOOL)doUpdate 
{
	if (![tabArray_ count])
		return;
	
	const CGFloat kMaxTabWidth = [TabController maxTabWidth];
	const CGFloat kMinTabWidth = [TabController minTabWidth];
	const CGFloat kMinSelectedTabWidth = [TabController minSelectedTabWidth];
	
	NSRect enclosingRect = NSZeroRect;
	ScopedNSAnimationContextGroup *mainAnimationGroup = 
	[[ScopedNSAnimationContextGroup alloc] initWithAnimate:animate];
	[mainAnimationGroup setCurrentContextDuration:kAnimationDuration];
	
	// Update the current subviews and their z-order if requested.
	if (doUpdate)
		[self regenerateSubviewList];
	
	// Compute the base width of tabs given how much room we're allowed. Note that
	// pinned tabs have a fixed width. We may not be able to use the entire width
	// if the user is quickly closing tabs. This may be negative, but that's okay
	// (taken care of by |MAX()| when calculating tab sizes).
	CGFloat availableWidth = 0;
	if ([self inRapidClosureMode]) 
	{
		availableWidth = availableResizeWidth_;
	} 
	else 
	{
		availableWidth = NSWidth([tabStripView_ frame]);
		availableWidth -= NSWidth([newTabButton_ frame]) + kNewTabButtonOffset;
	}
	availableWidth -= kIndentLeavingSpaceForControls;
	
	// This may be negative, but that's okay (taken care of by |MAX()| when
	// calculating tab sizes).
	CGFloat availableWidthForUnpinned = availableWidth;
															
	// Initialize |unpinnedTabWidth| in case there aren't any unpinned tabs; this
	// value shouldn't actually be used.
	CGFloat unpinnedTabWidth = kMaxTabWidth;
	const NSInteger numberOfOpenUnpinnedTabs = [self numberOfOpenTabs];
	if (numberOfOpenUnpinnedTabs) 
	{  
		// Find the width of an unpinned tab.
		// Add in the amount we "get back" from the tabs overlapping.
		availableWidthForUnpinned += (numberOfOpenUnpinnedTabs - 1) * kTabOverlap;
		
		// Divide up the space between the unpinned tabs.
		unpinnedTabWidth = availableWidthForUnpinned / numberOfOpenUnpinnedTabs;
		
		// Clamp the width between the max and min.
		unpinnedTabWidth = MAX(MIN(unpinnedTabWidth, kMaxTabWidth), kMinTabWidth);
	}
	
	const CGFloat minX = NSMinX(placeholderFrame_);
	BOOL visible = [[tabStripView_ window] isVisible];
	
	CGFloat offset = kIndentLeavingSpaceForControls;
	NSUInteger i = 0;
	BOOL hasPlaceholderGap = FALSE;
	for (TabController *tab in tabArray_) 
	{
		// Ignore a tab that is going through a close animation.
		if ([closingControllers_ containsObject:tab])
			continue;
			
		BOOL isPlaceholder = [[tab view] isEqual:placeholderTab_];
		NSRect tabFrame = [[tab view] frame];
		tabFrame.size.height = [[self class] defaultTabHeight] + 1;
		tabFrame.origin.y = 0;
		tabFrame.origin.x = offset;
		
		// If the tab is hidden, we consider it a new tab. We make it visible
		// and animate it in.
		BOOL newTab = [[tab view] isHidden];
		if (newTab)
			[[tab view] setHidden:NO];
		
		if (isPlaceholder) 
		{
			// Move the current tab to the correct location instantly.
			// We need a duration or else it doesn't cancel an inflight animation.
			ScopedNSAnimationContextGroup *localAnimationGroup = 
			[[ScopedNSAnimationContextGroup alloc] initWithAnimate:animate];
			[localAnimationGroup setCurrentContextShortestDuration];
			tabFrame.origin.x = placeholderFrame_.origin.x;

			// weeeee, stretchy
			tabFrame.size.height += 10.0 * placeholderStretchiness_;
			
			id target = animate ? [[tab view] animator] : [tab view];
			[target setFrame:tabFrame];
			
			// Store the frame by identifier to aviod redundant calls to animator.
			NSValue* identifier = [NSValue valueWithPointer:[tab view]];
			[targetFrames_ setObject:[NSValue valueWithRect:tabFrame]
							  forKey:identifier];
			[localAnimationGroup end];
			continue;
		}
		
		// If our left edge is to the left of the placeholder's left, but our mid is
		// to the right of it we should slide over to make space for it.
		if (placeholderTab_ && !hasPlaceholderGap && NSMidX(tabFrame) > minX) 
		{
			hasPlaceholderGap = TRUE;
			offset += NSWidth(placeholderFrame_);
			offset -= kTabOverlap;
			tabFrame.origin.x = offset;
		}
		
		// Set the width. Selected tabs are slightly wider when things get really
		// small and thus we enforce a different minimum width.
		tabFrame.size.width = unpinnedTabWidth;
		if ([tab selected])
			tabFrame.size.width = MAX(tabFrame.size.width, kMinSelectedTabWidth);
		
		// Animate a new tab in by putting it below the horizon unless told to put
		// it in a specific location (i.e., from a drop).
		if (newTab && visible && animate) 
		{
			if (NSEqualRects(droppedTabFrame_, NSZeroRect)) 
			{
				[[tab view] setFrame:NSOffsetRect(tabFrame, 0, -NSHeight(tabFrame))];
			} 
			else 
			{
				[[tab view] setFrame:droppedTabFrame_];
				droppedTabFrame_ = NSZeroRect;
			}
		}
		
		// Check the frame by identifier to avoid redundant calls to animator.
		id frameTarget = visible && animate ? [[tab view] animator] : [tab view];
		NSValue* identifier = [NSValue valueWithPointer:[tab view]];
		NSValue* oldTargetValue = [targetFrames_ objectForKey:identifier];
		if (!oldTargetValue ||
			!NSEqualRects([oldTargetValue rectValue], tabFrame)) 
		{
			[frameTarget setFrame:tabFrame];
			[targetFrames_ setObject:[NSValue valueWithRect:tabFrame]
							  forKey:identifier];
		}
		
		enclosingRect = NSUnionRect(tabFrame, enclosingRect);
		
		offset += NSWidth(tabFrame);
		offset -= kTabOverlap;
		i++;
	}
	
	// Hide the new tab button if we're explicitly told to. It may already
	// be hidden, doing it again doesn't hurt. Otherwise position it
	// appropriately, showing it if necessary.
	if (forceNewTabButtonHidden_) 
		[newTabButton_ setHidden:YES];
	else 
	{
		NSRect newTabNewFrame = [newTabButton_ frame];
		// We've already ensured there's enough space for the new tab button
		// so we don't have to check it against the available width. We do need
		// to make sure we put it after any placeholder.
		newTabNewFrame.origin = NSMakePoint(offset, 0);
		newTabNewFrame.origin.x = MAX(newTabNewFrame.origin.x,
									  NSMaxX(placeholderFrame_)) +
		kNewTabButtonOffset;
		if ([tabContentsArray_ count])
			[newTabButton_ setHidden:NO];
		
		if (!NSEqualRects(newTabTargetFrame_, newTabNewFrame)) 
		{
			// Set the new tab button image correctly based on where the cursor is.
			NSWindow* window = [tabStripView_ window];
			NSPoint currentMouse = [window mouseLocationOutsideOfEventStream];
			currentMouse = [tabStripView_ convertPoint:currentMouse fromView:nil];
			NSString* imageName = nil;
			if (NSPointInRect(currentMouse, newTabNewFrame)) 
				imageName = kNewTabHoverImage;
			else 
				imageName = kNewTabImage;
			[newTabButton_ setImage:[NSImage imageNamed:imageName]];
			
			// Move the new tab button into place. We want to animate the new tab
			// button if it's moving to the left (closing a tab), but not when it's
			// moving to the right (inserting a new tab). If moving right, we need
			// to use a very small duration to make sure we cancel any in-flight
			// animation to the left.
			if (visible && animate) 
			{
				ScopedNSAnimationContextGroup *localAnimationGroup = 
				[[ScopedNSAnimationContextGroup alloc] initWithAnimate:TRUE];
				BOOL movingLeft = NSMinX(newTabNewFrame) < NSMinX(newTabTargetFrame_);
				if (!movingLeft) 
					[localAnimationGroup setCurrentContextShortestDuration];
				
				[[newTabButton_ animator] setFrame:newTabNewFrame];
				newTabTargetFrame_ = newTabNewFrame;
				[localAnimationGroup end];
			} 
			else 
			{
				[newTabButton_ setFrame:newTabNewFrame];
				newTabTargetFrame_ = newTabNewFrame;
			}
		}
	}
	
	[dragBlockingView_ setFrame:enclosingRect];
	// Mark that we've successfully completed layout of at least one tab.
	initialLayoutComplete_ = YES;
	
	[mainAnimationGroup end];
}

// When we're told to layout from the public API we usually want to animate,
// except when it's the first time.
- (void)layoutTabs 
{
	[self layoutTabsWithAnimation:initialLayoutComplete_ regenerateSubviews:YES];
}

// Handles setting the title of the tab at |index| 
- (void)setTabTitle:(NSString *)newTitle forTab:(int)index 
{
	[[tabArray_ objectAtIndex:index] setTitle:newTitle];
}

// Handles setting the image count for the tab badge of the tab at |index| 
- (void)setNewImageCount:(int)newCount forTab:(int)index
{
	[(TabController *)[tabArray_ objectAtIndex:index] setCount:newCount];
}

// Called when a notification is received from the model to insert a new tab
// at |modelIndex|.
- (void)insertTabWithContents:(FRWatcherTabContentsController *)contents
                      atIndex:(NSInteger)modelIndex
                 inForeground:(BOOL)inForeground 
{	
	// Take closing tabs into account.
	NSInteger index = [self indexFromModelIndex:modelIndex];
	
	if ([tabContentsArray_ count] == index) 
		[tabContentsArray_ addObject:contents];
	else 
		[tabContentsArray_ insertObject:contents atIndex:index];
	
	// Make a new tab and add it to the strip. Keep track of its controller.
	TabController * newController = [self newTab];
	if ([tabArray_ count] == index) 
		[tabArray_ addObject:newController];
	else 
		[tabArray_ insertObject:newController atIndex:index];
	
	NSView* newView = [newController view];
	
	// Set the originating frame to just below the strip so that it animates
	// upwards as it's being initially layed out. Oddly, this works while doing
	// something similar in |-layoutTabs| confuses the window server.
	// TODO(pinkerton): I'm not happy with this animiation either, but it's
	// a little better that just sliding over (maybe?).
	[newView setFrame:NSOffsetRect([newView frame],
								   0, -[[self class] defaultTabHeight])];
	
	[self setTabTitle:[contents threadName] forTab:index];
	
	// If a tab is being inserted, we can again use the entire tab strip width
	// for layout.
	availableResizeWidth_ = kUseFullAvailableWidth;
	
	
	// We don't need to call |-layoutTabs| if the tab will be in the foreground
	// because it will get called when the new tab is selected by the tab model.
	// Whenever |-layoutTabs| is called, it'll also add the new subview.
	if (!inForeground)
		[self layoutTabs];
	
	if (inForeground) 
	{
		[self selectTabWithContents:contents 
				   previousContents:currentTab_ 
							atIndex:index 
						userGesture:YES];
	}
	
	[self updateThrobberForTabContents:contents atIndex:modelIndex];
	
	// Send a broadcast that the number of tabs have changed.
	[[NSNotificationCenter defaultCenter] postNotificationName:kTabStripNumberOfTabsChanged
														object:self];
}

// Called when a notification is received from the model to select a particular
// tab. Swaps in the content area associated with |newContents|.
- (void)selectTabWithContents:(FRWatcherTabContentsController *)newContents
             previousContents:(FRWatcherTabContentsController *)oldContents
                      atIndex:(NSInteger)modelIndex
                  userGesture:(BOOL)wasUserGesture 
{
	if (newContents == oldContents) 
		return;
	
	// Take closing tabs into account.
	NSInteger index = [self indexFromModelIndex:modelIndex];
	
	// De-select all other tabs and select the new tab.
	int i = 0;
	for (TabController *current in tabArray_) 
	{
		[current setSelected:(i == index) ? YES : NO];
		++i;
	}
	
	// just in case we ever get here with no open tabs
	if ([tabArray_ count] == 0) 
		return;
	
	// Tell the new tab contents it is about to become the selected tab. Here it
	// can do things like make sure the toolbar is up to date.
	FRWatcherTabContentsController *newController = [tabContentsArray_ objectAtIndex:index];
	[newController willBecomeSelectedTab];
	
	// Relayout for new tabs and to let the selected tab grow to be larger in
	// size than surrounding tabs if the user has many. This also raises the
	// selected tab to the top.
	[self layoutTabs];

	if (oldContents) 
	{
		int index = [[document_ tabStripModel] getIndexOfController:oldContents];
		if (index != -1) 
		{  
			// When closing a tab, the old tab may be gone.
			FRWatcherTabContentsController *oldController =
			[tabContentsArray_ objectAtIndex:index];
			[oldController willBecomeUnselectedTab];
			[oldContents wasHidden];
		}
	}
	
	// Swap in the contents for the new tab.
	[self swapInTabAtIndex:modelIndex];
	
	if (newContents) 
		[newContents didBecomeSelected];
}

- (void)removeTabAtIndex:(int)indexu
{
	const NSInteger numberOfOpenTabs = [self numberOfOpenTabs];
	if (numberOfOpenTabs == 0) 
	{
		// if there are no tabs left, close the window
		[[tabStripView_ window] performClose:nil];
		return;
	}

	TabController *tabToClose = [tabArray_ objectAtIndex:indexu];
	[self startClosingTabWithAnimation:tabToClose];
}

// Remove all knowledge about this tab and its associated controller, and remove
// the view from the strip.
- (void)removeTab:(TabController*)controller 
{
	NSUInteger index = [tabArray_ indexOfObject:controller];

	// Release the tab contents controller so those views get destroyed. This
	// will remove all the tab content Cocoa views from the hierarchy. A
	// subsequent "select tab" notification will follow from the model. To
	// tell us what to swap in in its absence.
	[tabContentsArray_ removeObjectAtIndex:index];
	
	// Remove the view from the tab strip.
	NSView* tab = [controller view];
	[tab removeFromSuperview];
	
	// Remove ourself as an observer.
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:NSViewDidUpdateTrackingAreasNotification
	 object:tab];
	
	// Clear the tab controller's target.
	// TODO(viettrungluu): [crbug.com/23829] Find a better way to handle the tab
	// controller's target.
	[controller setTarget:nil];
	
	if ([hoveredTab_ isEqual:tab])
		hoveredTab_ = nil;
	
	NSValue* identifier = [NSValue valueWithPointer:tab];
	[targetFrames_ removeObjectForKey:identifier];
	
	// Once we're totally done with the tab, delete its controller
	[tabArray_ removeObjectAtIndex:index];
}


// Called by the CAAnimation delegate when the tab completes the closing
// animation.
- (void)animationDidStopForController:(TabController *)controller
                             finished:(BOOL)finished 
{
	[closingControllers_ removeObject:controller];
	[self removeTab:controller];
	[self layoutTabs];
}

// Save off which TabController is closing and tell its view's animator
// where to move the tab to. Registers a delegate to call back when the
// animation is complete in order to remove the tab from the model.
- (void)startClosingTabWithAnimation:(TabController *)closingTab 
{
	// Save off the controller into the set of animating tabs. This alerts
	// the layout method to not do anything with it and allows us to correctly
	// calculate offsets when working with indices into the model.
	[closingControllers_ addObject:closingTab];
	
	// Mark the tab as closing. This prevents it from generating any drags or
	// selections while it's animating closed.
	[(TabView *)[closingTab view] setClosing:YES];
	
	// Register delegate (owned by the animation system).
	NSView *tabView = [closingTab view];
	CAAnimation *animation = [[tabView animationForKey:@"frameOrigin"] copy];
	[animation autorelease];
	TabCloseAnimationDelegate *delegate = [[TabCloseAnimationDelegate alloc] 
										   initWithTabStrip:self
										   tabController:closingTab];
	[animation setDelegate:delegate];  // Retains delegate.
	NSMutableDictionary *animationDictionary =
	[NSMutableDictionary dictionaryWithDictionary:[tabView animations]];
	[animationDictionary setObject:animation forKey:@"frameOrigin"];
	[tabView setAnimations:animationDictionary];
	
	// Periscope down! Animate the tab.
	NSRect newFrame = [tabView frame];
	newFrame = NSOffsetRect(newFrame, 0, -newFrame.size.height);
	ScopedNSAnimationContextGroup *animationGroup = 
	[[ScopedNSAnimationContextGroup alloc] initWithAnimate:TRUE];
	[animationGroup setCurrentContextDuration:kAnimationDuration];
	[[tabView animator] setFrame:newFrame];
	[animationGroup end];
}


// Called when a tab is moved (usually by drag&drop). Keep our parallel arrays
// in sync with the tab strip model. It can also be pinned/unpinned
// simultaneously, so we need to take care of that.
- (void)tabMovedWithContents:(FRWatcherTabContentsController *)contents
                   fromIndex:(NSInteger)modelFrom
                     toIndex:(NSInteger)modelTo
{
	// Take closing tabs into account.
	NSInteger from = [self indexFromModelIndex:modelFrom];
	NSInteger to = [self indexFromModelIndex:modelTo];
	
	FRWatcherTabContentsController *movedTabContentsController = [tabContentsArray_ objectAtIndex:from];
	[tabContentsArray_ removeObjectAtIndex:from];
	[tabContentsArray_ insertObject:movedTabContentsController
							atIndex:to];
	TabController *movedTabController = [tabArray_ objectAtIndex:from];

	[tabArray_ removeObjectAtIndex:from];
	[tabArray_ insertObject:movedTabController atIndex:to];
	
	// TODO(viettrungluu): I don't think this is needed. Investigate. See also
	// |-tabPinnedStateChangedWithContents:...|.
	[self layoutTabs];
}
										 
- (void)setFrameOfSelectedTab:(NSRect)frame 
{
	NSView* view = [self selectedTabView];
	NSValue* identifier = [NSValue valueWithPointer:view];
	[targetFrames_ setObject:[NSValue valueWithRect:frame]
					  forKey:identifier];
	[view setFrame:frame];
}

- (NSView*)selectedTabView 
{
	int selectedIndex = [tabStripModel_ selectedIndex];
	// Take closing tabs into account. They can't ever be selected.
	selectedIndex = [self indexFromModelIndex:selectedIndex];
	return [self viewAtIndex:selectedIndex];
}

// Find the model index based on the x coordinate of the placeholder. If there
// is no placeholder, this returns the end of the tab strip. Closing tabs are
// not considered in computing the index.
- (int)indexOfPlaceholder
{
	double placeholderX = placeholderFrame_.origin.x;
	int index = 0;
	int location = 0;
	// Use |tabArray_| here instead of the tab strip count in order to get the
	// correct index when there are closing tabs to the left of the placeholder.
	const int count = [tabArray_ count];
	while (index < count) 
	{
		// Ignore closing tabs for simplicity. The only drawback of this is that
		// if the placeholder is placed right before one or several contiguous
		// currently closing tabs, the associated TabController will start at the
		// end of the closing tabs.
		if ([closingControllers_ containsObject:[tabArray_ objectAtIndex:index]]) 
		{
			index++;
			continue;
		}
		NSView* curr = [self viewAtIndex:index];
		// The placeholder tab works by changing the frame of the tab being dragged
		// to be the bounds of the placeholder, so we need to skip it while we're
		// iterating, otherwise we'll end up off by one.  Note This only effects
		// dragging to the right, not to the left.
		if (curr == placeholderTab_) {
			index++;
			continue;
		}
		if (placeholderX <= NSMinX([curr frame]))
			break;
		index++;
		location++;
	}
	return location;
}

// Move the given tab at index |from| in this window to the location of the
// current placeholder.
- (void)moveTabFromIndex:(NSInteger)from 
{
	int toIndex = [self indexOfPlaceholder];
	[tabStripModel_ moveTabContentsAtIndex:from to:toIndex select:TRUE];
}

// Drop a given TabContents at the location of the current placeholder. If there
// is no placeholder, it will go at the end. Used when dragging from another
// window when we don't have access to the TabContents as part of our strip.
// |frame| is in the coordinate system of the tab strip view and represents
// where the user dropped the new tab so it can be animated into its correct
// location when the tab is added to the model.
- (void)dropTabContents:(FRWatcherTabContentsController *)contents withFrame:(NSRect)frame 
{
	int modelIndex = [self indexOfPlaceholder];
	
	// Mark that the new tab being created should start at |frame|. It will be
	// reset as soon as the tab has been positioned.
	droppedTabFrame_ = frame;
	
	[contents setMyDocument:document_];
	
	// Insert it into this tab strip. We want it in the foreground and to not
	// inherit the current tab's group.
	[tabStripModel_ insertTabContents:contents atIndex:modelIndex bringToFront:TRUE];
	
	[self updateThrobberForTabContents:contents atIndex:modelIndex];
}								 
										 
// Called when the tab strip view changes size. As we only registered for
// changes on our view, we know it's only for our view. Layout w/out
// animations since they are blocked by the resize nested runloop. We need
// the views to adjust immediately. Neither the tabs nor their z-order are
// changed, so we don't need to update the subviews.
- (void)tabViewFrameChanged:(NSNotification*)info 
{
	[self layoutTabsWithAnimation:NO regenerateSubviews:NO];
}

// Called when the tracking areas for any given tab are updated. This allows
// the individual tabs to update their hover states correctly.
// Only generates the event if the cursor is in the tab strip.
- (void)tabUpdateTracking:(NSNotification*)notification 
{
	NSWindow* window = [tabStripView_ window];
	NSPoint location = [window mouseLocationOutsideOfEventStream];
	if (NSPointInRect(location, [tabStripView_ frame])) 
	{
		NSEvent* mouseEvent = [NSEvent mouseEventWithType:NSMouseMoved
												 location:location
											modifierFlags:0
												timestamp:0
											 windowNumber:[window windowNumber]
												  context:nil
											  eventNumber:0
											   clickCount:0
												 pressure:0];
		[self mouseMoved:mouseEvent];
	}
}

- (BOOL)inRapidClosureMode 
{
	return (availableResizeWidth_ != kUseFullAvailableWidth);
}

- (void)mouseMoved:(NSEvent *)event 
{
	// Use hit test to figure out what view we are hovering over.
	TabView *targetView =
	(TabView *)[tabStripView_ hitTest:[event locationInWindow]];
	if (![targetView isKindOfClass:[TabView class]]) 
	{
		if ([[targetView superview] isKindOfClass:[TabView class]]) 
			targetView = (TabView *)[targetView superview];
		else 
			targetView = nil;
	}
	
	if (hoveredTab_ != targetView) 
	{
		[hoveredTab_ mouseExited:nil];  // We don't pass event because moved events
		[targetView mouseEntered:nil];  // don't have valid tracking areas
		hoveredTab_ = targetView;
	} 
	else
		[hoveredTab_ mouseMoved:event];
}

- (void)mouseEntered:(NSEvent *)event 
{
	NSTrackingArea* area = [event trackingArea];
	if ([area isEqual:trackingArea_]) 
	{
		mouseInside_ = YES;
		[self setTabTrackingAreasEnabled:YES];
		[self mouseMoved:event];
	}
	else if ([area isEqual:newTabTrackingArea_]) 
	{
		[newTabButton_ setImage:[NSImage imageNamed:kNewTabHoverImage]];
	}
}

// Called when the tracking area is in effect which means we're tracking to
// see if the user leaves the tab strip with their mouse. When they do,
// reset layout to use all available width.
- (void)mouseExited:(NSEvent *)event 
{
	NSTrackingArea* area = [event trackingArea];
	if ([area isEqual:trackingArea_]) 
	{
		mouseInside_ = NO;
		[self setTabTrackingAreasEnabled:NO];
		availableResizeWidth_ = kUseFullAvailableWidth;
		[hoveredTab_ mouseExited:event];
		hoveredTab_ = nil;
		[self layoutTabs];
	} 
	else if ([area isEqual:newTabTrackingArea_]) 
	{
		[newTabButton_ setImage:[NSImage imageNamed:kNewTabImage]];
	}
}

// Enable/Disable the tracking areas for the tabs. They are only enabled
// when the mouse is in the tabstrip.
- (void)setTabTrackingAreasEnabled:(BOOL)enabled 
{
	NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
	for (TabController *controller in tabArray_) 
	{
		TabView *tabView = [controller tabView];
		if (enabled) 
		{
			// Set self up to observe tabs so hover states will be correct.
			[defaultCenter addObserver:self
							  selector:@selector(tabUpdateTracking:)
								  name:NSViewDidUpdateTrackingAreasNotification
								object:tabView];
		} 
		else 
		{
			[defaultCenter removeObserver:self
									 name:NSViewDidUpdateTrackingAreasNotification
								   object:tabView];
		}
		[tabView setTrackingEnabled:enabled];
	}
}

// Adds the given subview to (the end of) the list of permanent subviews
// (specified from bottom up). These subviews will always be below the
// transitory subviews (tabs). |-regenerateSubviewList| must be called to
// effectuate the addition.
- (void)addSubviewToPermanentList:(NSView*)aView 
{
	[permanentSubviews_ addObject:aView];
}

// Update the subviews, keeping the permanent ones (or, more correctly, putting
// in the ones listed in permanentSubviews_), and putting in the current tabs in
// the correct z-order. Any current subviews which is neither in the permanent
// list nor a (current) tab will be removed. So if you add such a subview, you
// should call |-addSubviewToPermanentList:| (or better yet, call that and then
// |-regenerateSubviewList| to actually add it).
- (void)regenerateSubviewList 
{
	// Remove self as an observer from all the old tabs before a new set of
	// potentially different tabs is put in place.
	[self setTabTrackingAreasEnabled:NO];
	
	// Subviews to put in (in bottom-to-top order), beginning with the permanent
	// ones.
	NSMutableArray* subviews = [NSMutableArray arrayWithArray:permanentSubviews_];
	
	NSView* selectedTabView = nil;
	// Go through tabs in reverse order, since |subviews| is bottom-to-top.
	for (TabController *tab in [tabArray_ reverseObjectEnumerator]) 
	{
		NSView* tabView = [tab view];
		if ([tab selected]) 
			selectedTabView = tabView;
		else 
			[subviews addObject:tabView];
	}
	
	if (selectedTabView) 
		[subviews addObject:selectedTabView];
	
	[tabStripView_ setSubviews:subviews];
	[self setTabTrackingAreasEnabled:mouseInside_];
}

- (FRWatcherTabContentsController *)activeTabContentsController 
{
	int modelIndex = [tabStripModel_ selectedIndex];
	if (modelIndex < 0)
		return nil;
	NSInteger index = [self indexFromModelIndex:modelIndex];
	if (index < 0 ||
		index >= (NSInteger)[tabContentsArray_ count])
		return nil;
	
	return [tabContentsArray_ objectAtIndex:index];
}

// Disable tab dragging when there are any pending animations.
- (BOOL)tabDraggingAllowed 
{
	return [closingControllers_ count] == 0;
}

- (void)attachConstrainedWindow:(NSWindow *)window 
						  toTab:(FRWatcherTabContentsController *)tabController
{
	NSView* tabContentsView = [tabController ourView];
	
	TabbedWindowController *controller =
		(TabbedWindowController *)[[switchView_ window] windowController];
	
	[[controller sheetController] beginSheet:window
								modalForView:tabContentsView 
							   modalDelegate:self 
							  didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
								 contextInfo:tabController];

	NSInteger modelIndex = [self modelIndexForContentsView:tabContentsView];
	NSInteger index = [self indexFromModelIndex:modelIndex];

	// Prevent tab from beign dragged while a sheet is open, 
	// since GTMWindowSheetController can't currently move sheets between windows
	if (index >= 0)
		[controller setTab:[self viewAtIndex:index] isDraggable:NO];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	NSView *tabContentsView = [(FRWatcherTabContentsController *)contextInfo ourView];

	NSInteger modelIndex = [self modelIndexForContentsView:tabContentsView];
	NSInteger index = [self indexFromModelIndex:modelIndex];
	
	TabbedWindowController *controller =
		(TabbedWindowController *)[[switchView_ window] windowController];
	
	if (index >= 0)
		[controller setTab:[self viewAtIndex:index] isDraggable:YES];
}

- (void)updateThrobberForTabContents:(FRWatcherTabContentsController *)tabContentsController
							 atIndex:(NSInteger)modelIndex
{
	if (!tabContentsController)
		return;

	static id throbberWaitingImage = nil;
	if (throbberWaitingImage == nil) 
		throbberWaitingImage = [NSImage imageNamed:@"throbber_waiting.png"];

	static id throbberLoadingImage = nil;
	if (throbberLoadingImage == nil) 
		throbberLoadingImage = [NSImage imageNamed:@"throbber.png"];

	// Take closing tabs into account.
	NSInteger index = [self indexFromModelIndex:modelIndex];
	
	TabController *tabController = [tabArray_ objectAtIndex:index];
	
	enum TabLoadingState oldState = [tabController loadingState];
	enum TabLoadingState newState = kTabDone;
	
	NSImage* throbberImage = nil;
	if ([tabContentsController isLoading]) 
	{
		newState = kTabLoading;
		throbberImage = throbberLoadingImage;
	}
	
	if (oldState != newState)
		[tabController setLoadingState:newState];
	
	// While loading, this function is called repeatedly with the same state.
	// To avoid expensive unnecessary view manipulation, only make changes when
	// the state is actually changing.  When loading is complete (kTabDone),
	// every call to this function is significant.
	if (newState == kTabDone || oldState != newState) 
	{
		NSView* iconView = nil;
		
		if (newState == kTabDone) 
			iconView = nil;
		else 
		{
			NSRect frame = NSMakeRect(0, 0, 16, 16);
			iconView = [ThrobberView filmstripThrobberViewWithFrame:frame
															  image:throbberImage];
		}
		
		[tabController setIconView:iconView];
	}
}


@end
