//
//  FRLocalImage.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRLocalImage.h"
#import "FRPostedImage.h"


@implementation FRLocalImage


- (id)initWithURL:(NSURL *)url
{
	self = [super init];
	if (self)
	{
		localURL = url;
		posted = nil;
		postedBOOL = FALSE;
		error = nil;
		color = [NSColor blackColor];
		sizeS = nil;
		
		// get size of the image
		NSFileManager *fm = [NSFileManager defaultManager];
		NSError *err = nil;
		NSDictionary *attributes = [fm attributesOfItemAtPath:[url path] 
														error:&err];
		unsigned long long rawsize = [attributes fileSize];
		numSize = [NSNumber numberWithLongLong:rawsize];
	}
	return self;
}

// returns size as human readable string
// calculates the first time it's asked for, and caches
- (NSString *)size
{
	if (!sizeS) 
		sizeS = [FRPostedImage stringFromFileSize:[[self numSize] intValue]];

	return sizeS;
}	

- (NSUInteger)hash
{
	return [[localURL path] hash];
}

- (BOOL) isEqual: (id)object
{
	if ([[self localURL] isEqual:[object localURL]])
		return TRUE;
	else 
		return FALSE;
}


- (NSURL *)previewItemURL
{
	return [self localURL];
}

- (NSString *)previewItemTitle
{
	return [[self localURL] lastPathComponent];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@, %@", [super description], [self localURL]];
}

@synthesize posted;
@synthesize localURL;
@synthesize error;
@synthesize color;
@synthesize numSize;
@synthesize previewItemDisplayState;
@synthesize postedBOOL;

@end
