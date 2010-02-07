//
//  FRDocumentController.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 08/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRDocumentController.h"
#import "MyDocument.h"
#import "FRDumpDocument.h"


@implementation FRDocumentController


- (IBAction)newWatcher:(id)sender
{
	NSError *openError = nil;
	MyDocument *watchDoc = [self makeUntitledDocumentOfType:@"Watcher" 
													  error:&openError];
	
	if (!watchDoc) 
		NSLog(@"Error creating watcher document: %@", openError);
	else 
	{
		[self addDocument:watchDoc];
		[watchDoc makeWindowControllers];
		[watchDoc showWindows];
	}
}

- (IBAction)newDumper:(id)sender
{
	NSError *openError = nil;
	FRDumpDocument *dumpDoc =  [self makeUntitledDocumentOfType:@"Dumper" 
														  error:&openError];
	if (!dumpDoc) 
		NSLog(@"Error creating image dump document: %@", openError);
	else 
	{
		[self addDocument:dumpDoc];
		[dumpDoc makeWindowControllers];
		[dumpDoc showWindows];
	}		
}

		 
@end
