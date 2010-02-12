//
//  WindowFrameView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "browser_frame_view.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "WindowFrameView.h"
#import <objc/runtime.h>
#import <Carbon/Carbon.h>
#import "TabbedWindow.h"
#import "GTMTheme.h"
#import "TabbedWindowController.h"

@interface NSView (Swizzles)

- (void)drawRectOriginal:(NSRect)rect;
- (BOOL)_mouseInGroup:(NSButton*)widget;
- (void)updateTrackingAreas;

@end


@implementation WindowFrameView

+ (void)load 
{
	// This is where we swizzle drawRect, and add in two methods that we
	// need. If any of these fail it shouldn't affect the functionality of the
	// others. If they all fail, we will lose window frame theming and
	// roll overs for our close widgets, but things should still function
	// correctly.

	Class grayFrameClass = NSClassFromString(@"NSGrayFrame");
	if (!grayFrameClass) return;
	
	// Exchange draw rect
	Method m0 = class_getInstanceMethod([self class], @selector(drawRect:));
	if (m0) {
		BOOL didAdd = class_addMethod(grayFrameClass,
									  @selector(drawRectOriginal:),
									  method_getImplementation(m0),
									  method_getTypeEncoding(m0));

		if (didAdd) {
			Method m1 = class_getInstanceMethod(grayFrameClass, @selector(drawRect:));
			Method m2 = class_getInstanceMethod(grayFrameClass,
												@selector(drawRectOriginal:));

			if (m1 && m2) {
				method_exchangeImplementations(m1, m2);
			}
		}
	}
	
	// Add _mouseInGroup
	m0 = class_getInstanceMethod([self class], @selector(_mouseInGroup:));

	if (m0) {
		BOOL didAdd = class_addMethod(grayFrameClass,
									  @selector(_mouseInGroup:),
									  method_getImplementation(m0),
									  method_getTypeEncoding(m0));

	}
	// Add updateTrackingArea
	m0 = class_getInstanceMethod([self class], @selector(updateTrackingAreas));

	if (m0) {
		BOOL didAdd = class_addMethod(grayFrameClass,
									  @selector(updateTrackingAreas),
									  method_getImplementation(m0),
									  method_getTypeEncoding(m0));

	}
}

- (id)initWithFrame:(NSRect)frame {
	// This class is not for instantiating.
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithCoder:(NSCoder*)coder {
	// This class is not for instantiating.
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

// Here is our custom drawing for our frame.
- (void)drawRect:(NSRect)rect 
{
	// If this isn't the window class we expect, then pass it on to the
	// original implementation.
	[self drawRectOriginal:rect];
	if (![[self window] isKindOfClass:[TabbedWindow class]])
		return;
	
	// Set up our clip
	NSWindow* window = [self window];
	NSRect windowRect = [window frame];
	windowRect.origin = NSMakePoint(0, 0);
	[[NSBezierPath bezierPathWithRoundedRect:windowRect
									 xRadius:4
									 yRadius:4] addClip];
	[[NSBezierPath bezierPathWithRect:rect] addClip];
	
	// Draw our background color if we have one, otherwise fall back on
	// system drawing.
	GTMTheme *theme = [(TabbedWindowController *)[[self window] windowController] theme];
	GTMThemeState state = [window isMainWindow] ? GTMThemeStateActiveWindow
	: GTMThemeStateInactiveWindow;
	NSColor *color = [theme backgroundPatternColorForStyle:GTMThemeStyleWindow
													 state:state];
	if (color) 
	{
		// If there is a theme pattern, draw it here.
		
		// To line up the background pattern with the patterns in the tabs the
		// background pattern in the window frame need to be moved up by two
		// pixels and left by 5.
		// This will make the themes look slightly different than in Windows/Linux
		// because of the differing heights between window top and tab top, but this
		// has been approved by UI.
		static const NSPoint kBrowserFrameViewPatternPhaseOffset = { -5, 2 };
		NSPoint phase = kBrowserFrameViewPatternPhaseOffset;
		phase.y += NSHeight(windowRect);
		[[NSGraphicsContext currentContext] setPatternPhase:phase];
		[color set];
		NSRectFill(rect);
	}
	
	// Check to see if we have an overlay image.
	NSImage* overlayImage = [theme valueForAttribute:@"overlay"
											   style:GTMThemeStyleWindow
											   state:state];
	if (overlayImage) 
	{
		// Anchor to top-left and don't scale.
		NSSize overlaySize = [overlayImage size];
		NSRect imageFrame = NSMakeRect(0, 0, overlaySize.width, overlaySize.height);
		[overlayImage drawAtPoint:NSMakePoint(0, NSHeight(windowRect) -
											  overlaySize.height)
						 fromRect:imageFrame
						operation:NSCompositeSourceOver
						 fraction:1.0];
	}
}

// Check to see if the mouse is currently in one of our window widgets.
- (BOOL)_mouseInGroup:(NSButton*)widget 
{
	BOOL mouseInGroup = NO;
	if ([[self window] isKindOfClass:[TabbedWindow class]]) 
	{
		TabbedWindow *window = (TabbedWindow *)[self window];
		mouseInGroup = [window mouseInGroup:widget];
	}
	else if ([super respondsToSelector:@selector(_mouseInGroup:)]) 
		mouseInGroup = [super _mouseInGroup:widget];

	return mouseInGroup;
}

// Let our window handle updating the window widget tracking area.
- (void)updateTrackingAreas 
{
	[super updateTrackingAreas];
	if ([[self window] isKindOfClass:[TabbedWindow class]]) 
	{
		TabbedWindow *window = (TabbedWindow *)[self window];
		[window updateTrackingAreas];
	}
}

@end
