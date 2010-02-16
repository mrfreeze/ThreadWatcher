//
//  TabStripModel.m
//  moreTabs
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "TabStripModel.h"

@interface TabStripModel ()

- (void)changeSelectedContentsFrom:(FRWatcherTabContentsController *)oldContents to:(NSInteger)index userGesture:(BOOL)gesture;

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
- (NSInteger)count
{
	return [tabs count];
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
- (BOOL)containsIndex:(NSInteger)i
{
	return (i >= 0 && i < [self count]);
}

- (void)insertTabContents:(FRWatcherTabContentsController *)contents atIndex:(NSInteger)indexu bringToFront:(BOOL)fore
{
	if (contents) 
	{	
		
		if (indexu <= selectedIndex)
		{
			// If a tab is inserted before the current selected index,
			// then |selectedIndex| needs to be incremented.
			[self willChangeValueForKey:@"selectedIndex"];
			selectedIndex++;
			[self didChangeValueForKey:@"selectedIndex"];
		}
		
		[self willChangeValueForKey:@"tabs"];
		if (indexu == [self count]) 
			[tabs addObject:contents];
		else 
			[tabs insertObject:contents atIndex:indexu];
		[self didChangeValueForKey:@"tabs"];
		
		// tell the tab strip controler about the change
		// we don't need to tell the stip to bring it to the
		// front, that will happen if it gets selected by the model
		[controller_ insertTabWithContents:contents
								   atIndex:indexu
							  inForeground:NO];
		
		// tell the tab contents what its new index is
		[contents setTabIndex:indexu];
		
		// if required, select tab in the model, this will also tell the tab strip
		// to change selection
		if (fore)
			[self changeSelectedContentsFrom:selectedContents to:indexu userGesture:FALSE];
	}
}

- (void)addNewTab
{
	FRWatcherTabContentsController *new = [[FRWatcherTabContentsController alloc] initWithNibName:@"WatcherTabContents"
																						 document:delegate];
	NSInteger newPosition = [self count];
	[self insertTabContents:new atIndex:newPosition bringToFront:YES];
}

- (void)selectTabContentsAtIndex:(NSInteger)indexu userGesture:(BOOL)gesture
{
	if ([self containsIndex:indexu]) 
		[self  changeSelectedContentsFrom:selectedContents to:indexu userGesture:gesture];
}

- (FRWatcherTabContentsController *)getTabContentsAt:(NSInteger)indexu
{
	if ([self containsIndex:indexu])
		return [tabs objectAtIndex:indexu];
		
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

- (void)moveTabContentsAtIndex:(NSInteger)from to:(NSInteger)toIndex select:(BOOL)willSelect
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

- (NSInteger)getIndexOfTabContents:(FRWatcherTabContentsController *)contents
{
	NSInteger ind = 0;
	
	for (FRWatcherTabContentsController *c in tabs)
	{
		if (c == contents) 
			return ind;;
		
		ind++;
	}
	
	// NSLog(@"error getting index of tab contents");
	return -1;
}

- (NSInteger)getIndexOfController:(FRWatcherTabContentsController *)cont
{
	NSInteger ind = 0;
	
	for (FRWatcherTabContentsController *c in tabs)
	{
		if (c == cont) 
			return ind;
		
		ind++;
	}
	
	// NSLog(@"error getting index of tab controller");
	return -1;
}

- (void)closeTabContentsAtIndex:(NSInteger)indexu
{
	// make sure we select the correct next tab
	if (indexu <= selectedIndex && selectedIndex != 0)
	{
		// If a tab is closed before the current selected index,
		// then |selectedIndex| needs to be decremented.
		selectedIndex--;
	}
	else if (indexu == 0 && selectedIndex == 0)
	{
		// if we had the first tab selected, and then closed it, 
		// select the new first tab
		selectedIndex = 0;
	}	
	
	// tell the tab strip view controller to remove the tab
	// from the strip
	[controller_ removeTabAtIndex:indexu];
	
	// remove the tab from the model
	FRWatcherTabContentsController *tab = [tabs objectAtIndex:indexu];
	[tabs removeObjectAtIndex:indexu];
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
								to:(NSInteger)indexu
					   userGesture:(BOOL)gesture
{
	FRWatcherTabContentsController *newContents = [self getTabContentsAt:indexu];
	if (oldContents == newContents) 
		return;
	
	[self setSelectedContents:newContents];
	[self setSelectedIndex:indexu];
	
	[controller_ selectTabWithContents:newContents 
					  previousContents:oldContents 
							   atIndex:indexu
						   userGesture:gesture];
}


- (FRWatcherTabContentsController *)detachTabContentsAtIndex:(NSInteger)indexu 
{
	if ([tabs count] == 0)
		return NULL;
	
	FRWatcherTabContentsController *removedContents = [self getTabContentsAt:indexu];
	
	[tabs removeObjectAtIndex:indexu];
	
	if ([tabs count] == 0) 
		closingAll = TRUE;
	
	// Send a broadcast that the number of tabs have changed.
	[[NSNotificationCenter defaultCenter] postNotificationName:kTabStripNumberOfTabsChanged
														object:self];
	
	return removedContents;
}

- (void)selectNextSelectedTabAfter:(NSInteger)indexu
{
	if ([tabs count] == 1) 
	{
		// only one tab in the window, so we don't need to select another
		return;
	}
	
	if (indexu == 0)
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

- (void)changeNewImageCount:(NSInteger)newCount forTabContents:(FRWatcherTabContentsController *)contents
{
	[controller_ setNewImageCount:newCount forTab:[self getIndexOfController:contents]];
}

- (void)closeAllTabs
{
	NSArray *temp = [tabs copy];
	
	for (FRWatcherTabContentsController *t in temp)
	{
		NSInteger indexu = [tabs indexOfObject:t];
		[controller_ removeTabAtIndex:indexu];
		[tabs removeObjectAtIndex:indexu];
		[t close];
	}
}

- (void)closeAllExcept:(NSInteger)indexu
{
	NSInteger total = [self count];
	
	for (NSInteger i = total-1; i > -1; i--)
	{
		if (i != indexu)
			[self closeTabContentsAtIndex:i];
	}
}

- (void)addNewTabAtIndex:(NSInteger)indexu
{
	FRWatcherTabContentsController *new = 
		[[FRWatcherTabContentsController alloc] initWithNibName:@"WatcherTabContents"
													   document:delegate];
	[self insertTabContents:new atIndex:indexu bringToFront:YES];
}

@end
