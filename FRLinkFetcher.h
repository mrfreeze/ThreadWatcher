//
//  linkFetcher.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 08/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRPostedImage.h"

@class FRLinkFetcher;

@protocol FRLinkFetcherDelegate
- (void)loadingPage;
- (void)pageWasLoaded:(NSNumber *)max;
- (void)fetchedAllImages;
- (void)addNewImage:(id)i;
- (void)setWindowNameTo:(NSString *)n;
- (NSMutableArray *)links;
- (void)returnedError:(NSString *)errorMessage;
- (BOOL)wantsAnimation;
- (void)setFetcher:(id)newFetcher;
- (void)wasCancelled;
- (void)threadDied;
@end

@interface FRLinkFetcher : NSOperation 
{
	id _delegate;
	NSString *dirPath;
	NSData *receivedData;
	NSURL *baseURL;
	NSURL *instanceURL;
	NSString *folderPath;
	NSProgressIndicator *downloadBar;
}

- (void)main;
- (id)initWithURLString:(NSString *)newURLString delegate:(id)d directory:(NSString *)dir;
- (BOOL)generateLinks;
- (id)delegate;
- (void)setDelegate:(id)newDelegate;

+ (NSMutableString *)cleanBaseURLAsMutableString:(NSURL *)orig;

@property (readonly, copy, nonatomic) NSURL *baseURL;
@property (readonly, copy, nonatomic) NSURL *instanceURL;
@property (readonly, copy, nonatomic) NSString *dirPath;
@property (readwrite) NSProgressIndicator *downloadBar;
@property (readwrite, retain, nonatomic) NSData *receivedData;

@end
