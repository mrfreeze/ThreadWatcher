//
//  ThrobberView.m
//  ThreadWatcher
//
//  Copyright (c) 2009 The Chromium Authors. All rights reserved.
//  Use of this source code is governed by a BSD-style license

#import "ThrobberView.h"

static const CGFloat kAnimationIntervalSeconds = 0.03;  // 30ms

@interface ThrobberView ()
- (id)initWithFrame:(NSRect)frame delegate:(id<ThrobberDataDelegate>)delegate;
- (void)maintainTimer;
- (void)animate;
@end

@protocol ThrobberDataDelegate <NSObject>
// Is the current frame the last frame of the animation?
- (BOOL)animationIsComplete;

// Draw the current frame into the current graphics context.
- (void)drawFrameInRect:(NSRect)rect;

// Update the frame counter.
- (void)advanceFrame;
@end

@interface ThrobberFilmstripDelegate : NSObject <ThrobberDataDelegate> 
{
	NSImage *image_;
	unsigned int numFrames_;  // Number of frames in this animation.
	unsigned int animationFrame_;  // Current frame of the animation,
								   // [0..numFrames_)
}

- (id)initWithImage:(NSImage*)image;
@end


@implementation ThrobberFilmstripDelegate

- (id)initWithImage:(NSImage*)image 
{
	self = [super init];
	if (self) 
	{
		// Reset the animation counter so there's no chance we are off the end.
		animationFrame_ = 0;
		
		// Ensure that the height divides evenly into the width. Cache the
		// number of frames in the animation for later.
		NSSize imageSize = [image size];
		if (!imageSize.height)
			return nil;
		numFrames_ = (int)imageSize.width / (int)imageSize.height;
		image_ = [image retain];
	}
	return self;
}

- (BOOL)animationIsComplete 
{
	return NO;
}

- (void)drawFrameInRect:(NSRect)rect 
{
	CGFloat imageDimension = [image_ size].height;
	CGFloat xOffset = animationFrame_ * imageDimension;
	NSRect sourceImageRect =
	NSMakeRect(xOffset, 0, imageDimension, imageDimension);
	[image_ drawInRect:rect
			  fromRect:sourceImageRect
			 operation:NSCompositeSourceOver
			  fraction:1.0];
}

- (void)advanceFrame 
{
	animationFrame_ = ++animationFrame_ % numFrames_;
}

@end


@interface ThrobberToastDelegate : NSObject <ThrobberDataDelegate> 
{
	NSImage *image1_;
	NSImage *image2_;
	NSSize image1Size_;
	NSSize image2Size_;
	int animationFrame_;  // Current frame of the animation,
}

- (id)initWithImage1:(NSImage*)image1 image2:(NSImage*)image2;

@end

@implementation ThrobberToastDelegate

- (id)initWithImage1:(NSImage*)image1 image2:(NSImage*)image2 
{
	if ((self = [super init])) 
	{
		image1_ = [image1 retain];
		image2_ = [image2 retain];
		image1Size_ = [image1 size];
		image2Size_ = [image2 size];
		animationFrame_ = 0;
	}
	return self;
}

- (BOOL)animationIsComplete 
{
	if (animationFrame_ >= image1Size_.height + image2Size_.height)
		return YES;
	
	return NO;
}

// From [0..image1Height) we draw image1, at image1Height we draw nothing, and
// from [image1Height+1..image1Hight+image2Height] we draw the second image.
- (void)drawFrameInRect:(NSRect)rect 
{
	NSImage* image = nil;
	NSSize srcSize;
	NSRect destRect;
	
	if (animationFrame_ < image1Size_.height) 
	{
		image = image1_;
		srcSize = image1Size_;
		destRect = NSMakeRect(0, -animationFrame_,
							  image1Size_.width, image1Size_.height);
	} 
	else if (animationFrame_ == image1Size_.height) 
	{
		// nothing; intermediate blank frame
	} 
	else 
	{
		image = image2_;
		srcSize = image2Size_;
		destRect = NSMakeRect(0, animationFrame_ -
							  (image1Size_.height + image2Size_.height),
							  image2Size_.width, image2Size_.height);
	}
	
	if (image) 
	{
		NSRect sourceImageRect =
        NSMakeRect(0, 0, srcSize.width, srcSize.height);
		[image drawInRect:destRect
				 fromRect:sourceImageRect
				operation:NSCompositeSourceOver
				 fraction:1.0];
	}
}

- (void)advanceFrame 
{
	++animationFrame_;
}

@end

// ThrobberTimer manages the animation of a set of ThrobberViews.  It allows
// a single timer instance to be shared among as many ThrobberViews as needed.
@interface ThrobberTimer : NSObject 
{
	@private
	// A set of weak references to each ThrobberView that should be notified
	// whenever the timer fires.
	NSMutableSet *throbbers_;
	
	// Weak reference to the timer that calls back to this object.  The timer
	// retains this object.
	NSTimer* timer_;
	
	// Whether the timer is actively running.  To avoid timer construction
	// and destruction overhead, the timer is not invalidated when it is not
	// needed, but its next-fire date is set to [NSDate distantFuture].
	// It is not possible to determine whether the timer has been suspended by
	// comparing its fireDate to [NSDate distantFuture], though, so a separate
	// variable is used to track this state.
	BOOL timerRunning_;
	
	// The thread that created this object.  Used to validate that ThrobberViews
	// are only added and removed on the same thread that the fire action will
	// be performed on.
	NSThread* validThread_;
}

// Returns a shared ThrobberTimer.  Everyone is expected to use the same
// instance.
+ (ThrobberTimer*)sharedThrobberTimer;

// Invalidates the timer, which will cause it to remove itself from the run
// loop.  This causes the timer to be released, and it should then release
// this object.
- (void)invalidate;

// Adds or removes ThrobberView objects from the throbbers_ set.
- (void)addThrobber:(ThrobberView*)throbber;
- (void)removeThrobber:(ThrobberView*)throbber;
@end

@interface ThrobberTimer ()
// Starts or stops the timer as needed as ThrobberViews are added and removed
// from the throbbers_ set.
- (void)maintainTimer;

// Calls animate on each ThrobberView in the throbbers_ set.
- (void)fire:(NSTimer*)timer;
@end

@implementation ThrobberTimer
- (id)init 
{
	if ((self = [super init])) 
	{
		// Start out with a timer that fires at the appropriate interval, but
		// prevent it from firing by setting its next-fire date to the distant
		// future.  Once a ThrobberView is added, the timer will be allowed to
		// start firing.
		timer_ = [NSTimer scheduledTimerWithTimeInterval:kAnimationIntervalSeconds
												  target:self
												selector:@selector(fire:)
												userInfo:nil
												 repeats:YES];
		[timer_ setFireDate:[NSDate distantFuture]];
		timerRunning_ = NO;
		
		validThread_ = [NSThread currentThread];
		throbbers_ = [[NSMutableSet alloc] init];
	}
	return self;
}

+ (ThrobberTimer*)sharedThrobberTimer 
{
	static id sharedInstance = nil;
	if (sharedInstance == nil) 
		sharedInstance = [[ThrobberTimer alloc] init];

	return sharedInstance;
}

- (void)invalidate 
{
	[timer_ invalidate];
}

- (void)addThrobber:(ThrobberView*)throbber 
{
	[throbbers_ addObject:throbber];
	[self maintainTimer];
}

- (void)removeThrobber:(ThrobberView*)throbber 
{
	[throbbers_ removeObject:throbber];
	[self maintainTimer];
}

- (void)maintainTimer 
{
	BOOL oldRunning = timerRunning_;
	BOOL newRunning = ([throbbers_ count] == 0) ? NO : YES;
	
	if (oldRunning == newRunning)
		return;
	
	// To start the timer, set its next-fire date to an appropriate interval from
	// now.  To suspend the timer, set its next-fire date to a preposterous time
	// in the future.
	NSDate* fireDate;
	if (newRunning)
		fireDate = [NSDate dateWithTimeIntervalSinceNow:kAnimationIntervalSeconds];
	else
		fireDate = [NSDate distantFuture];
	
	[timer_ setFireDate:fireDate];
	timerRunning_ = newRunning;
}

- (void)fire:(NSTimer*)timer 
{
	// The call to [throbber animate] may result in the ThrobberView calling
	// removeThrobber: if it decides it's done animating.  That would invalidate
	// the iterator, making it impossible to correctly get to the next element
	// in the set.  To prevent that from happening, a snapshot of the array is used
	// to iterate over.
	
	NSArray *snapshot = [throbbers_ allObjects];
	NSEnumerator *enumerator = [snapshot objectEnumerator];
	ThrobberView *current = nil;
	while (( current = [enumerator nextObject])) 
		[current animate];
}
@end

@implementation ThrobberView

+ (id)filmstripThrobberViewWithFrame:(NSRect)frame
                               image:(NSImage*)image 
{
	ThrobberFilmstripDelegate* delegate =
	[[[ThrobberFilmstripDelegate alloc] initWithImage:image] autorelease];
	if (!delegate)
		return nil;
	
	return [[[ThrobberView alloc] initWithFrame:frame
									   delegate:delegate] autorelease];
}

+ (id)toastThrobberViewWithFrame:(NSRect)frame
                     beforeImage:(NSImage*)beforeImage
                      afterImage:(NSImage*)afterImage 
{
	ThrobberToastDelegate* delegate =
	[[[ThrobberToastDelegate alloc] initWithImage1:beforeImage
											image2:afterImage] autorelease];
	if (!delegate)
		return nil;
	
	return [[[ThrobberView alloc] initWithFrame:frame
									   delegate:delegate] autorelease];
}

- (id)initWithFrame:(NSRect)frame delegate:(id<ThrobberDataDelegate>)delegate 
{
	if ((self = [super initWithFrame:frame])) 
		dataDelegate_ = [delegate retain];

	return self;
}

- (void)dealloc 
{
	[dataDelegate_ release];
	[[ThrobberTimer sharedThrobberTimer] removeThrobber:self];
	
	[super dealloc];
}

// Manages this ThrobberView's membership in the shared throbber timer set on
// the basis of its visibility and whether its animation needs to continue
// running.
- (void)maintainTimer 
{
	ThrobberTimer* throbberTimer = [ThrobberTimer sharedThrobberTimer];
	
	if ([self window] && ![self isHidden] && ![dataDelegate_ animationIsComplete])
		[throbberTimer addThrobber:self];
	else
		[throbberTimer removeThrobber:self];
}

// A ThrobberView added to a window may need to begin animating; a ThrobberView
// removed from a window should stop.
- (void)viewDidMoveToWindow 
{
	[self maintainTimer];
	[super viewDidMoveToWindow];
}

// A hidden ThrobberView should stop animating.
- (void)viewDidHide 
{
	[self maintainTimer];
	[super viewDidHide];
}

// A visible ThrobberView may need to start animating.
- (void)viewDidUnhide 
{
	[self maintainTimer];
	[super viewDidUnhide];
}

// Called when the ThrobberTimerTarget gets tickled by our timer. Advance the
// frame, dirty the display, and kill the timer when it's no longer needed.
- (void)animate 
{
	[dataDelegate_ advanceFrame];
	[self setNeedsDisplay:YES];
	
	if ([dataDelegate_ animationIsComplete]) 
	{
		[[ThrobberTimer sharedThrobberTimer] removeThrobber:self];
	}
}

// Overridden to draw the appropriate frame in the image strip.
- (void)drawRect:(NSRect)rect 
{
	[dataDelegate_ drawFrameInRect:[self bounds]];
}

@end



