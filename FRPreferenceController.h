//
//  FRPreferenceController.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 03/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const FRAnimatedThumbsKey;
extern NSString *const FRResaveKey;
extern NSString *const FRIntervalKey;
extern NSString *const FRFinderCommentKey;
extern NSString *const FRCommentTagPrefix;
extern NSString *const FRPostName;
extern NSString *const FRPostEmail;
extern NSString *const FRDumpBoard;
extern NSString *const FRUserAgent;
extern NSString *const FRLastSaveLocation;
extern NSString *const FRShowCloseWindowAlert;
extern NSString *const FRShowQuitWindowAlert;

// preferences controller

@interface FRPreferenceController : NSWindowController
{
	IBOutlet NSButton *resaveToggleCheckBox;
	IBOutlet NSButton *animatedThumbsToggle; 
	IBOutlet NSButton *finderCommentCheckBox;
}

- (IBAction)changeResave:(id)sender;
- (IBAction)changeAnimatedThumbs:(id)sender;
- (IBAction)changeFinderComment:(id)sender;

@end
