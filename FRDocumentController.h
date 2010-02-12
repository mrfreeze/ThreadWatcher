//
//  FRDocumentController.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 08/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// document controller to control opening of new documents


@interface FRDocumentController : NSDocumentController 
{

}

// create a new watcher document and display it
- (IBAction)newWatcher:(id)sender;

// create a new image dump document and display it
- (IBAction)newDumper:(id)sender;

@end
