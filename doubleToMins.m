//
//  doubleToMins.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 13/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "doubleToMins.h"
#include <math.h>


@implementation doubleToMins

+ (Class)transformedValueClass
{
	return [NSString class];
}

+ (BOOL)allowsReverseTransform
{
	return NO;
}

// transform a nsnumber representing a double into a human
// readable string of the form 'mm:ss minutes'
- (id)transformedValue:(id)value
{
	if (value != nil) 
	{
		double d = [value doubleValue];
		int m = (int)d;
		double sec = fmod(d, 1);
		sec *= 60.0;
		int s = (int)sec; // no need to be too accurate here
						  // so don't worry about rounding
		
		return [NSString stringWithFormat:@"%02d:%02d minutes", m, s];
	}
	return [NSString stringWithString:@""];
}

@end
