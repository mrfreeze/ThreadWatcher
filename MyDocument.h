//
//  MyDocument.h
//  moreTabs
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "TabStripModel.h"
#import "FRWatcherTabContentsController.h"
#import "MyDocument.h"
#import "TabbedWindowController.h"

@class TabStripModel;
@class MyDocument;
@class FRWatcherTabContentsController;

@interface MyDocument : NSDocument
{
	TabStripModel *tabStripModel;
	NSArray *tabs;
}

- (MyDocument *)createNewStripWithContents:(FRWatcherTabContentsController *)contents windowRect:(NSRect)rect;
- (void)makeWindowControllersWithContents:(FRWatcherTabContentsController *)contents;
- (void)newTab:(id)sender;

@property (readwrite, retain) TabStripModel *tabStripModel;
@property (readonly, retain) NSArray *tabs;

@end
