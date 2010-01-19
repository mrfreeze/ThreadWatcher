//
//  FRPostedValueTransformer.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// turns a string into an image. for use in the table view to give the green and orange dots

// "posted"  -> green dot
// "posting" -> orange dot
// nil / anything else -> blank

@interface FRPostedValueTransformer : NSValueTransformer {

}

@end
