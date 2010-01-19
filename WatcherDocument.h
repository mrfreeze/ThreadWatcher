//
//  WatcherDocument.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 09/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

// for defaults strings see FRPreferenceController.m

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

#import "FRAppDelegate.h"
#import "FRpostedImage.h"
#import "FRLinkFetcher.h"
#import "tag.h"
#import "FRCollectionItemView.h"
#import "FRDraggableImageView.h"
#import "FRIKImageView.h"
#import "AnimatingTabView.h"

#import "appscript-glue/SFGlue/SFGlue.h"
#import "appscript-glue/WKGlue/WKGlue.h"
#import "appscript-glue/FRGlue/FRGlue.h"
#import "appscript-glue/SEGlue/SEGlue.h"

#import "Growl.framework/Headers/GrowlApplicationBridge.h"

#import "openmeta/OpenMeta.h"
#import "openmeta/OpenMetaBackup.h"
#import "openmeta/OpenMetaPrefs.h"

#import "AMCollectionView.h"

@class FRImageViewer;
@class FRAppDelegate;
@class FRIconCollectionView;

// -------------------------------------------------
extern NSString *const uploadedResponse;
extern NSString *const noImageResponse;
extern NSString *const duplicateResponse;
extern NSString *const floodResponse;
extern NSString *const limitResponse;
extern NSString *const abnormalReplyResponse;
extern NSString *const fourohfourResponse;
extern NSString *const noThreadResponse;
extern NSString *const bannedResponse;
extern NSString *const tooLongResponse;
extern NSString *const largeFileResponse;
extern NSString *const maliciousResponse;
extern NSString *const highResResponse;
extern NSString *const failedResponse;

// -------------------------------------------------------

@interface WatcherDocument : NSDocument <FRLinkFetcherDelegate, QLPreviewPanelDelegate, 
									QLPreviewPanelDataSource, NSCollectionViewDelegate,
									NSSplitViewDelegate, NSToolbarDelegate, NSWindowDelegate>
{
	// data about the thread
	NSMutableArray *links;
	NSMutableArray *allPosts;
	NSString *threadNumber;
	NSString *threadName;
	NSUInteger sizeOfAllFiles;
	NSString *tempDirPath;
	NSURL *boardPostURL; // url to post to the board
	unsigned int numberBeforeDownload; // the number of images already downloaded
									   // before the current download operation
	unsigned int newImages;
	unsigned int numberPostsBeforeDownload;
	
	// information about selected images
	NSIndexSet *selectedPosts;
	NSArray *selectedImages;
	NSIndexSet *selectedIndexes;
	NSMutableArray *tagsOfSelectedImages;
	BOOL selecting;
	NSMutableSet *removedTags;	// tags that have been removed from the currently
								// selected images.
								// we need this since we don't know if a missing tag was removed or just
								// didn't apply to other images when we update the tag data (only 
								// tags that are shared by all selected images are kept in tagsOfSelectedImages)
	
	// operation queues and operations, first queue for the
	// file downloads, second for fetching image from disk when selected
	NSOperationQueue *operationQueue;
	NSOperationQueue *prevQueue;
	FRLinkFetcher *fetcher;
	
	// timer used to check thread periodically
	NSTimer *repeatingTimer;
	
	// growl stuff
	BOOL growling;
	
	// user input
	IBOutlet NSTextField *URLInput;
	IBOutlet NSButton *goButton;
	IBOutlet NSButton *saveSelectedButton;
	IBOutlet NSButton *saveButton;
	IBOutlet NSButton *timerToggleCheckBox;
	IBOutlet NSSegmentedControl *viewToggle;
	
	// toolbar items
	NSToolbar *theToolbar;
	IBOutlet NSView *urlTextBoxView;
	NSToolbarItem *urlToolbar;
	NSToolbarItem *watchingToolbarItem;
	IBOutlet NSView *watchingToolbarView;
	NSToolbarItem *goToolbarButton;
	IBOutlet NSView *goToolbarView;
	NSToolbarItem *saveToolbarButton;
	IBOutlet NSView *saveToolbarView;
	NSToolbarItem *saveAllToolbarButton;
	IBOutlet NSView *saveAllToolbarView;
	NSToolbarItem *quicklookToolbarItem;
	IBOutlet NSView *quicklookToolbarView;
	NSToolbarItem *postReplyToolbarItem;
	IBOutlet NSView *postReplyToolbarView;
	NSToolbarItem *viewSwitcherToolbarItem;
	IBOutlet NSView *viewSwitcherToolbarView;
	
	// outlets to give the user information
	IBOutlet NSProgressIndicator *progressSpinner; // part of the goTB toolbar item
	IBOutlet NSProgressIndicator *timerSpinner; //  part of the watchingTB toolbar item
	IBOutlet NSProgressIndicator *replySpinner; // spins when a reply is being posted
	IBOutlet NSProgressIndicator *downloadBar;
	IBOutlet NSProgressIndicator *smallDownloadBar;
	IBOutlet NSTextField *statusText; // the text below the progress bars that gives user feedback
	IBOutlet NSTextField *numberOfImages; // diplays along the bottom of the 
										  // window, in the border
	
	// tags
	IBOutlet NSWindow *tagsSheet;
	IBOutlet NSTableView *tagTableView;
	
	// outlets for various objects in the nib
	IBOutlet NSWindow *theWindow;
	IBOutlet FRIconCollectionView *ourCollectionView;
	IBOutlet NSScrollView *ourScrollView; // scroll view enclosing the collectionview
	IBOutlet FRDraggableImageView *previewViewer; // the image well view
	IBOutlet NSArrayController *theController;
	IBOutlet FRAppDelegate *applicationDelegate;
	IBOutlet NSArrayController *tagsController;
	IBOutlet AnimatingTabView *viewSwitcher;
	IBOutlet NSTabViewItem *iconTabItem;
	IBOutlet NSView *iconTabView;
	IBOutlet AMCollectionView *fullThreadView;
	
	// appscript stuff
	SFApplication *safari;
	WKApplication *webkit;
	FRApplication *firefox;
	SEApplication *systemEvents;
	
	//quicklook stuff
	QLPreviewPanel *previewPanel;
	
	// scripting
	BOOL willSave;
	BOOL scriptSaveSheet;
	NSURL *scriptSaveLocation;
	NSMutableArray *scriptTags;
	NSNumber *scriptRating;
	
	// posting
	IBOutlet NSWindow *postSheet;
	NSString *postComment;
	NSString *postSubject;
	IBOutlet FRIKImageView *imageToPost;
	IBOutlet NSButton *postButton;
	IBOutlet NSTextView *commentView;
}

// tags methods
- (void)setTagsOfSelectedImages:(NSMutableArray *)newSet;
- (void)removeObjectFromTagsOfSelectedImagesAtIndex:(int)indexu;
- (void)insertObject:(tag *)t inTagsOfSelectedImagesAtIndex:(int)indexu;
- (IBAction)createTag:(id)sender;

// post reply methods
- (IBAction)showPostSheet:(id)sender;
- (IBAction)endPostSheet:(id)sender;
- (IBAction)postReply:(id)sender;
- (IBAction)clearImageToPost:(id)sender;
   
// main action methods
- (IBAction)startFetcher:(id)sender;
- (IBAction)saveFiles:(id)sender;
- (IBAction)toggleTimer:(id)sender;
- (IBAction)fetchBrowserURL:(id)sender;
- (IBAction)saveSelected:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)showTagsSheet:(id)sender;
- (IBAction)endTagsSheet:(id)sender;
- (IBAction)addRemoveTagWasClicked:(id)sender;
- (IBAction)changeViewClicked:(id)sender;

// view switching
- (void)switchToIconView:(id)sender;
- (void)switchToFullThreadView:(id)sender;

// scripting commands
- (void)applescriptGetURL:(NSScriptCommand *)command;
- (void)scriptSaveAll:(NSScriptCommand *)command;

// linkFetcher delegate methods so the 
// linkFetcher can return images and update the UI
- (void)loadingPage;
- (void)pageWasLoaded:(NSNumber *)max;
- (void)fetchedAllImages;
- (void)addNewImage:(id)i;
- (void)setWindowNameTo:(NSString *)n;
- (void)returnedError:(NSString *)errorMessage;
- (BOOL)wantsAnimation;
- (void)wasCancelled;


@property (readwrite, retain) NSMutableArray *links;
@property (readwrite, assign) FRLinkFetcher *fetcher;
@property (readwrite, retain, nonatomic) NSIndexSet *selectedIndexes;
@property (readwrite, retain, nonatomic) NSArray *selectedImages;
@property (readwrite, retain, nonatomic) NSString *threadName;
@property (retain) NSTimer *repeatingTimer;
@property (readwrite) NSUInteger sizeOfAllFiles;
@property (readwrite, retain) NSString *threadNumber;
@property (readwrite, retain) NSString *postComment;
@property (readwrite, retain) NSString *postSubject;
@property (readwrite, retain) NSURL *boardPostURL;
@property (readwrite, retain) NSIndexSet *selectedPosts;
@property (readwrite, retain) NSMutableArray *allPosts;

@property (assign) IBOutlet NSWindow *theWindow;
@property (assign) IBOutlet NSArrayController *theController;
@property (assign) IBOutlet NSView *urlTextBoxView;
@property (assign) IBOutlet NSView *watchingToolbarView;
@property (assign) IBOutlet NSView *goToolbarView;
@property (assign) IBOutlet NSView *saveToolbarView;
@property (assign) IBOutlet NSView *saveAllToolbarView;
@property (assign) IBOutlet NSView *quicklookToolbarView;
@property (assign) IBOutlet FRIconCollectionView *ourCollectionView;
@property (assign) IBOutlet FRAppDelegate *applicationDelegate;
@property (assign) IBOutlet NSScrollView *ourScrollView;
@property (assign) IBOutlet NSWindow *tagsSheet;
@property (assign) IBOutlet NSTableView *tagTableView;
@property (assign) IBOutlet NSArrayController *tagsController;
@property (assign) IBOutlet FRDraggableImageView *previewViewer;
@property (assign) IBOutlet NSTextField *numberOfImages;
@property (assign) IBOutlet NSTextField *statusText;
@property (assign) IBOutlet NSProgressIndicator *downloadBar;
@property (assign) IBOutlet NSProgressIndicator *timerSpinner;
@property (assign) IBOutlet NSProgressIndicator *progressSpinner;
@property (assign) IBOutlet NSButton *saveSelectedButton;
@property (assign) IBOutlet NSButton *saveButton;
@property (assign) IBOutlet NSTextField *URLInput;

@end
