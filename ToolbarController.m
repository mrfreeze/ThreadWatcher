//
//  ToolbarController.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 30/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "toolbar_controller.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "ToolbarController.h"

@interface ToolbarController ()
- (void)setButtonStateForTab:(FRWatcherTabContentsController *)tabController;
@end

@implementation ToolbarController

@synthesize controller = controller_;
@synthesize urlString;

- (id)initWithMyDocument:(MyDocument *)document
{
	self = [super initWithNibName:@"Toolbar" bundle:[NSBundle mainBundle]];
	if (self)
	{
		myDocument_ = document;
		controller_ = nil;
	}
	return self;
}

- (void)setupInitialStates
{
	[saveAllButton setEnabled:NO];
	[saveSelectedButton setEnabled:NO];
	[postReplyButton setEnabled:NO];
	[[[self view] window] makeFirstResponder:urlTextBox];
	[watchCheckBox setEnabled:NO];
}

// ======================================================================
// methods called by the selected tab contents controller to update us when something changes

// the thread has been found and is about to be downlaoded
// at theis point we can enable the reply button
- (void)threadFound
{
	[postReplyButton setEnabled:YES];
	[watchCheckBox setEnabled:YES];
}

// an image was downloaded, so the save all button can be enable
- (void)imageWasDownloaded
{
	if (![[self controller] sheetOpen])
		[saveAllButton setEnabled:YES];
}

- (void)fetchedAllImages
{
	[goButton setImage:[NSImage imageNamed:NSImageNameRefreshTemplate]];
	[goButton setAction:@selector(go:)];
	[goLabel setTitleWithMnemonic:@"Go"];
}

// there was a change to the selction. if some images are selected
// then selectionExists will be true. in which case enable the saveselected button
- (void)imagesSelected:(BOOL)selectionExists
{
	if (selectionExists) 
		[saveSelectedButton setEnabled:YES];
	else 
		[saveSelectedButton setEnabled:NO];
}

- (void)startedWatching
{
	[watchSpinner startAnimation:self];
}

- (void)stoppedWatching
{
	[watchSpinner stopAnimation:self];
	[watchCheckBox setState:NSOffState];
}

// programatically start the watcher
- (void)startWatcher
{
	[watchCheckBox setState:NSOnState];
	[self watcherToggled:watchCheckBox];
}

// Run when a sheet gets closed so we can re-enable the toolbar buttons
- (void)sheetClosed
{
	[self setButtonStateForTab:[self controller]];
}

- (void)postingReply
{
	[postSpinner startAnimation:self];
	[postReplyButton setEnabled:NO];
}

- (void)replyWasSent
{
	[postSpinner stopAnimation:self];
	if (![[self controller] sheetOpen])
		[postReplyButton setEnabled:YES];
}

- (void)threadDied
{
	[postReplyButton setEnabled:NO];
	[self stoppedWatching];
	[watchCheckBox setEnabled:NO];
}

- (void)changeToIconView
{
	[viewSwitchButton setSelectedSegment:0];
}

- (void)changeToFullThreadView
{
	[viewSwitchButton setSelectedSegment:1];
}

- (void)focusURLInputField
{
	[[[self view] window] makeFirstResponder:urlTextBox];
}

- (void)startedFetcher
{
	[goButton setImage:[NSImage imageNamed:NSImageNameStopProgressTemplate]];
	[goButton setAction:@selector(cancel:)];
	[urlTextBox setEnabled:NO];
	[goLabel setTitleWithMnemonic:@"Cancel"];
}

// =======================================================================================
// A bunch of actions that are triggered by the  buttons in the toolbar and sent to
// the selected tab.

- (IBAction)go:(id)sender
{
	[[self controller] startFetcher:sender];
}

- (IBAction)saveFiles:(id)sender
{
	[[self controller] saveFiles:sender];
}

- (IBAction)toggleTimer:(id)sender
{
	[[self controller] toggleTimer:sender];
}

- (IBAction)saveSelected:(id)sender
{
	[[self controller] saveSelected:sender];
}

- (IBAction)cancel:(id)sender
{
	[[self controller] cancel:sender];
}

- (IBAction)changeViewTypeClicked:(id)sender
{
	[[self controller] changeViewClicked:sender];
}

- (IBAction)postReply:(id)sender
{
	[[self controller] showPostSheet:sender];
}

- (IBAction)watcherToggled:(id)sender
{
	[[self controller] toggleTimer:sender];
}

// =========================================================================
// Changing tabs

- (void)changeToNewTab:(FRWatcherTabContentsController *)newController
{	
	[self unbind:@"urlString"];
	[self setController:newController];
	
	// Now we need to check the status of all the toolbar items to check they are
	// correct for the new tab contents
	[self setButtonStateForTab:newController];

	// Bind the text field contents to the string in the contents controller
	// that holds the entered url.
	[self bind:@"urlString" 
	  toObject:controller_ 
   withKeyPath:@"userEnteredURL" 
	   options:nil];
}

// Find out what this tab is doing so we can enable/diable and
// set the icons and actions on the buttons and the various 
// spinners to the correct states
- (void)setButtonStateForTab:(FRWatcherTabContentsController *)tabController
{
	[urlTextBox setEnabled:YES]; // text box enabled by default unless
								 // we have fetched a thread in this tab,
								 // in which case it will be disabled below
	
	if ([tabController sheetOpen]) 
		[self sheetOpened];
	else 
	{
		// Does the tab have any images downlaoded?
		if ([[tabController postedImages] count] == 0) 
		{
			[saveSelectedButton setEnabled:NO];
			[saveAllButton setEnabled:NO];
		}
		else 
		{
			// there are downloaded images in this tab
			[saveAllButton setEnabled:YES];
			[urlTextBox setEnabled:NO];
			if ([[tabController selectedImages] count] > 0) 
				[saveSelectedButton setEnabled:YES];
		}		
		
		if ([tabController boardPostURL]) 
		{
			// we have the posting url, so enable the post button
			[postReplyButton setEnabled:YES];
			[watchCheckBox setEnabled:YES];
			[urlTextBox setEnabled:NO];
		}
		else
		{
			[postReplyButton setEnabled:NO];
			[watchCheckBox setEnabled:NO];
		}
			
		if ([[tabController operationQueue] operationCount] > 0)
		{
			// curently downloading form the thread
			[goButton setImage:[NSImage imageNamed:NSImageNameStopProgressTemplate]];
			[goButton setAction:@selector(cancel:)];
			[goLabel setTitleWithMnemonic:@"Cancel"];
		}
		else 
		{
			// idle
			[goButton setImage:[NSImage imageNamed:NSImageNameRefreshTemplate]];
			[goButton setAction:@selector(go:)];
			[goLabel setTitleWithMnemonic:@"Go"];
		}
		
		// See if a post is being sent
		if ([[tabController postQueue] operationCount] > 0)
		{
			[postSpinner startAnimation:self];
			[postReplyButton setEnabled:NO];
		}
		else 
			[postSpinner stopAnimation:self];
		
		// Make sure the view switcher button is in the correct state
		if ([[tabController viewSwitcher] selectedTabViewItem] == 
			[tabController iconTabItem])
			[viewSwitchButton setSelectedSegment:0];
		else 
			[viewSwitchButton setSelectedSegment:1];
		
		// Are we watching the thread?
		if ([tabController repeatingTimer]) 
		{
			[watchSpinner startAnimation:self];
			[watchCheckBox setState:NSOnState];
		}
		else 
		{
			[watchSpinner stopAnimation:self];
			[watchCheckBox setState:NSOffState];
		}
		
		[quicklookButton setEnabled:YES];
		[viewSwitchButton setEnabled:YES];
		[goButton setEnabled:YES];
	}
}

// run when there is a sheet open for the tab,
// disables the toolbar buttons
- (void)sheetOpened
{
	[viewSwitchButton setEnabled:NO];
	[urlTextBox setEnabled:NO];
	[goButton setEnabled:NO];
	[quicklookButton setEnabled:NO];
	[saveAllButton setEnabled:NO];
	[saveSelectedButton setEnabled:NO];
	[postReplyButton setEnabled:NO];
	[watchCheckBox setEnabled:NO];
}

@end
