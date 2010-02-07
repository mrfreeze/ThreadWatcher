//
//  TabbedWindow.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "chrome_browser_window.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "TabbedWindow.h"
#import "TabbedWindowController.h"
#import "TabStripController.h"
#import "WindowFrameView.h"

const NSInteger kTabbedWindowButtonsWithTabStripOffsetFromTop = 6;
const NSInteger kTabbedWindowButtonsWithoutTabStripOffsetFromTop = 4;
const NSInteger kTabbedWindowButtonsOffsetFromLeft = 8;
const NSInteger kFRTabbedWindowButtonsInterButtonSpacing = 7;

// Size of the gradient. Empirically determined so that the gradient looks
// like what the heuristic does when there are just a few tabs.
const CGFloat kWindowGradientHeight = 24.0;

@interface TabbedWindow ()

- (NSView*)frameView;

@end


@implementation TabbedWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag 
{
	if ((self = [super initWithContentRect:contentRect
								 styleMask:aStyle
								   backing:bufferingType
									 defer:flag])) 
	{
		if (aStyle & NSTexturedBackgroundWindowMask) 
		{
			// The following two calls fix http://www.crbug.com/25684 by preventing
			// the window from recalculating the border thickness as the window is
			// resized.
			// This was causing the window tint to change for the default system theme
			// when the window was being resized.
			[self setAutorecalculatesContentBorderThickness:NO forEdge:NSMaxYEdge];
			[self setAutorecalculatesContentBorderThickness:NO forEdge:NSMinYEdge];
			[self setContentBorderThickness:kWindowGradientHeight forEdge:NSMaxYEdge];
			[self setContentBorderThickness:24.0 forEdge:NSMinYEdge];
			shouldHideTitle = TRUE;
		}
	}
	return self;
}

- (void)setWindowController:(NSWindowController *)controller 
{
	if (controller == [self windowController]) 
		return;
	
	// Clean up our old stuff.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
	[closeButton removeFromSuperview];
	closeButton = nil;
	[minimiseButton removeFromSuperview];
	minimiseButton = nil;
	[zoomButton removeFromSuperview];
	zoomButton = nil;
	
	[super setWindowController:controller];
	
	TabbedWindowController *windowController = (TabbedWindowController *)controller;
	
	if ([windowController isKindOfClass:[TabbedWindowController class]]) 
	{		
		// Hook ourselves up to get notified if the user changes the system
		// theme on us.
		NSDistributedNotificationCenter* distCenter =
        [NSDistributedNotificationCenter defaultCenter];
		[distCenter addObserver:self
					   selector:@selector(systemThemeDidChangeNotification:)
						   name:@"AppleAquaColorVariantChanged"
						 object:nil];
		
		// Set up our buttons how we like them.
		NSView *frameView = [self frameView];
		NSRect frameViewBounds = [frameView bounds];
		
		// Find all the "original" buttons, and hide them. We can't use the original
		// buttons because the OS likes to move them around when we resize windows
		// and will put them back in what it considers to be their "preferred"
		// locations.
		NSButton* oldButton = [self standardWindowButton:NSWindowCloseButton];
		[oldButton setHidden:YES];
		oldButton = [self standardWindowButton:NSWindowMiniaturizeButton];
		[oldButton setHidden:YES];
		oldButton = [self standardWindowButton:NSWindowZoomButton];
		[oldButton setHidden:YES];
		
		// Create and position our new buttons.
		NSUInteger aStyle = [self styleMask];
		
		// close button
		closeButton = [NSWindow standardWindowButton:NSWindowCloseButton
										forStyleMask:aStyle];
		NSRect closeButtonFrame = [closeButton frame];
		CGFloat yOffset =  kTabbedWindowButtonsWithTabStripOffsetFromTop;
		
		closeButtonFrame.origin =
        NSMakePoint(kTabbedWindowButtonsOffsetFromLeft,
                    (NSHeight(frameViewBounds) -
                     NSHeight(closeButtonFrame) - yOffset));
		
		[closeButton setFrame:closeButtonFrame];
		[closeButton setTarget:self];
		[closeButton setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
		[frameView addSubview:closeButton];
		
		// minimise button
		minimiseButton =
        [NSWindow standardWindowButton:NSWindowMiniaturizeButton
                          forStyleMask:aStyle];
		NSRect minimiseButtonFrame = [minimiseButton frame];
		minimiseButtonFrame.origin =
        NSMakePoint((NSMaxX(closeButtonFrame) +
                     kFRTabbedWindowButtonsInterButtonSpacing),
                    NSMinY(closeButtonFrame));
		[minimiseButton setFrame:minimiseButtonFrame];
		[minimiseButton setTarget:self];
		[minimiseButton setAutoresizingMask:(NSViewMaxXMargin |
											 NSViewMinYMargin)];
		[frameView addSubview:minimiseButton];
		
		// zoom button
		zoomButton = [NSWindow standardWindowButton:NSWindowZoomButton
									   forStyleMask:aStyle];
		NSRect zoomButtonFrame = [zoomButton frame];
		zoomButtonFrame.origin =
        NSMakePoint((NSMaxX(minimiseButtonFrame) +
                     kFRTabbedWindowButtonsInterButtonSpacing),
                    NSMinY(minimiseButtonFrame));
		[zoomButton setFrame:zoomButtonFrame];
		[zoomButton setTarget:self];
		[zoomButton setAutoresizingMask:(NSViewMaxXMargin |
										 NSViewMinYMargin)];
		[frameView addSubview:zoomButton];
	}
	
	// Update our tracking areas. We want to update them even if we haven't
	// added buttons above as we need to remove the old tracking area. If the
	// buttons aren't to be shown, updateTrackingAreas won't add new ones.
	[self updateTrackingAreas];
}


- (NSView*)frameView 
{
	return [[self contentView] superview];
}

// The tab strip view covers our window buttons. So we add hit testing here
// to find them properly and return them to the accessibility system.
- (id)accessibilityHitTest:(NSPoint)point 
{
	NSPoint windowPoint = [self convertScreenToBase:point];
	NSControl *controls[] = { closeButton, zoomButton, minimiseButton};
	id value = nil;
	for (size_t i = 0; i < sizeof(controls) / sizeof(controls[0]); ++i) 
	{
		if (NSPointInRect(windowPoint, [controls[i] frame])) 
		{
			value = [controls[i] accessibilityHitTest:point];
			break;
		}
	}
	if (!value)
		value = [super accessibilityHitTest:point];
	
	return value;
}

// Map our custom buttons into the accessibility hierarchy correctly.
- (id)accessibilityAttributeValue:(NSString*)attribute
{
	id value = nil;
	struct {
		NSString* attribute_;
		id value_;
	} attributeMap[] = {
		{ NSAccessibilityCloseButtonAttribute, [closeButton cell]},
		{ NSAccessibilityZoomButtonAttribute, [zoomButton cell]},
		{ NSAccessibilityMinimizeButtonAttribute, [minimiseButton cell]},
	};
	
	for (size_t i = 0; i < sizeof(attributeMap) / sizeof(attributeMap[0]); ++i) 
	{
		if ([attributeMap[i].attribute_ isEqualToString:attribute]) 
		{
			value = attributeMap[i].value_;
			break;
		}
	}
	if (!value)
		value = [super accessibilityAttributeValue:attribute];
	
	return value;
}

- (void)updateTrackingAreas 
{
	NSView* frameView = [self frameView];
	if (widgetTrackingArea)
		[frameView removeTrackingArea:widgetTrackingArea];
	
	if (closeButton) 
	{
		NSRect trackingRect = [closeButton frame];
		trackingRect.size.width = NSMaxX([zoomButton frame]) -
        NSMinX(trackingRect);
		widgetTrackingArea = [[NSTrackingArea alloc] initWithRect:trackingRect
														  options:(NSTrackingMouseEnteredAndExited |
																   NSTrackingActiveAlways)
															owner:self
														 userInfo:nil];
		[frameView addTrackingArea:widgetTrackingArea];
		
		// Check to see if the cursor is still in trackingRect.
		NSPoint point = [self mouseLocationOutsideOfEventStream];
		point = [[self contentView] convertPoint:point fromView:nil];
		BOOL newEntered = NSPointInRect (point, trackingRect);
		if (newEntered != entered) 
		{
			// Buttons have moved, so update button state.
			entered = newEntered;
			[closeButton setNeedsDisplay];
			[zoomButton setNeedsDisplay];
			[minimiseButton setNeedsDisplay];
		}
	}
}


- (void)windowMainStatusChanged 
{
	[closeButton setNeedsDisplay];
	[zoomButton setNeedsDisplay];
	[minimiseButton setNeedsDisplay];
	NSView* frameView = [self frameView];
	NSView* contentView = [self contentView];
	NSRect updateRect = [frameView frame];
	NSRect contentRect = [contentView frame];
	CGFloat tabStripHeight = [TabStripController defaultTabHeight];
	updateRect.size.height -= NSHeight(contentRect) - tabStripHeight;
	updateRect.origin.y = NSMaxY(contentRect) - tabStripHeight;
	[[self frameView] setNeedsDisplayInRect:updateRect];
}

- (void)becomeMainWindow 
{
	[self windowMainStatusChanged];
	[super becomeMainWindow];
}

- (void)resignMainWindow 
{
	[self windowMainStatusChanged];
	[super resignMainWindow];
}

- (void)systemThemeDidChangeNotification:(NSNotification*)aNotification 
{
	[closeButton setNeedsDisplay];
	[zoomButton setNeedsDisplay];
	[minimiseButton setNeedsDisplay];
}

- (void)sendEvent:(NSEvent*)event 
{
	// For cocoa windows, clicking on the close and the miniaturize (but not the
	// zoom buttons) while a window is in the background does NOT bring that
	// window to the front. We don't get that behavior for free, so we handle
	// it here. Zoom buttons do bring the window to the front. Note that
	// Finder windows (in Leopard) behave differently in this regard in that
	// zoom buttons don't bring the window to the foreground.
	BOOL eventHandled = NO;
	if (![self isMainWindow]) 
	{
		if ([event type] == NSLeftMouseDown) 
		{
			NSView* frameView = [self frameView];
			NSPoint mouse = [frameView convertPointFromBase:[event locationInWindow]];
			if (NSPointInRect(mouse, [closeButton frame])) 
			{
				[closeButton mouseDown:event];
				eventHandled = YES;
			} 
			else if (NSPointInRect(mouse, [minimiseButton frame])) 
			{
				[minimiseButton mouseDown:event];
				eventHandled = YES;
			}
		}
	}
	if (!eventHandled)
		[super sendEvent:event];
}

// Update our buttons so that they highlight correctly.
- (void)mouseEntered:(NSEvent *)event 
{
	entered = YES;
	[closeButton setNeedsDisplay];
	[zoomButton setNeedsDisplay];
	[minimiseButton setNeedsDisplay];
}

// Update our buttons so that they highlight correctly.
- (void)mouseExited:(NSEvent*)event 
{
	entered = NO;
	[closeButton setNeedsDisplay];
	[zoomButton setNeedsDisplay];
	[minimiseButton setNeedsDisplay];
}

- (BOOL)mouseInGroup:(NSButton*)widget 
{
	return entered;
}

- (void)setShouldHideTitle:(BOOL)flag 
{
	shouldHideTitle = flag;
}

-(BOOL)_isTitleHidden 
{
	return shouldHideTitle;
}

// This method is called whenever a window is moved in order to ensure it fits
// on the screen.  We cannot always handle resizes without breaking, so we
// prevent frame constraining in those cases.
- (NSRect)constrainFrameRect:(NSRect)frame toScreen:(NSScreen*)screen 
{
	// Do not constrain the frame rect if our delegate says no.  In this case,
	// return the original (unconstrained) frame.
	id delegate = [self delegate];
	if ([delegate respondsToSelector:@selector(shouldConstrainFrameRect)] &&
		![delegate shouldConstrainFrameRect])
		return frame;
	
	return [super constrainFrameRect:frame toScreen:screen];
}


@end
