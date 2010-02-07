//
//  FRIKImageView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 07/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class FRPostImageBox;

// the image view used in the post sheet of the watcher window
// allows user to drag an image onto it

@interface FRIKImageView : NSImageView 
{
	NSURL *imageFileURL;
	__weak IBOutlet FRPostImageBox *containingBox;
	__weak IBOutlet NSWindow *theWindow; // outlet to the window so we can set the first responder
	NSUInteger boardMaxSize; // max size of the board we are posting to
}

- (void)setImageWithURL:(NSURL*)url;

@property (readwrite, retain) NSURL *imageFileURL;
@property (readwrite) NSUInteger boardMaxSize;
@end


// box around the imageview
@interface FRPostImageBox : NSBox
{
	BOOL highlighted;
	NSRect focusRect;
}

@property (readwrite) NSRect focusRect;
@property (readwrite) BOOL highlighted;

@end
