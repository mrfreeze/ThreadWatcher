//
//  FRDumpDocument.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 08/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "FRLocalImage.h"

// appscript
#import "appscript-glue/SFGlue/SFGlue.h"
#import "appscript-glue/WKGlue/WKGlue.h"
#import "appscript-glue/FRGlue/FRGlue.h"
#import "appscript-glue/SEGlue/SEGlue.h"


@interface FRDumpDocument : NSDocument <NSSplitViewDelegate, QLPreviewPanelDelegate, QLPreviewPanelDataSource>
{
	// data
	NSMutableArray *imageURLs;
	NSArray *selectedImages;
	IBOutlet NSArrayController *imagesController;
	NSIndexSet *selectedImageIndexes;
	NSOperationQueue *postQueue;
	NSURL *boardPostURL;
	int numberPosted; // number of images posted so far
	int sizeOfAllFiles;
	
	BOOL appendNumbers;
	BOOL createNewThreads;
	BOOL canStart;
	
	// growl
	BOOL growling;
	
	// user input
	IBOutlet NSPopUpButton *boardSelection;
	IBOutlet NSTabView *threadTypeTabView;
	IBOutlet NSTabViewItem *newThreadTab;
	IBOutlet NSTabViewItem *existingThreadTab;
	IBOutlet NSTextField *urlTextBox;
	NSString *comment;
	NSString *subject;
	IBOutlet NSButton *startButton;
	IBOutlet NSButton *pauseButton;
	
	// views/windows
	IBOutlet NSSplitView *splitView;
	IBOutlet NSView *threadTypeContainer;
	IBOutlet NSWindow *theWindow;
	IBOutlet NSTableView *fileTableView;
	IBOutlet NSSegmentedControl *addRemoveButtons;
	QLPreviewPanel *previewPanel;
	
	// status feedback
	IBOutlet NSTextField *feedbackText;
	IBOutlet NSProgressIndicator *spinner;
	IBOutlet NSProgressIndicator *uploadBar;
	IBOutlet NSProgressIndicator *overallProgressIndicator;
	IBOutlet NSTextField *numberOfImages;
	
	// appscript stuff
	SFApplication *safari;
	WKApplication *webkit;
	FRApplication *firefox;
	SEApplication *systemEvents;
	
	// rows that are being dragged/dropped
	NSIndexSet *_moveRows;
}

// user input action methods
- (IBAction)startDumping:(id)sender;
- (IBAction)cancelDump:(id)sender;
- (IBAction)addRemoveClicked:(id)sender;
- (IBAction)resumeDump:(id)sender;
- (IBAction)pauseDump:(id)sender;
- (IBAction)fetchBrowserURL:(id)sender;

// user feedback
- (void)updateUIWithString:(NSString *)string;
- (void)imagePosted;

// messages from the FRUploadOperation
- (BOOL)enqueueNextImageWithDelay:(int)delay threadNumber:(NSString *)theThread;

// methods to allow drags into table view
- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)operation;
- (NSDragOperation)tableView:(NSTableView*)tv 
				validateDrop:(id <NSDraggingInfo>)info 
				 proposedRow:(int)row 
	   proposedDropOperation:(NSTableViewDropOperation)op;


@property (readwrite, copy) NSString *comment;
@property (readwrite, copy) NSString *subject;
@property (readonly) NSMutableArray *imageURLs;
@property (readonly, assign) NSWindow *theWindow;
@property (readwrite) BOOL canStart;
@property (readwrite) BOOL createNewThreads;
@property (readonly) NSOperationQueue *postQueue;
@property (readwrite, copy) NSURL *boardPostURL;
@property (readwrite) int numberPosted;
@property (readwrite, retain) NSArray *selectedImages;
@property (readwrite, retain) NSIndexSet *selectedImageIndexes;
@property (readwrite) int sizeOfAllFiles;
@property (readonly, retain) IBOutlet NSArrayController *imagesController;

@end
