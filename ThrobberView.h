//
//  ThrobberView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 04/02/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
//  Based on "throbber_view.h" from the Chromium project
//  Copyright (c) 2009 The Chromium Authors. All rights reserved.
//  Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>

// A class that knows how to draw an animated state to indicate progress.
// Creating the class starts the animation, destroying it stops it. There are
// two types:
//
// - Filmstrip: Draws via a sequence of frames in an image. There is no state
//   where the class is frozen on an image and not animating. The image needs to
//   be made of squares such that the height divides evently into the width.
//
// - Toast: Draws an image animating down to the bottom and then another image
//   animating up from the bottom. Stops once the animation is complete.

@class ThrobberTimerTarget;
@protocol ThrobberDataDelegate;

@interface ThrobberView : NSView 
{
	ThrobberTimerTarget *target_;
	NSTimer *timer_;
	id<ThrobberDataDelegate> dataDelegate_;
}

// Creates a filmstrip view with |frame| and image |image|.
+ (id)filmstripThrobberViewWithFrame:(NSRect)frame
                               image:(NSImage*)image;

// Creates a toast view with |frame| and specified images.
+ (id)toastThrobberViewWithFrame:(NSRect)frame
                     beforeImage:(NSImage*)beforeImage
                      afterImage:(NSImage*)afterImage;

@end
