//
//  ToolbarView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 30/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "toolbar_view.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "BackgroundGradientView.h"


@interface ToolbarView : BackgroundGradientView 
{
	// The opacity of the divider line (at the bottom of the toolbar); used when
	// the detached bookmark bar is morphing to the normal bar and vice versa.
	CGFloat dividerOpacity_;
}

@property(assign, nonatomic) CGFloat dividerOpacity;
@end
