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
#import "WatcherDocument.h"
#import "FRPreferenceController.h"


@implementation FRAppDelegate

// make sure any value transformers are 
// created before the nib loads
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
	[defaultValues setObject:[NSString stringWithString:@"Fuck_You_Anonymous-san"] forKey:FRUserAgent];
	
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
		if ([clickContext class] == [NSData class]) 
		{
			// clickback came from a post failed notification (from attempted post in watcher doc)
			WatcherDocument **ap = (WatcherDocument **)[clickContext bytes]; // yo dawg, i heard you like pointers...
			WatcherDocument *theDoc = *ap;
			
			[theDoc showPostSheet:self];
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




@end
