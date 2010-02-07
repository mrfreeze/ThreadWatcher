//
//  FRAppDelegate.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 11/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "doubleToMins.h"
#import "Growl.framework/Headers/GrowlApplicationBridge.h"
#import "MyDocument.h"
@class FRPreferenceController;

// app delegate that allows us to open the quicklook panel
// also is responsible for growl, and initialising value transformers

@interface FRAppDelegate : NSObject <NSApplicationDelegate, GrowlApplicationBridgeDelegate>
{
	FRPreferenceController *preferenceController;
	
	IBOutlet NSMenuItem *closeTabMenuItem_;
	IBOutlet NSMenuItem *closeWindowMenuItem_;
	BOOL fileMenuUpdatePending_;
	
	/* 
	 * because clickback from growl seems to send 
	 * the message to us twice, we will ignore messages that are within
	 * the space of 4 seconds of each other. 
	 */
	NSDate *lastGrowlTime; 
}

+ (void)initialiseValueTransformers;

// toggle the quicklook panel
- (IBAction)togglePreviewPanel:(id)previewPanel;

// open  the preferences window
- (IBAction)showPreferencePanel:(id)sender;

// growl delegate method that recieves clickbacks
- (void)growlNotificationWasClicked:(id)clickContext;

@end
