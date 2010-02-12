//
//  MyDocument.m
//  moreTabs
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "MyDocument.h"
#import "TabbedWindowController.h"


@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) 
	{
		tabStripModel = [[TabStripModel alloc] init];
		[tabStripModel setDelegate:self];
    }
    return self;
}

- (void)makeWindowControllers
{
	TabbedWindowController *winController = [[TabbedWindowController alloc] initWithMyDocument:self];
	[self addWindowController:winController];
}

// used to create a new window controller with known, existing tab contents
- (void)makeWindowControllersWithContents:(FRWatcherTabContentsController *)contents
{
	[contents setMyDocument:self];
	TabbedWindowController *winController = [[TabbedWindowController alloc] initWithDocument:self
																				 tabContents:contents
																			   takeOwnership:YES];
	[self addWindowController:winController];	
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

- (MyDocument *)createNewStripWithContents:(FRWatcherTabContentsController *)contents windowRect:(NSRect)rect
{
	MyDocument *new = [[MyDocument alloc] init];
	[new makeWindowControllersWithContents:contents];
	[[[[new windowControllers] lastObject] window] setFrame:rect display:NO];

	return new;
}

- (NSArray *)tabs
{
	return [[self tabStripModel] tabs];
}

- (void)newTab:(id)sender
{
	[tabStripModel addNewTab];
}


@synthesize tabStripModel;

@end
