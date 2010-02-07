//
//  FRTabBadge.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 03/02/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FRTabBadge : NSView 
{
	int count_;
}

@property (readwrite) int count;

@end
