//
//  FRPreferenceController.m
//  ThreadWatcher
//
//  Created by Mr Freeze on 03/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRPreferenceController.h"

// defaults strings
NSString *const FRAnimatedThumbsKey = @"AnimateThumbnails";
NSString *const FRResaveKey = @"ResaveImages";
NSString *const FRIntervalKey = @"WatchInterval";
NSString *const FRFinderCommentKey = @"WriteFinderComments";
NSString *const FRCommentTagPrefix = @"FinderTagPrefix";
NSString *const FRPostName = @"PostWithName";
NSString *const FRPostEmail = @"PostWithEmail";
NSString *const FRDumpBoard = @"DefaultDumpBoard";
NSString *const FRUserAgent = @"UserAgent";
NSString *const FRLastSaveLocation = @"LastSaveLocation";
NSString *const FRShowCloseWindowAlert = @"ShowCloseWindowAlert";
NSString *const FRShowQuitWindowAlert = @"ShowQuitAlert";
NSString *const FRAutomaticWatching = @"AutomaticThreadWatching";

@implementation FRPreferenceController

- (id)init
{
	if (![super initWithWindowNibName:@"Preferences"]) 
		return nil;
	
	return self;
}

- (IBAction)changeResave:(id)sender
{
	int state = [resaveToggleCheckBox state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:FRResaveKey];
}

- (IBAction)changeAnimatedThumbs:(id)sender
{
	int state = [animatedThumbsToggle state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:FRAnimatedThumbsKey];
}

- (IBAction)changeFinderComment:(id)sender
{
	int state = [finderCommentCheckBox state];
	if (state == 1) 
	{
		// warn user about problems using spotlight comments
		int result = NSRunAlertPanel(@"Spotlight Comments", 
									 @"Comments will not appear in Get Info windows in the Finder, however they will still be searchable using Spotlight and viewable with other file browsers. See the documentation for more info.", 
									 @"Enable", @"Cancel", nil);
		
		if (result == NSAlertDefaultReturn) 
			[finderCommentCheckBox setState:YES];
		else 
			[finderCommentCheckBox setState:NO];
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:[finderCommentCheckBox state] forKey:FRFinderCommentKey];
}

- (IBAction)changeAutomatingWatching:(id)sender
{
	int state = [sender state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:FRAutomaticWatching];
}

- (BOOL)animate
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FRAnimatedThumbsKey];
}

- (BOOL)resave
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FRResaveKey];
}

- (BOOL)finderComment
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FRFinderCommentKey];
}

- (BOOL)watching
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FRAutomaticWatching];
}

- (void)windowDidLoad
{
	[resaveToggleCheckBox setState:[self resave]];
	[animatedThumbsToggle setState:[self animate]];
	[finderCommentCheckBox setState:[self finderComment]];
	[automaticWatchingCheckBox setState:[self watching]];
}

@end
