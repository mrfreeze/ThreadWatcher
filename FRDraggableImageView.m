//
//  FRDraggableImageView.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "FRDraggableImageView.h"

// private methods
@interface FRDraggableImageView ()
- (NSImage*)imageByScalingProportionally:(NSImage *)sourceImage ToSize:(NSSize)targetSize;
@end


@implementation FRDraggableImageView

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationCopy;
}

- (void)mouseDown:(NSEvent *)event
{
		[event retain];
		[mouseDownEvent release];
		mouseDownEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [event locationInWindow];
	float distance = hypot( (down.x - drag.x), (down.y - drag.y));
	if (distance < 3) 
		return;
	
	if ([self image] == nil) 
		return;
	
	// generate thumbnail
	NSSize s;
	s.width = 98.0;
	s.height = 98.0;
	NSImage *thumbnailImage = [self imageByScalingProportionally:[self image] 
														  ToSize:s];
	
	//make thumbnail semi-transparent
	NSRect thumbnailRect;
	NSSize actual = [thumbnailImage size];
	thumbnailRect.origin = NSZeroPoint;
	thumbnailRect.size.width = actual.width;
	thumbnailRect.size.height = actual.height;
	
	[thumbnailImage lockFocus];
	[thumbnailImage drawAtPoint:NSZeroPoint 
					   fromRect:thumbnailRect  
					  operation:NSCompositeCopy 
								 fraction:0.6];
	[thumbnailImage unlockFocus];
	
	// location of mousedown event
	NSPoint p = [self convertPoint:down fromView:nil];
	
	//drag fron centre of the image
	p.x = p.x - s.width/2.0;
	p.y = p.y - s.height/2.0;
	
	// copy path to pasteboard
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
	[pb clearContents];
	NSString *path = [[self localURLOfImage] path];
	NSArray *fileList = [NSArray arrayWithObjects:path, nil];
	[pb declareTypes:[NSArray arrayWithObject:NSFilenamesPboardType]
				   owner:nil];
	[pb setPropertyList:fileList forType:NSFilenamesPboardType];
	
	[self dragImage:thumbnailImage
				 at:p
			 offset:NSZeroSize
			  event:mouseDownEvent 
		 pasteboard:pb 
			 source:self 
		  slideBack:YES];	
}

// for generating thumbnails for drag and drop operations 
// (we could just use the thumbnail we have already created. why are we doing this?)
- (NSImage*)imageByScalingProportionally:(NSImage *)sourceImage ToSize:(NSSize)targetSize
{
	NSImage* newImage = nil;
	
	if ([sourceImage isValid])
	{
		NSSize imageSize = [sourceImage size];
		float width  = imageSize.width;
		float height = imageSize.height;
		
		float targetWidth  = targetSize.width;
		float targetHeight = targetSize.height;
		
		float scaleFactor  = 0.0;
		float scaledWidth  = targetWidth;
		float scaledHeight = targetHeight;
		
		NSPoint thumbnailPoint = NSZeroPoint;
		
		if ( NSEqualSizes( imageSize, targetSize ) == NO )
		{
			
			float widthFactor  = targetWidth / width;
			float heightFactor = targetHeight / height;
			
			if ( widthFactor < heightFactor )
				scaleFactor = widthFactor;
			else
				scaleFactor = heightFactor;
			
			scaledWidth  = width  * scaleFactor;
			scaledHeight = height * scaleFactor;
			
			if ( widthFactor < heightFactor )
				thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
			
			else if ( widthFactor > heightFactor )
				thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
		
		newImage = [[NSImage alloc] initWithSize:targetSize];
		
		[newImage lockFocus];
		
		NSRect thumbnailRect;
		thumbnailRect.origin = thumbnailPoint;
		thumbnailRect.size.width = scaledWidth;
		thumbnailRect.size.height = scaledHeight;
		
		[sourceImage drawInRect: thumbnailRect
					   fromRect: NSZeroRect
					  operation: NSCompositeSourceOver
					   fraction: 1.0];
		
		[newImage unlockFocus];
		
	}
	
	return newImage;
}



@synthesize localURLOfImage;

@end
