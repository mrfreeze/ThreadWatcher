//
//  TabStripModel.h
//  moreTabs
//
//  Created by Mr. Freeze on 24/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRWatcherTabContentsController.h"
#import "TabController.h"
#import "TabStripController.h"

@class TabStripController;
@class FRWatcherTabContentsController;

@interface TabStripModel : NSObject 
{
	NSMutableArray *objects; // array of objects representing the tabs
	
	int selectedIndex;
	int nextSelectedIndex;
	FRWatcherTabContentsController *selectedContents;
	__weak ToolbarController *toolbarController_;
	
	__weak TabStripController *controller_;
	
	BOOL closingAll;
	
	MyDocument *delegate;
}

@property (readwrite, retain) FRWatcherTabContentsController *selectedContents;
@property (readwrite, retain) __weak ToolbarController *toolbarController;
@property (readwrite) int selectedIndex;
@property (readwrite, retain) __weak TabStripController *controller;
@property (readwrite, retain) MyDocument *delegate;
@property (readonly) NSMutableArray *objects;

// the number of tabs
- (int)count;

// return true if i is the index of a tab in the model
- (BOOL)containsIndex:(int)i;

// select the tab at intex |index|.
- (void)selectTabContentsAtIndex:(int)index userGesture:(BOOL)gesture;

// returns the tab contents at index |index|
- (FRWatcherTabContentsController *)getTabContentsAt:(int)index;

// returns the index of the tab contents controller |cont|
- (int)getIndexOfController:(FRWatcherTabContentsController *)cont;

// returns the index of the currently selected tab
- (int)selectedIndex;

// close the tab at |index|
- (void)closeTabContentsAtIndex:(int)index;

// mova a tab from intex |from| to index |to|. if |select| is true, it will be selected after the move
- (void)moveTabContentsAtIndex:(int)from to:(int)toIndex select:(BOOL)select;

// returns the tab contents controller of the currently selected tab
// will return nil if there is no selected contents 
// (for example when a tab is draged out of a window with a single tab)
- (FRWatcherTabContentsController *)selectedTabContents;

// create a new tab and instert it inot the tab strip at the end
- (void)addNewTab;

// inserts |contents| at index |index|, if |fore| is true, the tab will be selected after being inserted
- (void)insertTabContents:(FRWatcherTabContentsController *)contents atIndex:(int)index bringToFront:(BOOL)fore;

// removes a tab from the model and returns it. does not remove the tab from the tab strip
// so make sure that the tab is removed from the strip after calling this
- (FRWatcherTabContentsController *)detachTabContentsAtIndex:(int)index;

// returns a new nsdocument with a single tab with contents |contents| and window frame |browserRect|
// the tab contents should be removed form the model using |detachTabContentsAtIndex:| before calling this
// although technically nothing bad should happen, it will just duplicate the tab in a new window
- (MyDocument *)tearOffTabContents:(FRWatcherTabContentsController *)contents rect:(NSRect)browserRect;

// inserts |contents| at the end of the tab strip, and selects it if |fore| is true
- (void)appendTabContents:(FRWatcherTabContentsController *)contents bringToFront:(BOOL)fore;

// returns an array of FRWatcherTabContentsController objects, which are the tabs in the model
- (NSArray *)objects;

// change the title of |contents|, lets the tab strip controller know about the change
- (void)changeTabTitle:(NSString *)title forTabContents:(FRWatcherTabContentsController *)contents;

// change the current selecte tab to be the previous tab (next tab to the left). if the first tab is selected,
// is will loop round to the last tab
- (void)selectPreviousTab;

// select the next tab to the right. if the last tab is selected, loops round and selects the first tab
- (void)selectNextTab;

// selects the tab that should next be selected after the removal of the tab at |index| (the tab to the left)
// does nothing if there is only one tab in the window
- (void)selectNextSelectedTabAfter:(int)index;

// change the new image count for the given tab - lets the tab strip controller 
// know so that the tab badge can be updated
- (void)changeNewImageCount:(int)newCount forTabContents:(FRWatcherTabContentsController *)contents;

// close all the tabs in the window. only use this when the entire window is being 
// closed, and only after it has been hidden from view
- (void)closeAllTabs;

@end
