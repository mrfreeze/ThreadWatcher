//
//  FRPostedValueTransformer.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 09/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRPostedValueTransformer.h"
#import "FRLocalImage.h"


@implementation FRPostedValueTransformer

+ (Class)transformedValueClass 
{
	return [NSImage class];
}

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

- (id)transformedValue:(FRLocalImage *)value
{
	NSString *isPosted = [value posted];
	
	if ([isPosted isEqual:@"posted"]) 
		return [NSImage imageNamed:@"green.tif"];
	else if ([isPosted isEqual:@"posting"])
		return [NSImage imageNamed:@"orange.tif"];
	else 
		return nil;

	return nil;
}



@end
