//
//  tag.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 02/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "tag.h"


@implementation tag

- (id)init
{
	self = [super init];
	if (self) 
	{
		tagString = @"newTag";
	}
	return self;
}

- (NSUInteger)hash
{
	return [tagString hash];
}

- (BOOL)isEqual:(id)object
{
	if ([object class] != [self class])
		return NO;
	
	return [[self tagString] isEqual:[object tagString]];
}

@synthesize tagString;
@end
