//
//  TabController.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "tab_controller.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "TabController.h"
#import "GTMTheme.h"
#import "TabView.h"

@interface TabController ()

- (void)viewResized:(NSNotification*)info;

@end


@implementation TabController

@synthesize target = target_;
@synthesize action = action_;
@synthesize title = title_;
@synthesize tabBadge = tabBadge_;
@synthesize loadingState = loadingState_;

// The min widths match the windows values and are sums of left + right
// padding, of which we have no comparable constants (we draw using paths, not
// images). The selected tab width includes the close button width.
+ (CGFloat)minTabWidth { return 31; }
+ (CGFloat)minSelectedTabWidth { return 47; }
+ (CGFloat)maxTabWidth { return 220; }
+ (CGFloat)pinnedTabWidth { return 53; }

- (TabView *)tabView 
{
	return (TabView *)[self view];
}

- (id)init 
{
	self = [super initWithNibName:@"TabView" bundle:[NSBundle mainBundle]];
	if (self) 
	{
		NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
		[defaultCenter addObserver:self
						  selector:@selector(viewResized:)
							  name:NSViewFrameDidChangeNotification
							object:[self view]];
		title_ = @"Untitled1";
	}
	return self;
}

// The internals of |-setSelected:| but doesn't check if we're already set
// to |selected|. Pass the selection change to the subviews that need it and
// mark ourselves as needing a redraw.
- (void)internalSetSelected:(BOOL)selected 
{
	selected_ = selected;
	TabView *tabView = (TabView *)[self view];
	[tabView setState:selected];
	[self updateVisibility];
	[self updateTitleColor];
}

// Called when the tab's nib is done loading and all outlets are hooked up.
- (void)awakeFromNib 
{
	// Remember the icon's frame, so that if the icon is ever removed, a new
	// one can later replace it in the proper location.
	originalIconFrame_ = [iconView_ frame];
	
	// When the icon is removed, the title expands to the left to fill the space
	// left by the icon.  When the close button is removed, the title expands to
	// the right to fill its space.  These are the amounts to expand and contract
	// titleView_ under those conditions.
	NSRect titleFrame = [titleView_ frame];
	iconTitleXOffset_ = 20;
	titleCloseWidthOffset_ = NSMaxX([closeButton_ frame]) - NSMaxX(titleFrame);
	
	[self internalSetSelected:selected_];
}

- (IBAction)closeTab:(id)sender
{
	if ([[self target] respondsToSelector:@selector(closeTab:)]) 
	{
		[[self target] performSelector:@selector(closeTab:)
							withObject:[self view]];
	}
}

- (void)setSelected:(BOOL)selected 
{
	if (selected_ != selected)
		[self internalSetSelected:selected];
}

- (BOOL)selected 
{
	return selected_;
}

- (NSString*)toolTip 
{
	return [[self view] toolTip];
}

// Return a rough approximation of the number of icons we could fit in the
// tab. We never actually do this, but it's a helpful guide for determining
// how much space we have available.
- (NSInteger)iconCapacity 
{
	CGFloat width = NSMaxX([closeButton_ frame]) - NSMinX(originalIconFrame_);
	CGFloat iconWidth = NSWidth(originalIconFrame_);
	
	return (width / iconWidth);
}

// Returns YES if we should be showing the close button. The selected tab
// always shows the close button.
- (BOOL)shouldShowCloseButton 
{
	return ([self selected] || [self iconCapacity] >= 3);
}

- (void)updateVisibility 
{
	// iconView_ may have been replaced or it may be nil, so [iconView_ isHidden]
	// won't work.  Instead, the state of the icon is tracked separately in
	// isIconShowing_.
	BOOL oldShowIcon = isIconShowing_ ? YES : NO;
	BOOL newShowIcon = [self shouldShowIcon] ? YES : NO;
	
	[iconView_ setHidden:newShowIcon ? NO : YES];
	isIconShowing_ = newShowIcon;
	
	BOOL oldShowCloseButton = [closeButton_ isHidden] ? NO : YES;
	BOOL newShowCloseButton = [self shouldShowCloseButton] ? YES : NO;
	
	[closeButton_ setHidden:newShowCloseButton ? NO : YES];
	
	// Adjust the title view based on changes to the icon's and close button's
	// visibility.
	NSRect titleFrame = [titleView_ frame];
	
	if (oldShowIcon != newShowIcon) 
	{
		// Adjust the left edge of the title view according to the presence or
		// absence of the icon view.
		
		if (newShowIcon) 
		{
			titleFrame.origin.x += iconTitleXOffset_;
			titleFrame.size.width -= iconTitleXOffset_;
		} 
		else 
		{
			titleFrame.origin.x -= iconTitleXOffset_;
			titleFrame.size.width += iconTitleXOffset_;
		}
	}
	
	if (oldShowCloseButton != newShowCloseButton) 
	{
		// Adjust the right edge of the title view according to the presence or
		// absence of the close button.
		if (newShowCloseButton)
			titleFrame.size.width -= titleCloseWidthOffset_;
		else
			titleFrame.size.width += titleCloseWidthOffset_;
	}
	
	[titleView_ setFrame:titleFrame];
	[tabBadge_ setNeedsDisplay:YES];
}

- (void)updateTitleColor 
{
	NSColor* titleColor = nil;
	GTMTheme* theme = [[self view] gtm_theme];
	if (![self selected]) 
		titleColor = [theme textColorForStyle:GTMThemeStyleTabBarDeselected
										state:GTMThemeStateActiveWindow];

	// Default to the selected text color unless told otherwise.
	if (!titleColor)
		titleColor = [theme textColorForStyle:GTMThemeStyleTabBarSelected
										state:GTMThemeStateActiveWindow];

	[titleView_ setTextColor:titleColor ? titleColor : [NSColor textColor]];
}

// Called when our view is resized. If it gets too small, start by hiding
// the close button and only show it if tab is selected. Eventually, hide the
// icon as well. We know that this is for our view because we only registered
// for notifications from our specific view.
- (void)viewResized:(NSNotification*)info 
{
	[self updateVisibility];
}

- (void)themeChangedNotification:(NSNotification*)notification 
{
	GTMTheme* theme = [notification object];
	NSView* view = [self view];
	if ([theme isEqual:[view gtm_theme]]) 
	{
		[self updateTitleColor];
	}
}

// Called by the tabs to determine whether we are in rapid (tab) closure mode.
- (BOOL)inRapidClosureMode 
{
	if ([[self target] respondsToSelector:@selector(inRapidClosureMode)]) 
	{
		return [[self target] performSelector:@selector(inRapidClosureMode)] ?
        YES : NO;
	}
	return NO;
}

- (void)setIconView:(NSView*)iconView 
{
	[iconView_ removeFromSuperview];
	iconView_ = iconView;
	[iconView_ setFrame:originalIconFrame_];
	
	// Ensure that the icon is suppressed if no icon is set or if the tab is too
	// narrow to display one.
	[self updateVisibility];
	
	if (iconView_)
		[[self view] addSubview:iconView_];
}

- (NSView*)iconView 
{
	return iconView_;
}

- (void)setCount:(NSInteger)newCount
{
	if (newCount == 0)
		[(TabView *)[self view] expandTitleFrame];
	else
		[(TabView *)[self view] reduceTitleFrame];

	[tabBadge_ setCount:newCount];
	[tabBadge_ setNeedsDisplay:YES];
}

// Returns YES if we should show the icon. When tabs get too small, we clip
// the icon before the close button for selected tabs, and prefer the
// favicon for unselected tabs.  The icon can also be suppressed more directly
// by clearing iconView_.
- (BOOL)shouldShowIcon 
{	
	if (!iconView_)
		return NO;
	
	NSInteger iconCapacity = [self iconCapacity];
	if ([self selected])
		return iconCapacity >= 2;
	return iconCapacity >= 1;
}


@end
