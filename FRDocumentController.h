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

- (IBAction)newWatcher:(id)sender;
- (IBAction)newDumper:(id)sender;

@end
