//
//  HoverCloseButton.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "hover_close_button.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "HoverCloseButton.h"

const NSString *kNormalImageString = @"close_bar.pdf";
const NSString *kHoverImageString = @"close_bar_h.pdf";
const NSString *kPressedImageString = @"close_bar_p.pdf";

@implementation HoverCloseButton
- (id)initWithFrame:(NSRect)frameRect 
{
	self = [super initWithFrame:frameRect];
	if (self) 
	{
		[self commonInit];
	}
	return self;
}

- (void)awakeFromNib 
{
	[self commonInit];
}

- (void)commonInit 
{
	[self setTrackingEnabled:YES];
	NSImage* alternateImage = [NSImage imageNamed:(NSString *)kPressedImageString];
	[self setAlternateImage:alternateImage];
	[self updateTrackingAreas];
}

- (void)dealloc 
{
	[self setTrackingEnabled:NO];
	[super dealloc];
}

- (void)mouseEntered:(NSEvent*)theEvent 
{
	[self setImage:[NSImage imageNamed:(NSString *)kHoverImageString]];
}

- (void)mouseExited:(NSEvent*)theEvent 
{
	[self setImage:[NSImage imageNamed:(NSString *)kNormalImageString]];
}

- (void)mouseDown:(NSEvent*)theEvent 
{
	// The hover button needs to hold onto itself here for a bit.  Otherwise,
	// it can be freed while |super mouseDown:| is in it's loop, and the
	// |checkImageState| call will crash.
	// http://crbug.com/28220
	HoverCloseButton *myself = [self retain];
	
	[super mouseDown:theEvent];
	// We need to check the image state after the mouseDown event loop finishes.
	// It's possible that we won't get a mouseExited event if the button was
	// moved under the mouse during tab resize, instead of the mouse moving over
	// the button.
	// http://crbug.com/31279
	[self checkImageState];
}

- (void)setTrackingEnabled:(BOOL)enabled 
{
	if (enabled) 
	{
		closeTrackingArea_ = 
		[[NSTrackingArea alloc] initWithRect:[self bounds]
									 options:(NSTrackingMouseEnteredAndExited |
											  NSTrackingActiveAlways)
									   owner:self
									userInfo:nil];
		[self addTrackingArea:closeTrackingArea_];
		
		// If you have a separate window that overlaps the close button, and you
		// move the mouse directly over the close button without entering another
		// part of the tab strip, we don't get any mouseEntered event since the
		// tracking area was disabled when we entered.
		[self checkImageState];
	} 
	else 
	{
		if (closeTrackingArea_) 
		{
			[self removeTrackingArea:closeTrackingArea_];
			closeTrackingArea_ = nil;
		}
	}
}

- (void)updateTrackingAreas 
{
	[super updateTrackingAreas];
	[self checkImageState];
}

- (void)checkImageState 
{
	if (closeTrackingArea_) 
	{
		// Update the close buttons if the tab has moved.
		NSPoint mouseLoc = [[self window] mouseLocationOutsideOfEventStream];
		mouseLoc = [self convertPointFromBase:mouseLoc];
		NSString* name = (NSString *)(NSPointInRect(mouseLoc, [self bounds]) ?
									  kHoverImageString : kNormalImageString);
		NSImage* newImage = [NSImage imageNamed:name];
		NSImage* buttonImage = [self image];
		if (![buttonImage isEqual:newImage])
			[self setImage:newImage];
	}
}
@end
