//
//  FRUploadOperation.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRLocalImage.h"
#import "FRDumpDocument.h"

@interface FRUploadOperation : NSOperation 
{
	int delay;
	NSString *theName;
	NSString *email;
	NSString *subject;
	NSString *theComment;
	NSURL *uploadTargetURL;
	BOOL newThread;
	NSString *threadNumber;
	NSString *oldThreadNumber;
	FRLocalImage *local;
	NSProgressIndicator *uploadProgressDelegate;
	NSOperationQueue *queue;
	FRDumpDocument *delegate;
	BOOL isPaused;
	BOOL growling;
}

- (id)initWithTargetURL:(NSURL *)target andLocalImage:(FRLocalImage *)im fromQueue:(NSOperationQueue *)q;
- (void)main;

@property (readwrite, nonatomic) int delay;
@property (readwrite, copy) NSString *email;
@property (readwrite, copy) NSString *theName;
@property (readwrite, copy) NSString *subject;
@property (readwrite, copy) NSString *theComment;
@property (readwrite, nonatomic, copy) NSURL *uploadTargetURL;
@property (readwrite, nonatomic) BOOL newThread;
@property (readwrite, nonatomic, copy) NSString *threadNumber;
@property (readwrite, nonatomic) NSOperationQueue *queue;
@property (readwrite, assign) NSProgressIndicator *uploadProgressDelegate; 
@property (readwrite, assign) FRDumpDocument *delegate;
@property (readwrite) BOOL isPaused;
@property (readwrite, copy) NSString *oldThreadNumber;


@end
