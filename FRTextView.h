//
//  FRTextView.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 17/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRRoundedBox.h"

@class FRRoundedBox;

/* 
 * The text view used to display the text of a post in the full thread view
 * deals with mouse clicks, to make sure items can be selected
 */

@interface FRTextView : NSTextView 
{
	IBOutlet FRRoundedBox *box;
}

@end
