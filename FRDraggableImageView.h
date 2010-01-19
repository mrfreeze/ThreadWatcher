//
//  FRDraggableImageView.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// subclass of NSImageView to allow images to be dragged from the image well
// used on the right hand side of the watcher window

@interface FRDraggableImageView : NSImageView 
{
	NSEvent *mouseDownEvent;
	NSURL *localURLOfImage;
}

@property (readwrite, retain) NSURL *localURLOfImage;

@end
