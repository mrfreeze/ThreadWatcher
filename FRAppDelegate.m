//
//  FRAppDelegate.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 11/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import "FRAppDelegate.h"
#import "FRPreferenceController.h"
#include <QuickLook/QuickLook.h>
#import "FRPostedValueTransformer.h"
#import "MyDocument.h"
#import "FRPreferenceController.h"
#import "TabbedWindowController.h"
#import "TabStripController.h"


@implementation FRAppDelegate

// make sure any value transformers are 
// created before the nib loads and set up out user defaults
+ (void)initialize
{
	[super initialize];
	[self initialiseValueTransformers];
	
	// set up standard defaults
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	[defaultValues setObject:[NSNumber numberWithBool:NO] forKey:FRAnimatedThumbsKey];
	[defaultValues setObject:[NSNumber numberWithBool:NO] forKey:FRResaveKey];
	[defaultValues setObject:[NSNumber numberWithDouble:2.0] forKey:FRIntervalKey];
	[defaultValues setObject:[NSString stringWithString:@"@"] forKey:FRCommentTagPrefix];
	[defaultValues setObject:[NSNumber numberWithBool:NO] forKey:FRFinderCommentKey];
	[defaultValues setObject:[NSString stringWithString:@""] forKey:FRPostName];
	[defaultValues setObject:[NSString stringWithString:@""] forKey:FRPostEmail];
	[defaultValues setObject:[NSNumber numberWithInt:0] forKey:FRDumpBoard];
	[defaultValues setObject:[NSString stringWithString:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/532.9+ (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10"] forKey:FRUserAgent];
	[defaultValues setObject:[NSString stringWithString:@"/"] forKey:FRLastSaveLocation];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:FRShowCloseWindowAlert];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:FRShowQuitWindowAlert];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	[GrowlApplicationBridge setGrowlDelegate:self];
}

- (id)init
{
	self = [super init];
	if (self)
	{
		[GrowlApplicationBridge setGrowlDelegate:self];
		lastGrowlTime = [NSDate dateWithTimeIntervalSinceNow:0.0];
	}
	return self;
}

+ (void)initialiseValueTransformers
{
	doubleToMins *dToMins = [[doubleToMins alloc] init];
	[NSValueTransformer setValueTransformer:dToMins forName:@"doubleToMins"];
	
	FRPostedValueTransformer *BOOLtoPostedImage = [[FRPostedValueTransformer alloc] init];
	[NSValueTransformer setValueTransformer:BOOLtoPostedImage forName:@"ImageFromBOOL"];
	
}

- (void)awakeFromNib
{
	NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self
						   selector:@selector(tabsChanged:)
							   name:kTabStripNumberOfTabsChanged
							 object:nil];
	[notificationCenter addObserver:self
						   selector:@selector(windowLayeringDidChange:)
							   name:NSWindowDidBecomeKeyNotification
							 object:nil];
	[notificationCenter addObserver:self
						   selector:@selector(windowLayeringDidChange:)
							   name:NSWindowDidResignKeyNotification
							 object:nil];
	[notificationCenter addObserver:self
						   selector:@selector(windowLayeringDidChange:)
							   name:NSWindowDidBecomeMainNotification
							 object:nil];
	[notificationCenter addObserver:self
						   selector:@selector(windowLayeringDidChange:)
							   name:NSWindowDidResignMainNotification
							 object:nil];
}

// toggle quicklook panel
- (IBAction)togglePreviewPanel:(id)previewPanel
{
    if ([QLPreviewPanel sharedPreviewPanelExists] && [[QLPreviewPanel sharedPreviewPanel] isVisible]) 
        [[QLPreviewPanel sharedPreviewPanel] orderOut:nil];
	else 
        [[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:nil];
}

// open pref window
- (IBAction)showPreferencePanel:(id)sender
{
	if (!preferenceController) 
		preferenceController = [[FRPreferenceController alloc] init];
	
	[preferenceController showWindow:self];
}

// recieved clickback from growl
- (void)growlNotificationWasClicked:(id)clickContext
{
	/* 
	 * because clickback from growl seems to send 
	 * the message to us twice, we will ignore messages that are within
	 * the space of 4 seconds of each other. 
	 */
	
	NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0];
	if ([now timeIntervalSinceDate:lastGrowlTime] > 4.0) 
	{
		if (![[NSString stringWithFormat:@"%@", [clickContext class]] isEqual:@"NSCFString"]) 
		{
			// clickback came from a post failed notification (from attempted post in watcher)
			FRWatcherTabContentsController **ap = 
					(FRWatcherTabContentsController **)[clickContext bytes]; // yo dawg, i heard you like pointers...
			FRWatcherTabContentsController *theTab = *ap;
			
			MyDocument *document = [theTab myDocument];
			
			// bring the window to the front
			[document showWindows];
			
			// select the correct tab
			int tabIndex = [[document tabStripModel] getIndexOfController:theTab];
			[[document tabStripModel] selectTabContentsAtIndex:tabIndex userGesture:YES];
			
			// open the reply sheet
			[theTab showPostSheet:self];
		}
		else
		{
			// clickback came from a new thread notification
			// so it's a link to the new thread
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:clickContext]];
		}
	}
	
	lastGrowlTime = [NSDate dateWithTimeIntervalSinceNow:0.0];
}

// Helper routine to get the window controller if the key window is a tabbed
// window, or nil if not. Examples of non-tabbed windows are "about" or
// "preferences".
- (TabbedWindowController *)keyWindowTabController 
{
	NSWindowController *keyWindowController =
	[[NSApp keyWindow] windowController];
	if ([keyWindowController isKindOfClass:[TabbedWindowController class]])
		return (TabbedWindowController *)keyWindowController;
	
	return nil;
}

// Helper routine to get the window controller if the main window is a tabbed
// window, or nil if not. Examples of non-tabbed windows are "about" or
// "preferences".
- (TabbedWindowController *)mainWindowTabController 
{
	NSWindowController *mainWindowController =
	[[NSApp mainWindow] windowController];
	if ([mainWindowController isKindOfClass:[TabbedWindowController class]])
		return (TabbedWindowController *)mainWindowController;
	
	return nil;
}

// If the window has tabs, make "close window" be cmd-shift-w, otherwise leave
// it as the normal cmd-w. Capitalization of the key equivalent affects whether
// the shift modifer is used.
- (void)adjustCloseWindowMenuItemKeyEquivalent:(BOOL)inHaveTabs 
{
	[closeWindowMenuItem_ setKeyEquivalent:(inHaveTabs ? @"W" : @"w")];
	[closeWindowMenuItem_ setKeyEquivalentModifierMask:NSCommandKeyMask];
}

// If the window has tabs, make "close tab" take over cmd-w, otherwise it
// shouldn't have any key-equivalent because it should be disabled.
- (void)adjustCloseTabMenuItemKeyEquivalent:(BOOL)hasTabs 
{
	if (hasTabs) 
	{
		[closeTabMenuItem_ setKeyEquivalent:@"w"];
		[closeTabMenuItem_ setKeyEquivalentModifierMask:NSCommandKeyMask];
	} 
	else 
	{
		[closeTabMenuItem_ setKeyEquivalent:@""];
		[closeTabMenuItem_ setKeyEquivalentModifierMask:0];
	}
}

// Explicitly remove any command-key equivalents from the close tab/window
// menus so that nothing can go haywire if we get a user action during pending
// updates.
- (void)clearCloseMenuItemKeyEquivalents 
{
	[closeTabMenuItem_ setKeyEquivalent:@""];
	[closeTabMenuItem_ setKeyEquivalentModifierMask:0];
	[closeWindowMenuItem_ setKeyEquivalent:@""];
	[closeWindowMenuItem_ setKeyEquivalentModifierMask:0];
}

// See if we have a window with tabs open, and adjust the key equivalents for
// Close Tab/Close Window accordingly
- (void)fixCloseMenuItemKeyEquivalents 
{
	TabbedWindowController *tabController = [self keyWindowTabController];
	if (!tabController && ![NSApp keyWindow])
	{
		// There might be a small amount of time where there is no key window,
		// so just use our main browser window if there is one.
		tabController = [self mainWindowTabController];
	}
	BOOL windowWithMultipleTabs =
	(tabController && [tabController numberOfTabs] > 1);
	[self adjustCloseWindowMenuItemKeyEquivalent:windowWithMultipleTabs];
	[self adjustCloseTabMenuItemKeyEquivalent:windowWithMultipleTabs];
	fileMenuUpdatePending_ = NO;
}

// Fix up the "close tab/close window" command-key equivalents. We do this
// after a delay to ensure that window layer state has been set by the time
// we do the enabling. This should only be called on the main thread, code that
// calls this (even as a side-effect) from other threads needs to be fixed.
- (void)delayedFixCloseMenuItemKeyEquivalents 
{
	if (!fileMenuUpdatePending_) 
	{
		// The OS prefers keypresses to timers, so it's possible that a cmd-w
		// can sneak in before this timer fires. In order to prevent that from
		// having any bad consequences, just clear the keys combos altogether. They
		// will be reset when the timer eventually fires.
		[self clearCloseMenuItemKeyEquivalents];
		[self performSelectorOnMainThread:@selector(fixCloseMenuItemKeyEquivalents)
							   withObject:nil
							waitUntilDone:NO];
		fileMenuUpdatePending_ = YES;
	}
}

// Called when the number of tabs changes in one of the browser windows. The
// object is the tab strip controller, but we don't currently care.
- (void)tabsChanged:(NSNotification*)notify 
{
	// We don't need to do this on a delay, as in the method above, because the
	// window layering isn't changing. As a result, there's no chance that a
	// different window will sneak in as the key window and cause the problems
	// we hacked around above by clearing the key equivalents.
	[self fixCloseMenuItemKeyEquivalents];
}

// Called when we get a notification about the window layering changing to
// update the UI based on the new main window.
- (void)windowLayeringDidChange:(NSNotification*)notify 
{
	[self delayedFixCloseMenuItemKeyEquivalents];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
	// check that none of the windows have open sheets
	NSArray *windows = [NSApp windows];
	for (NSWindow *w in windows)
	{
		id winController = [w windowController];
		if ([winController class] == [TabbedWindowController class]) 
		{
			if ([[[winController sheetController] viewsWithAttachedSheets] count] > 0) 
			{
				// there is a window with an open sheet
				// bring this window to the front
				[w makeMainWindow];
				return NSTerminateCancel;
			}
		}
	}
	
	// go through the windows and check for tabs with unsaved images
	for (NSWindow *w in windows)
	{
		id winController = [w windowController];
		if ([winController class] == [TabbedWindowController class]) 
		{
			NSArray *tabs = [[w windowController] tabs];
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			for (FRWatcherTabContentsController *t in tabs)
			{
				if (([t changeCount] != 0) && [defaults boolForKey:FRShowQuitWindowAlert]) 
				{
					NSAlert *unsavedAlert = [[NSAlert alloc] init];
					[unsavedAlert setMessageText:@"Are you sure you want to quit?"];
					[unsavedAlert setInformativeText:@"There are unsaved images downloaded. Do you want to quit anyway?"];
					[unsavedAlert addButtonWithTitle:@"Quit"];
					[unsavedAlert addButtonWithTitle:@"Cancel"];
					[unsavedAlert setShowsSuppressionButton:YES];
					
					NSInteger returnValue = [unsavedAlert runModal];
					
					if (returnValue == NSAlertFirstButtonReturn)
					{
						if ([[unsavedAlert suppressionButton] state] == NSOnState) 
							[defaults setBool:NO forKey:FRShowQuitWindowAlert];
						
						return NSTerminateNow;
					}
					if (returnValue == NSAlertSecondButtonReturn)
						return NSTerminateCancel;
				}
			}
		}
	}
	
	return NSTerminateNow;
}


@end
