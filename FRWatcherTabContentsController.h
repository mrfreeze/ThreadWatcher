//
//  FRWatcherTabContentsController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 30/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

// TODO: split this file up into a controller and a model

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
#import "MyDocument.h"
#import "ToolbarController.h"
#import "TabStripController.h"

#import "appscript-glue/SFGlue/SFGlue.h"
#import "appscript-glue/WKGlue/WKGlue.h"
#import "appscript-glue/FRGlue/FRGlue.h"
#import "appscript-glue/SEGlue/SEGlue.h"

#import "Growl.framework/Headers/GrowlApplicationBridge.h"

#import "openmeta/OpenMeta.h"
#import "openmeta/OpenMetaBackup.h"
#import "openmeta/OpenMetaPrefs.h"

#import "AMCollectionView.h"
#import "BWToolkitFramework.framework/Versions/A/Headers/BWGradientBox.h"

@class FRImageViewer;
@class FRAppDelegate;
@class FRIconCollectionView;
@class MyDocument;
@class ToolbarController;
@class TabStripController;


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

@interface FRWatcherTabContentsController : NSViewController <FRLinkFetcherDelegate, 
															  QLPreviewPanelDelegate, 
															  QLPreviewPanelDataSource, 
															  NSCollectionViewDelegate,
															  NSSplitViewDelegate, 
															  NSToolbarDelegate, 
															  NSWindowDelegate>
{
	// the document that contains us
	MyDocument *myDocument;
	
	// data about the thread
	NSMutableArray *postedImages;
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
	NSOperationQueue *postQueue;
	
	// timer used to check thread periodically
	NSTimer *repeatingTimer;
	
	// growl stuff
	BOOL growling;
	
	// user input
	NSString *userEnteredURL;
	
	// outlets to give the user information
	IBOutlet NSProgressIndicator *downloadBar;
	IBOutlet NSProgressIndicator *smallDownloadBar;
	IBOutlet NSTextField *statusText; // the text below the progress bars that gives user feedback
	IBOutlet NSTextField *numberOfImages; // diplays along the bottom of the 
										  // window, in the border
	
	// tags
	IBOutlet NSWindow *tagsSheet;
	IBOutlet NSTableView *tagTableView;
	
	// outlets for various objects in the nib
	IBOutlet NSView *ourView;
	IBOutlet FRIconCollectionView *ourCollectionView;
	IBOutlet NSScrollView *ourScrollView; // scroll view enclosing the collectionview
	IBOutlet FRDraggableImageView *previewViewer; // the image well view
	IBOutlet NSArrayController *theController;
	IBOutlet FRAppDelegate *applicationDelegate;
	IBOutlet NSArrayController *tagsController;
	IBOutlet NSArrayController *fullThreadController;
	IBOutlet AnimatingTabView *viewSwitcher;
	IBOutlet NSTabViewItem *iconTabItem;
	IBOutlet NSView *iconTabView;
	IBOutlet AMCollectionView *fullThreadView;
	IBOutlet BWGradientBox *bottomGradient;
	IBOutlet NSTextView *commentView;
	
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
	int tabIndex; // index of the tab in teh strip, left to right
	
	// posting
	IBOutlet NSWindow *postSheet;
	NSString *postComment;
	NSString *postSubject;
	__weak IBOutlet FRIKImageView *imageToPost;
	IBOutlet NSTextView *postCommentTextField;
	
	BOOL sheetOpen;
	BOOL downloadingThread;
	
	int changeCount;
}

// initialisation
- (id)initWithNibName:(NSString*)name
			 document:(MyDocument *)doc;

// tabs
- (void)ensureContentsVisible;
- (void)willBecomeSelectedTab;
- (void)willBecomeUnselectedTab;
- (void)didBecomeSelected;
- (void)wasHidden;
- (void)didBecomeMain;
- (void)didResignMain;

// tags methods
- (void)setTagsOfSelectedImages:(NSMutableArray *)newSet;
- (void)removeObjectFromTagsOfSelectedImagesAtIndex:(int)indexu;
- (void)insertObject:(tag *)t inTagsOfSelectedImagesAtIndex:(int)indexu;
- (IBAction)createTag:(id)sender;
- (IBAction)clearAllTags:(id)sender;
- (IBAction)clearSelectedTags:(id)sender;

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
- (void)threadDied;

- (void)close;

- (ToolbarController *)toolbarController;
- (TabStripController *)tabStripController;

- (BOOL)isLoading;

@property (readwrite, retain) MyDocument *myDocument;
@property (readwrite, retain) NSMutableArray *postedImages;
@property (readwrite, assign) FRLinkFetcher *fetcher;
@property (readwrite, retain, nonatomic) NSIndexSet *selectedIndexes;
@property (readwrite, retain, nonatomic) NSArray *selectedImages;
@property (readwrite, retain, nonatomic) NSString *threadName;
@property (readwrite, retain) NSTimer *repeatingTimer;
@property (readwrite) NSUInteger sizeOfAllFiles;
@property (readwrite, retain) NSString *threadNumber;
@property (readwrite, retain) NSString *postComment;
@property (readwrite, retain) NSString *postSubject;
@property (readwrite, retain) NSURL *boardPostURL;
@property (readwrite, retain) NSIndexSet *selectedPosts;
@property (readwrite, retain) NSMutableArray *allPosts;
@property (readwrite, retain) NSString *userEnteredURL;
@property (readwrite, assign) NSOperationQueue *operationQueue;
@property (readonly, assign) NSOperationQueue *postQueue;
@property (readwrite) BOOL sheetOpen;
@property (readwrite) BOOL downloadingThread;
@property (readwrite) int tabIndex;
@property (assign) __weak FRIKImageView *imageToPost;
@property (readwrite) int changeCount;

@property (assign) IBOutlet NSView *ourView;
@property (assign) IBOutlet NSArrayController *theController;
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
@property (readonly, assign) IBOutlet AnimatingTabView *viewSwitcher;
@property (readonly, assign) IBOutlet NSTabViewItem *iconTabItem;
@property (assign) IBOutlet NSArrayController *fullThreadController;

@end
