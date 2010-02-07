//
//  GTMNSAnimation+Duration.h
//
//  Copyright 2009 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//


#import <AppKit/AppKit.h>
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>
#import "GTMDefines.h"

// Given a "normal" duration for an animation, return what it should be based
// on the current system state. For example, holding down the shift and/or
// control keys modifies the normal duration for an animation making it slower.
// Currently only modifies the duration if the current event is of type 
// NSLeftMouseUp and only the control and/or shift modifiers are down.
NSTimeInterval GTMModifyDurationBasedOnCurrentState(NSTimeInterval duration);

// Categories for changing the duration of an animation based on the current
// event. Right now they track the state of the shift and control keys to slow
// down animations similar to how minimize window animations occur.
@interface NSAnimation (GTMNSAnimationDurationAdditions)

// Note that using this initializer will set the duration of the animation 
// based on the current event when the animation is created. If the animation
// is to be reused, the duration for the event should be reset with
// gtm_setDuration each time the animation is started.
- (id)gtm_initWithDuration:(NSTimeInterval)duration 
            animationCurve:(NSAnimationCurve)animationCurve;

// Sets the duration by taking the duration passed in and calling
// GTMModifyDurationBasedOnCurrentState to calculate the real duration.
- (void)gtm_setDuration:(NSTimeInterval)duration;
@end

#if MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5

#import <QuartzCore/QuartzCore.h>

@interface NSAnimationContext (GTMNSAnimationDurationAdditions)

// Sets the duration by taking the duration passed in and calling
// GTMModifyDurationBasedOnCurrentState to calculate the real duration.
- (void)gtm_setDuration:(NSTimeInterval)duration;
@end

@interface CAAnimation (GTMCAAnimationDurationAdditions)

// Sets the duration by taking the duration passed in and calling
// GTMModifyDurationBasedOnCurrentState to calculate the real duration.
- (void)gtm_setDuration:(CFTimeInterval)duration;
@end

#endif  // MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5
