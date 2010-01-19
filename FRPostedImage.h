//
//  postedImage.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

// represents an image posted to a thread

// instances of postedImage can be in two states
// the first, when they are just created, where they just
// contain the URL of the image (so we can check if it is already downloaded
// before we get all the data)
// after it recieves downloadImageToFolder:, it will download the image 
// to the folder and create the  NSImage thumbnail
// for use in displaying the image

// asking for anything other than remoteURL or imageURL before the
// file has been downlaoded should return nil

@interface FRPostedImage : NSObject
{
	// initial information
	NSString *imageURL; // remote url as string
	NSURL *remoteURL;
	NSURL *postURL; // url of the original post
	NSString *postText;
	NSString *postNumber;
	NSString *date;
	
	// information generated after download
	NSString *imageName;
	NSString *imageSize; // image size as human readable string
	NSSize size; // max image size as NSSize
	NSString *imageDimensions;
	NSUInteger filebytes;
	NSURL *localURL; // location of the file in the /tmp directory
	
	// thumbnail image (resized to 98 x 98)
	NSImage *theImage;
	
	// url for the saved file, if the user has saved the image, nil if unsaved
	NSURL *savedURL; 
	
	NSMutableSet *tags;
	double rating;
	NSString *tagsAsString;
}

// convert a file size in raw bytes into nice human readable form, 
// currently uses base-10 SI units
+ (NSString *)stringFromFileSize:(NSUInteger)theSize;

// create new instance just containing the url
- (id)initWithURLString:(NSString *)s;

// when first created we only contain the URL so
// send this message to actually download the image data
// returns true if download was succesful, otherwise false
- (BOOL)downloadImageToFolder:(NSString *)folder animatedThumb:(BOOL)anim withProgressIndicator:(NSProgressIndicator *)p;

- (void)tagsWereUpdated;

@property (readwrite, copy, nonatomic) NSString *imageURL;
@property (readwrite, retain, nonatomic) NSURL *remoteURL;
@property (readwrite, retain, nonatomic) NSURL *localURL;
@property (readwrite, retain, nonatomic) NSURL *postURL;
@property (readwrite, retain) NSImage *theImage;
@property (readwrite, retain, nonatomic) NSString *imageName;
@property (readwrite, retain, nonatomic) NSString *imageSize;
@property (readwrite, retain, nonatomic) NSString *imageDimensions;
@property (readwrite) NSUInteger filebytes;
@property (readwrite, retain, nonatomic) NSURL *savedURL;
@property (readwrite, retain) NSMutableSet *tags;
@property (readwrite, retain) NSString *tagsAsString;
@property (readwrite) double rating;
@property (readwrite, retain, nonatomic) NSString *postText;
@property (readwrite, retain, nonatomic) NSString *postNumber;
@property (readwrite) NSSize size;
@property (readwrite, retain) NSString *date;

@end
