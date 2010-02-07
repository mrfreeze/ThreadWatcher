//
//  tag.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 02/01/2010.
//  Copyright 2010 FreezeCo. All rights reserved.
//

#import <Foundation/Foundation.h>

// represents a single tag. kind of redundant since it on;y contains a single NSString
// TODO: get rid of this and just use NSStrings directly, 
// unless there is some other kind of information we might need to store with the tags...


@interface tag : NSObject 
{
	NSString *tagString;
}

@property (readwrite, retain) NSString *tagString;
@end
