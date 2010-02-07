//
//  ToolbarController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 30/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "toolbar_controller.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import "MyDocument.h"
#import "FRWatcherTabContentsController.h"

@class MyDocument;
@class FRWatcherTabContentsController;

@interface ToolbarController : NSViewController
{
	MyDocument *myDocument_;
	
	// the contents controller for the currently selected tab 
	FRWatcherTabContentsController *controller_;
	
	// Tracking area for mouse enter/exit/moved in the toolbar.
	NSTrackingArea *trackingArea_;
	
	NSString *urlString; // the string being displayed in the url text field
	
	IBOutlet NSSegmentedControl *viewSwitchButton;
	IBOutlet NSTextField *urlTextBox;
	IBOutlet NSButton *goButton;
	IBOutlet NSProgressIndicator *goSpinner;
	IBOutlet NSButton *quicklookButton;
	IBOutlet NSButton *saveAllButton;
	IBOutlet NSButton *saveSelectedButton;
	IBOutlet NSButton *postReplyButton;
	IBOutlet NSProgressIndicator *postSpinner;
	IBOutlet NSButton *watchCheckBox;
	IBOutlet NSProgressIndicator *watchSpinner;

}

@property (readwrite, retain) FRWatcherTabContentsController *controller;
@property (readwrite, retain) NSString *urlString;

// initialise with document.
- (id)initWithMyDocument:(MyDocument *)document;

// sets the buttons to their initial states (anything that needs a thread to be loaded will be disabled)
- (void)setupInitialStates;

// inform the toolbar that a thread has been found, so the post reply and watch buttons
// can be enabled
- (void)threadFound;

// tell the toolbar that an image was downloaded, so the saveall button can be enabled
- (void)imageWasDownloaded;

// inform toolbar that all images downloaded; go button is reset
- (void)fetchedAllImages;

// tell toolbar that the image selection changed. if |selectionExists| is true then
// the save selected is enabled, otherwise it is disabled
- (void)imagesSelected:(BOOL)selectionExists;

// tell the toolbar to make the url bar the first responder
- (void)focusURLInputField;

// actions forwarded to the tab controller, after setting buttons to correct states
- (IBAction)go:(id)sender;
- (IBAction)saveFiles:(id)sender;
- (IBAction)toggleTimer:(id)sender;
- (IBAction)saveSelected:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)changeViewTypeClicked:(id)sender;
- (IBAction)postReply:(id)sender;

// change the tab the toolbar is displaying
- (void)changeToNewTab:(FRWatcherTabContentsController *)newController;

// tell the toolbar if a thread is being watched or not
- (void)startedWatching;
- (void)stoppedWatching;
- (void)watcherStarted; // changes the state of the watch check box, if watching is enabled by a script

// inform the toolbar about the status of posts being sent
- (void)postingReply;
- (void)replyWasSent;

// tell the toolbar that the view type changed
- (void)changeToIconView;
- (void)changeToFullThreadView;

// disable toolbar when there is an open sheet
- (void)sheetOpened;
- (void)sheetClosed;

// tell the toolbar that the fetcher was started
- (void)startedFetcher;

@end
