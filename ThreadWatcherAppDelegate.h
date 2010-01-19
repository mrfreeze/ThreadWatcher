//
//  ThreadWatcherAppDelegate.h
//  ThreadWatcher
//
//  Created by frogblast on 09/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ThreadWatcherAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
