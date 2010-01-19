//
//  postedImage.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "FRPostedImage.h"
#import "tag.h"
#import <objc/objc-auto.h>
#include <QuickLook/QuickLook.h>
#import "ASIHTTPRequest/ASIHTTPRequest.h"
#import "ASIHTTPRequest/ASINetworkQueue.h"


// ----------------------------------------------------------------------------
#pragma mark private methods
@interface FRPostedImage ()
- (void)generateTheImageFromOriginalSize:(NSSize)theSize animated:(BOOL)anim;
//- (NSImage *)imageByScalingProportionallyToSize:(NSSize)targetSize image:(NSImage *)sourceImage;
- (NSString *)imageType;
@end

//-------------------------------------------------------------------------------
@implementation FRPostedImage

- (id)initWithURLString:(NSString *)s
{
	self = [super init];
	if (self)
	{
		if (s) 
		{
			imageURL = [s copy];
			remoteURL = [NSURL URLWithString:[self imageURL]];
			
			// image name, initially just use the 4chan server name
			// hopefully our linkfetcher will find the original name
			// and replace this
			imageName = [[self imageURL] lastPathComponent];
		}
		
		postURL = nil;
		imageSize = nil;
		localURL = nil;
		theImage = nil;
		imageDimensions = nil;
		savedURL = nil;
		tags = [[NSMutableSet alloc] init];
		tagsAsString = nil;
		rating = 0.0;
		postNumber = nil;
	}
	return self;
}

// turns a size in bytes into a human readable string
+ (NSString *)stringFromFileSize:(NSUInteger)theSize
{
	float floatSize = theSize;
	if (theSize<1000)
		return [NSString stringWithFormat:@"%i bytes",theSize];
	floatSize = floatSize / 1000;
	if (floatSize<1023)
		return [NSString stringWithFormat:@"%1.1f KB",floatSize];
	floatSize = floatSize / 1000;
	if (floatSize<1000)
		return [NSString stringWithFormat:@"%1.1f MB",floatSize];
	floatSize = floatSize / 1000;
	return [NSString stringWithFormat:@"%1.1f GB",floatSize];
}

// download the image to disk and create a thumbnail of it
- (BOOL)downloadImageToFolder:(NSString *)folder animatedThumb:(BOOL)anim withProgressIndicator:(NSProgressIndicator *)p
{	
	if (![self imageURL]) 
		return TRUE;
	
	// the temp file is saved with the 4chan image name, to avoid collisions
	NSString *path = [folder stringByAppendingPathComponent:[[self imageURL] lastPathComponent]];
	[self setLocalURL:[NSURL fileURLWithPath:path]];
	
	// download the file to the folder
	ASIHTTPRequest *theRequest = [ASIHTTPRequest requestWithURL:remoteURL];
	[theRequest setDownloadDestinationPath:path];
	[theRequest setAllowResumeForFileDownloads:NO];
	[p setDoubleValue:0.0];
	[p setMaxValue:0.0];
	[theRequest setShowAccurateProgress:YES];
	[theRequest setDownloadProgressDelegate:p];
	[theRequest startSynchronous];
	
	// read saved data
	NSError *readError = nil;
	NSData *receivedData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]
														 options:NSDataReadingUncached
														   error:&readError];
	if (!receivedData)
	{
		NSLog(@"Error downloading image: %@", readError);
		return FALSE;
	}
	
	// keep a record of the file size in human readable form
	// as well as in bytes
	NSString *theSize = [FRPostedImage stringFromFileSize:[receivedData length]];
	[self setImageSize:theSize];
	[self setFilebytes:[receivedData length]];
	
	// read the file so we can find out the dimensions
	NSImage *rawImage = [[NSImage alloc] initByReferencingURL:localURL];
	[rawImage setCacheMode:NSImageCacheNever];
	
	// to get the actual size of the image, ask it for the dimensions
	// when displayed in a rect larger than the image
	// (is there some way to get this info from file metadata?
	// how do things like the finder get the size of images?)
	NSRect max = NSMakeRect(0.0, 0.0, 10000.0, 10000.0); // 10000 is the max dimension
														 // of a 4chan image (on /hr/)
	NSSize s;
	NSImageRep *bestRep = [rawImage bestRepresentationForRect:max 
													  context:nil 
														hints:nil];
	s.width = [bestRep pixelsWide];
	s.height = [bestRep pixelsHigh];
	[self setSize:s];
	
	// record the size of the original
	int x = s.width;
	int y = s.height;
	[self setImageDimensions:[NSString stringWithFormat:@"%d x %d", x, y]];
			
	// create a thumbnail to display
	[self generateTheImageFromOriginalSize:s animated:anim];
	return TRUE;
}	

// run this after tags are updated to generate the new tagasstring
// representation of the tags
- (void)tagsWereUpdated
{
	// update tagsAsString
	if ([tags count] > 0) 
	{
		NSMutableString *newString = [NSMutableString string];
		for (tag *t in tags)
		{
			if ([newString length] == 0) 
				[newString appendString:[t tagString]];
			else 
			{
				[newString appendString:@", "];
				[newString appendString:[t tagString]];
			}
		}
		
		[self setTagsAsString:newString];
	}
	else
		[self setTagsAsString:nil];
}

- (void)setTags:(NSMutableSet *)newTags
{
	if (tags == newTags)
		return;
	
	if ([tags isEqual:newTags])
		return;
	
	tags = newTags;
	[self tagsWereUpdated];
}

// -----------------------------------------------------------------------------------------------
#pragma mark thumbnail

// thumbnail generating method
- (void)generateTheImageFromOriginalSize:(NSSize)theSize animated:(BOOL)anim
{
	// quicklook doesn't generate animated thumbnails of gifs
	// so if image is a gif and user has asked for animated thumbs, use full image
	if ([[self imageType] isEqual:@"gif"] && anim) 
	{
		// load entire gif. this is very bad for memory usage
		// threads with many gifs will make this unacceptable
		// (turned off by default)
		NSImage *orig = [[NSImage alloc] initWithContentsOfURL:localURL];		
		[orig setCacheMode:NSImageCacheNever];
		[self setTheImage:orig];
		return;
	}
	
	if (theImage == nil) 
	{
		NSDictionary *quickLookOptions = [[NSDictionary alloc] initWithObjectsAndKeys:
                                (id)kCFBooleanFalse, (id)kQLThumbnailOptionIconModeKey,
                                nil];
		CGImageRef quickLookIcon = QLThumbnailImageCreate(NULL, 
														  (CFURLRef)localURL, 
														  CGSizeMake(98.0, 98.0),
														  (CFDictionaryRef)quickLookOptions);
		
		[quickLookOptions release];
		
		// the resulting CGImageRef will be 98x98 square
		// so we need to work out the correct proportions
		// before creating the nsimage
		NSSize corrected;
		if (theSize.width > theSize.height) 
		{
			CGFloat ratio = 98.0 / theSize.width;		
			corrected.width = 98.0;
			corrected.height = theSize.height * ratio;
		}
		else if (theSize.height > theSize.width)
		{
			CGFloat ratio = 98.0 / theSize.height;		
			corrected.height = 98.0;
			corrected.width = theSize.width * ratio;
		}
		else 
		{
			// original was square
			corrected.width = 98.0;
			corrected.height = 98.0;
		}
		
		if (quickLookIcon != NULL) 
		{
			NSImage *betterIcon = [[NSImage alloc] initWithCGImage:quickLookIcon 
															  size:corrected];
			[betterIcon setCacheMode:NSImageCacheNever];
			[self setTheImage:betterIcon];
			CFMakeCollectable(quickLookIcon);
		}
		else 
			NSLog(@"Error generating QL thumbnail");
	}
}

// --------------------------------------------------------------------------------------------------
#pragma mark name

- (NSString *)imageType
{
	NSString*name;
	if (![self imageName])
		name = [[self imageURL] lastPathComponent];
	else
		name = [self imageName];

	NSArray *nameComponents = [name componentsSeparatedByString:@"."];
	
	// extension is given by the last component
	NSString *extension = [NSString stringWithString:[nameComponents lastObject]];
	return extension;
}

// -------------------------------------------------------------------------------------------------
#pragma mark compare
// override isEqual: and hash for when we add objects to the array
// so we can check if the file has already been downloaded
- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[FRPostedImage class]]) 
		return FALSE;
	
	
	if ([[object imageURL] isEqualToString:[self imageURL]]) 
		return TRUE;
	
	if ([[self postNumber] isEqualToString:[object postNumber]])
		return TRUE;
	
	
	return FALSE;
}

- (NSUInteger)hash
{
		return [[self postNumber] hash];
}

// ------------------------------------------------------------------------------------------------

@synthesize imageURL;
@synthesize localURL;
@synthesize remoteURL;
@synthesize postURL;
@synthesize theImage;
@synthesize imageName;
@synthesize savedURL;
@synthesize imageSize;
@synthesize imageDimensions;
@synthesize filebytes;
@synthesize tags;
@synthesize tagsAsString;
@synthesize rating;	 
@synthesize postText;
@synthesize postNumber;
@synthesize size;
@synthesize date;

@end
