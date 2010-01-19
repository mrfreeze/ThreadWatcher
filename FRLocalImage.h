//
//  FRLocalImage.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>


@interface FRLocalImage : NSObject <QLPreviewItem>
{
	NSString *posted;
	BOOL postedBOOL;
	NSURL *localURL;
	NSString *error;
	NSColor *color;
	NSString *sizeS;
	NSNumber *numSize;
	id previewItemDisplayState;
}

- (id)initWithURL:(NSURL *)url;
- (NSString *)size;

@property (readwrite, copy) NSString *posted;
@property (readwrite, copy) NSURL *localURL;
@property (readwrite, copy) NSString *error;
@property (readwrite, copy) NSColor *color;
@property (readwrite, copy) NSNumber *numSize;
@property (readonly) id previewItemDisplayState;
@property (readwrite) BOOL postedBOOL;

@end
