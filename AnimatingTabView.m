/*
    File:  AnimatingTabView.m

    Abstract:  An NSTabView subclass that animates tab switches using Core Image "Transition" Filters
     
    Version:  1.0

    Copyright:  © Copyright 2005 Apple Computer, Inc. All rights reserved.

    Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
    ("Apple") in consideration of your agreement to the following terms, and your
    use, installation, modification or redistribution of this Apple software
    constitutes acceptance of these terms.  If you do not agree with these terms,
    please do not use, install, modify or redistribute this Apple software.

    In consideration of your agreement to abide by the following terms, and subject
    to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
    copyrights in this original Apple software (the "Apple Software"), to use,
    reproduce, modify and redistribute the Apple Software, with or without
    modifications, in source and/or binary forms; provided that if you redistribute
    the Apple Software in its entirety and without modifications, you must retain
    this notice and the following text and disclaimers in all such redistributions of
    the Apple Software.  Neither the name, trademarks, service marks or logos of
    Apple Computer, Inc. may be used to endorse or promote products derived from the
    Apple Software without specific prior written permission from Apple.  Except as
    expressly stated in this notice, no other rights or licenses, express or implied,
    are granted by Apple herein, including but not limited to any patent rights that
    may be infringed by your derivative works or by other works in which the Apple
    Software may be incorporated.

    The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
    WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
    WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
    PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
    COMBINATION WITH YOUR PRODUCTS.

    IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
    GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
    OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
    (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "AnimatingTabView.h"
#import <QuartzCore/QuartzCore.h>

#define TRANSITION_DURATION         0.3
#define TRANSITION_SLOWMO_DURATION  3.0

// Create a subclass of NSAnimation that we'll use to drive the transition.
@interface TabViewAnimation : NSAnimation
@end

// Convenience function to clear an NSBitmapImageRep's bits to zero.
static void ClearBitmapImageRep(NSBitmapImageRep *bitmap) 
{
    unsigned char *bitmapData = [bitmap bitmapData];
    if (bitmapData != NULL) 
	{
        // A fast alternative to filling with [NSColor clearColor].
        bzero(bitmapData, [bitmap bytesPerRow] * [bitmap pixelsHigh]);
    }
}

@implementation AnimatingTabView

// Initializes the attributes that AnimatingTabView adds to NSTabView.  This method is called by -initWithFrame:, and is also used by our Interface Builder palette.
- (void)initAddedProperties 
{
	// default style is swipe
    transitionStyle = AnimatingTabViewSwipeTransitionStyle;
}

- (void)awakeFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    // Preload shading bitmap to use in transitions (borrowed from the "Fun House" Core Image example).
    NSData *shadingBitmapData = [NSData dataWithContentsOfFile:[bundle pathForResource:@"restrictedshine" ofType:@"tiff"]];
    NSBitmapImageRep *shadingBitmap = [[[NSBitmapImageRep alloc] initWithData:shadingBitmapData] autorelease];
    inputShadingImage = [[CIImage alloc] initWithBitmapImageRep:shadingBitmap];

    // Preload mask bitmap to use in transitions.
    NSData *maskBitmapData = [NSData dataWithContentsOfFile:[bundle pathForResource:@"transitionmask" ofType:@"jpg"]];
    NSBitmapImageRep *maskBitmap = [[[NSBitmapImageRep alloc] initWithData:maskBitmapData] autorelease];
    inputMaskImage = [[CIImage alloc] initWithBitmapImageRep:maskBitmap];
	
	// use swipe animation
	[self setTransitionStyle:AnimatingTabViewSwipeTransitionStyle];
	
	[[self layer] setBackgroundColor:CGColorGetConstantColor(kCGColorWhite)];
}

#pragma mark -
#pragma mark *** NSTabView Method Overrides ***

- (void)drawRect:(NSRect)rect {
    // First, draw the normal TabView content.  If we're animating, we will have hidden the TabView's content view, so invoking [super drawRect:rect] will just draw the tabs, border, and inset background.
    [super drawRect:rect];

    // If we're in the middle of animating, composite the animation result atop the base TabView content.
    if (animation != nil) {
        // Get outputCIImage for the current phase of the animation.  (This doesn't actually cause the image to be rendered just yet.)
        [transitionFilter setValue:[NSNumber numberWithFloat:[animation currentValue]] forKey:@"inputTime"];
        CIImage *outputCIImage = [transitionFilter valueForKey:@"outputImage"];

        // Composite the outputImage into the view (which triggers on-demand rendering of the result).
        [outputCIImage drawInRect:imageRect fromRect:NSMakeRect(0, imageRect.size.height, imageRect.size.width, -imageRect.size.height) operation:NSCompositeSourceOver fraction:1.0];
    }
}

- (void)createTransitionFilterForRect:(NSRect)rect initialCIImage:(CIImage *)initialCIImage finalCIImage:(CIImage *)finalCIImage {
    CIFilter *maskScalingFilter = nil;
    CGRect maskExtent;

    switch (transitionStyle) {
        case AnimatingTabViewCopyMachineTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CICopyMachineTransition"] retain];
            [transitionFilter setDefaults];
            [transitionFilter setValue:[CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height] forKey:@"inputExtent"];
            break;

        case AnimatingTabViewDisintegrateWithMaskTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CIDisintegrateWithMaskTransition"] retain];
            [transitionFilter setDefaults];

            // Scale our mask image to match the transition area size, and set the scaled result as the "inputMaskImage" to the transitionFilter.
            maskScalingFilter = [CIFilter filterWithName:@"CILanczosScaleTransform"];
            [maskScalingFilter setDefaults];
            maskExtent = [inputMaskImage extent];
            CGFloat xScale = rect.size.width / maskExtent.size.width;
            CGFloat yScale = rect.size.height / maskExtent.size.height;
            [maskScalingFilter setValue:[NSNumber numberWithFloat:yScale] forKey:@"inputScale"];
            [maskScalingFilter setValue:[NSNumber numberWithFloat:xScale / yScale] forKey:@"inputAspectRatio"];
            [maskScalingFilter setValue:inputMaskImage forKey:@"inputImage"];

            [transitionFilter setValue:[maskScalingFilter valueForKey:@"outputImage"] forKey:@"inputMaskImage"];
            break;

        case AnimatingTabViewDissolveTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CIDissolveTransition"] retain];
            [transitionFilter setDefaults];
            break;

        case AnimatingTabViewFlashTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CIFlashTransition"] retain];
            [transitionFilter setDefaults];
            [transitionFilter setValue:[CIVector vectorWithX:NSMidX(rect) Y:NSMidY(rect)] forKey:@"inputCenter"];
            [transitionFilter setValue:[CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height] forKey:@"inputExtent"];
            break;

        case AnimatingTabViewModTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CIModTransition"] retain];
            [transitionFilter setDefaults];
            [transitionFilter setValue:[CIVector vectorWithX:NSMidX(rect) Y:NSMidY(rect)] forKey:@"inputCenter"];
            break;

        case AnimatingTabViewPageCurlTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CIPageCurlTransition"] retain];
            [transitionFilter setDefaults];
            [transitionFilter setValue:[NSNumber numberWithFloat:-M_PI_4] forKey:@"inputAngle"];
            [transitionFilter setValue:initialCIImage forKey:@"inputBacksideImage"];
            [transitionFilter setValue:inputShadingImage forKey:@"inputShadingImage"];
            [transitionFilter setValue:[CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height] forKey:@"inputExtent"];
            break;

        case AnimatingTabViewSwipeTransitionStyle:
            transitionFilter = [[CIFilter filterWithName:@"CISwipeTransition"] retain];
            [transitionFilter setDefaults];
            break;

        case AnimatingTabViewRippleTransitionStyle:
        default:
            transitionFilter = [[CIFilter filterWithName:@"CIRippleTransition"] retain];
            [transitionFilter setDefaults];
            [transitionFilter setValue:[CIVector vectorWithX:NSMidX(rect) Y:NSMidY(rect)] forKey:@"inputCenter"];
            [transitionFilter setValue:[CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height] forKey:@"inputExtent"];
            [transitionFilter setValue:inputShadingImage forKey:@"inputShadingImage"];
            break;
    }
    [transitionFilter setValue:initialCIImage forKey:@"inputImage"];
    [transitionFilter setValue:finalCIImage forKey:@"inputTargetImage"];
}

- (void)selectTabViewItem:(NSTabViewItem *)tabViewItem 
{
    // If we're in Interface Builder, and we're in editing mode 
	//(not "Test Interface" mode), don't bother trying to animate; 
	// we should just do the normal quick tab switch.
    /*if ([NSApp respondsToSelector:@selector(isTestingInterface)] && ![NSApp isTestingInterface]) 
	{
        [super selectTabViewItem:tabViewItem];
        return;
    }*/

    // Make a note of the content view of the NSTabViewItem 
	// we're switching from, and the content view of the one we're switching to.
    NSView *initialContentView = [[self selectedTabViewItem] view];
    NSView *finalContentView = [tabViewItem view];

    // Compute bounds and frame rectangles big enough to encompass both views.
	// (We'll use imageRect later, to composite the animation frames into the right
	// place within the AnimatingTabView.)
    NSRect rect = NSUnionRect([initialContentView bounds], [finalContentView bounds]);
    imageRect = NSUnionRect([initialContentView frame], [finalContentView frame]);

    // Render the initialContentView to a bitmap.  When using 
	// the -cacheDisplayInRect:toBitmapImageRep: and
	// -displayRectIgnoringOpacity:inContext: methods, remember to first 
	// initialize the destination to clear if the content to be drawn won't cover it with full opacity.
    NSBitmapImageRep *initialContentBitmap;
    if (transitionStyle == AnimatingTabViewPageCurlTransitionStyle) {
        // For the "Page Curl" transition style, we want the initialContentBitmap to include the opaque window background, so we use the time-honored -initWithFocusedViewRect: approach to capturing a snapshot of the view content.
        [self lockFocus];
        initialContentBitmap = [[[NSBitmapImageRep alloc] initWithFocusedViewRect:imageRect] autorelease];
        [self unlockFocus];
    } else {
        initialContentBitmap = [initialContentView bitmapImageRepForCachingDisplayInRect:rect];
        ClearBitmapImageRep(initialContentBitmap);
        [initialContentView cacheDisplayInRect:rect toBitmapImageRep:initialContentBitmap];
    }

    // Invoke super's implementation of -selectTabViewItem: to switch to the requested tabViewItem.  The NSTabView will mark itself as needing display, but the window will not have redrawn yet, so this is our chance to animate the transition!
    [super selectTabViewItem:tabViewItem];

    // Render the finalContentView to a bitmap.
    NSBitmapImageRep *finalContentBitmap = [finalContentView bitmapImageRepForCachingDisplayInRect:rect];
    ClearBitmapImageRep(finalContentBitmap);
    [finalContentView cacheDisplayInRect:rect toBitmapImageRep:finalContentBitmap];

    // Build a Core Image filter that will morph the initialContentBitmap into the finalContentBitmap.  For more information regarding CI transition filters, see the "Transition Filters" page in the "Core Image Filters" section of the Core Image Programming Guide, at http://developer.apple.com/documentation/GraphicsImaging/Conceptual/CoreImaging/index.html
    CIImage *initialCIImage = [[CIImage alloc] initWithBitmapImageRep:initialContentBitmap];
    CIImage *finalCIImage = [[CIImage alloc] initWithBitmapImageRep:finalContentBitmap];
    [self createTransitionFilterForRect:rect initialCIImage:initialCIImage finalCIImage:finalCIImage];
    [initialCIImage release];
    [finalCIImage release];

    // Create an instance of TabViewAnimation to drive the transition over time.  Set the AnimatingTabView to be the TabViewAnimation's delegate, so the TabViewAnimation will know which view to redisplay as the animation progresses.
    animation = [[TabViewAnimation alloc] initWithDuration:(slowMotionDemo ? TRANSITION_SLOWMO_DURATION : TRANSITION_DURATION) animationCurve:NSAnimationEaseInOut];
    [animation setDelegate:self];

    // Hide the TabView's new content view for the duration of the animation.
    [finalContentView setHidden:YES];

    // Run the animation synchronously.
    [animation startAnimation];

    // Clean up after the animation has finished.
    [animation release];
    animation = nil;
    [transitionFilter release];
    transitionFilter = nil;
    slowMotionDemo = NO;
    [finalContentView setHidden:NO];
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark *** Mouse Event Handling ***

// This override exists only as a means to enable slow-motion "demo" mode.  It simply makes a note of whether the [Shift] key was pressed when the mouse was last clicked in the TabView.
- (void)mouseDown:(NSEvent *)theEvent {
    if ([theEvent modifierFlags] & NSShiftKeyMask) {
        slowMotionDemo = YES;
    }
    [super mouseDown:theEvent];
}

#pragma mark -
#pragma mark *** Archiving ***

// A view must know how to archive and unarchive itself in order to be placed in a custom Interface Builder palette.

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    if ([aCoder allowsKeyedCoding]) {
        [aCoder encodeInt:transitionStyle forKey:@"transitionStyle"];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if ([aDecoder allowsKeyedCoding]) {
            transitionStyle = [aDecoder decodeIntForKey:@"transitionStyle"];
        }
    }
    return self;
}

@synthesize transitionStyle;

@end

@implementation TabViewAnimation

// Override NSAnimation's -setCurrentProgress: method, and use it as our point to hook in and advance our Core Image transition effect to the next time slice.
- (void)setCurrentProgress:(NSAnimationProgress)progress {
    // First, invoke super's implementation, so that the NSAnimation will remember the proposed progress value and hand it back to us when we ask for it in AnimatingTabView's -drawRect: method.
    [super setCurrentProgress:progress];

    // Now ask the AnimatingTabView (which set itself as our delegate) to display.  Sending a -display message differs from sending -setNeedsDisplay: or -setNeedsDisplayInRect: in that it demands an immediate, syncrhonous redraw of the view.  Most of the time, it's preferrable to send a -setNeedsDisplay... message, which gives AppKit the opportunity to coalesce potentially numerous display requests and update the window efficiently when it's convenient.  But for a syncrhonously executing animation, it's appropriate to use -display.
    [(AnimatingTabView *)[self delegate] display];
}

@end
