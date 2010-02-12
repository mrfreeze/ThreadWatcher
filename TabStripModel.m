//
//  TabStripModel.m
//  moreTabs
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "TabStripModel.h"

@interface TabStripModel ()

- (void)changeSelectedContentsFrom:(FRWatcherTabContentsController *)oldContents to:(int)index userGesture:(BOOL)gesture;

@end


@implementation TabStripModel

@synthesize selectedContents;
@synthesize selectedIndex;
@synthesize controller = controller_;
@synthesize delegate;
@synthesize toolbarController = toolbarController_;
@synthesize tabs;

- (id)init
{
	self = [super init];
	if (self)
	{
		selectedIndex = 0;
		tabs = [[NSMutableArray alloc] init];
		controller_ = nil;
		toolbarController_ = nil;
	}
	return self;
}


// returns number of tabs in the model
- (int)count
{
	return [tabs count];
}

- (int)selectedIndex
{
	return selectedIndex;
}

// returns YES if we don't contain any tabcontents
- (BOOL)empty
{
	if ([tabs count] == 0)
		return YES;
	else
		return NO;
}

// Determines if the specified index is contained within the TabStripModel.
- (BOOL)containsIndex:(int)i
{
	return (i >= 0 && i < [self count]);
}

- (void)insertTabContents:(FRWatcherTabContentsController *)contents atIndex:(int)index bringToFront:(BOOL)fore
{
	if (contents) 
	{	
		
		if (index <= selectedIndex)
		{
			// If a tab is inserted before the current selected index,
			// then |selectedIndex| needs to be incremented.
			[self willChangeValueForKey:@"selectedIndex"];
			selectedIndex++;
			[self didChangeValueForKey:@"selectedIndex"];
		}
		
		[self willChangeValueForKey:@"tabs"];
		if (index == [self count]) 
			[tabs addObject:contents];
		else 
			[tabs insertObject:contents atIndex:index];
		[self didChangeValueForKey:@"tabs"];
		
		// tell the tab strip controler about the change
		// we don't need to tell the stip to bring it to the
		// front, that will happen if it gets selected by the model
		[controller_ insertTabWithContents:contents
								   atIndex:index
							  inForeground:NO];
		
		// tell the tab contents what its new index is
		[contents setTabIndex:index];
		
		// if required, select tab in the model, this will also tell the tab strip
		// to change selection
		if (fore)
			[self changeSelectedContentsFrom:selectedContents to:index userGesture:FALSE];
	}
}

- (void)addNewTab
{
	FRWatcherTabContentsController *new = [[FRWatcherTabContentsController alloc] initWithNibName:@"WatcherTabContents"
																						 document:delegate];
	int newPosition = [self count];
	[self insertTabContents:new atIndex:newPosition bringToFront:YES];
}

- (void)selectTabContentsAtIndex:(int)index userGesture:(BOOL)gesture
{
	if ([self containsIndex:index]) 
		[self  changeSelectedContentsFrom:selectedContents to:index userGesture:gesture];
}

- (FRWatcherTabContentsController *)getTabContentsAt:(int)index
{
	if ([self containsIndex:index])
		return [tabs objectAtIndex:index];
		
	return nil;
}

- (FRWatcherTabContentsController *)selectedTabContents
{
	// this sometimes gets called while we are closing a window with a single tab
	// (usually when dragging it, which creates a new window and closes the old after removing the tab)
	// so return nil if the selected tab doesn't exist for some reason, otherwise Bad
	// Things(tm) will happen
	@synchronized (tabs)
	{
		if (selectedIndex > ((NSInteger)[tabs count] - 1))
			return nil;
			
		return [tabs objectAtIndex:selectedIndex];
	}
}

- (void)moveTabContentsAtIndex:(int)from to:(int)toIndex select:(BOOL)select
{
	BOOL select_after_move = YES;
	
	if (from == toIndex) 
		return;
	
	FRWatcherTabContentsController *moved = [tabs objectAtIndex:from];
	[tabs removeObjectAtIndex:from];
	[tabs insertObject:moved atIndex:toIndex];
	
	// if !select_after_move, keep the same tab selected as was selected before.
	if (select_after_move || from == selectedIndex)
		selectedIndex = toIndex;
	else if (from < selectedIndex && toIndex >= selectedIndex)
		selectedIndex--;
	else if (from > selectedIndex && toIndex <= selectedIndex)
		selectedIndex++;
	
	// tell the tab strip controller that the tabs have moved
	[controller_ tabMovedWithContents:moved fromIndex:from toIndex:toIndex];
}

- (int)getIndexOfTabContents:(FRWatcherTabContentsController *)contents
{
	int ind = 0;
	
	for (FRWatcherTabContentsController *c in tabs)
	{
		if (c == contents) 
			return ind;;
		
		ind++;
	}
	
	// NSLog(@"error getting index of tab contents");
	return -1;
}

- (int)getIndexOfController:(FRWatcherTabContentsController *)cont
{
	int ind = 0;
	
	for (FRWatcherTabContentsController *c in tabs)
	{
		if (c == cont) 
			return ind;
		
		ind++;
	}
	
	// NSLog(@"error getting index of tab controller");
	return -1;
}

- (void)closeTabContentsAtIndex:(int)index
{
	// make sure we select the correct next tab
	if (index <= selectedIndex && selectedIndex != 0)
	{
		// If a tab is closed before the current selected index,
		// then |selectedIndex| needs to be decremented.
		selectedIndex--;
	}
	else if (index == 0 && selectedIndex == 0)
	{
		// if we had the first tab selected, and then closed it, 
		// select the new first tab
		selectedIndex = 0;
	}	
	
	// tell the tab strip view controller to remove the tab
	// from the strip
	[controller_ removeTabAtIndex:index];
	
	// remove the tab from the model
	FRWatcherTabContentsController *tab = [tabs objectAtIndex:index];
	[tabs removeObjectAtIndex:index];
	[tab close];
	
	// change the selection
	[self changeSelectedContentsFrom:nil
								  to:selectedIndex
						 userGesture:YES];
	
	// Send a broadcast that the number of tabs have changed.
	[[NSNotificationCenter defaultCenter] postNotificationName:kTabStripNumberOfTabsChanged
														object:self];
}

- (void)selectLastTab
{
	if ([self count] != 0) 
		[self selectTabContentsAtIndex:[self count]-1 userGesture:YES];
}

- (void)selectNextTab
{
	if (selectedIndex == [self count]-1)
		[self selectTabContentsAtIndex:0 userGesture:YES];
	else
		[self selectTabContentsAtIndex:selectedIndex+1 userGesture:YES];
}

// returns true if a tab was selected, false if the first tab was already selected
- (void)selectPreviousTab
{
	if (selectedIndex == 0) 
		[self selectTabContentsAtIndex:[self count]-1 userGesture:YES];
	else
		[self selectTabContentsAtIndex:selectedIndex-1 userGesture:YES];
}

- (void)changeSelectedContentsFrom:(FRWatcherTabContentsController *)oldContents 
								to:(int)index 
					   userGesture:(BOOL)gesture
{
	FRWatcherTabContentsController *newContents = [self getTabContentsAt:index];
	if (oldContents == newContents) 
		return;
	
	[self setSelectedContents:newContents];
	[self setSelectedIndex:index];
	
	[controller_ selectTabWithContents:newContents 
					  previousContents:oldContents 
							   atIndex:index 
						   userGesture:gesture];
}


- (FRWatcherTabContentsController *)detachTabContentsAtIndex:(int)index 
{
	if ([tabs count] == 0)
		return NULL;
	
	FRWatcherTabContentsController *removedContents = [self getTabContentsAt:index];
	
	[tabs removeObjectAtIndex:index];
	
	if ([tabs count] == 0) 
		closingAll = TRUE;
	
	// Send a broadcast that the number of tabs have changed.
	[[NSNotificationCenter defaultCenter] postNotificationName:kTabStripNumberOfTabsChanged
														object:self];
	
	return removedContents;
}

- (void)selectNextSelectedTabAfter:(int)index
{
	if ([tabs count] == 1) 
	{
		// only one tab in the window, so we don't need to select another
		return;
	}
	
	if (index == 0)
		nextSelectedIndex = 1;
	else
		nextSelectedIndex = selectedIndex-1;
	
	[self selectTabContentsAtIndex:nextSelectedIndex userGesture:YES];
}

- (MyDocument *)tearOffTabContents:(FRWatcherTabContentsController *)contents 
							  rect:(NSRect)browserRect
{	
	return [delegate createNewStripWithContents:contents windowRect:browserRect];
}

- (void)appendTabContents:(FRWatcherTabContentsController *)contents bringToFront:(BOOL)fore
{
	[self insertTabContents:contents 
					atIndex:[self count]
			   bringToFront:fore];
}

- (void)changeTabTitle:(NSString *)title forTabContents:(FRWatcherTabContentsController *)contents
{
	[controller_ setTabTitle:title forTab:[self getIndexOfController:contents]];	
}

- (void)changeNewImageCount:(int)newCount forTabContents:(FRWatcherTabContentsController *)contents
{
	[controller_ setNewImageCount:newCount forTab:[self getIndexOfController:contents]];
}

- (void)closeAllTabs
{
	NSArray *temp = [tabs copy];
	
	for (FRWatcherTabContentsController *t in temp)
	{
		int index = [tabs indexOfObject:t];
		[controller_ removeTabAtIndex:index];
		[tabs removeObjectAtIndex:index];
		[t close];
	}
}

- (void)closeAllExcept:(NSInteger)index
{
	int total = [self count];
	
	for (int i = total-1; i > -1; i--)
	{
		if (i != index)
			[self closeTabContentsAtIndex:i];
	}
}

- (void)addNewTabAtIndex:(NSInteger)index
{
	FRWatcherTabContentsController *new = 
		[[FRWatcherTabContentsController alloc] initWithNibName:@"WatcherTabContents"
													   document:delegate];
	[self insertTabContents:new atIndex:index bringToFront:YES];
}

@end
