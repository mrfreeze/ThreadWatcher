//
//  FRTableView.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 10/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRTableView.h"
#import "FRAppDelegate.h"


@implementation FRTableView


-(void)keyDown:(NSEvent *)theEvent
{
    NSString* key = [theEvent charactersIgnoringModifiers];
	
    if([key isEqual:@" "]) 
        [(FRAppDelegate *)[NSApp delegate] togglePreviewPanel:self];
	else
        [super keyDown:theEvent];
}

@end
