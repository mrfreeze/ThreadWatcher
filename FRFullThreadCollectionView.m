//
//  FRFullThreadCollectionView.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 14/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRFullThreadCollectionView.h"
#import "FRAppDelegate.h"
#import "FRFullThreadCollectionViewItem.h"

@implementation FRFullThreadCollectionView


- (AMCollectionViewItem *)newItemForRepresentedObject:(id)object
{
	return [[FRFullThreadCollectionViewItem alloc] initWithCollectionView:self representedObject:object];
}


- (void)keyDown:(NSEvent *)theEvent
{
    NSString* key = [theEvent charactersIgnoringModifiers];
	
    if([key isEqual:@" "]) 
        [(FRAppDelegate *)[NSApp delegate] togglePreviewPanel:self];
	else
        [super keyDown:theEvent];
}

@end
