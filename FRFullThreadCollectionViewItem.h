//
//  FRFullThreadViewCollectionItem.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 15/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMCollectionViewItem.h"
#import "FRRoundedBox.h"

@class FRRoundedBox;

/* 
 * Used by the AMCollectionView to represent individual posts
 * controls the colour of the rounded box to show selection
 * as well as the resizing of the item view depending on the length of the post
 */
 

@interface FRFullThreadCollectionViewItem : AMCollectionViewItem 
{
	IBOutlet NSTextView *postTextField;
	IBOutlet NSImageView *imageThumbView;
	IBOutlet NSTextField *postNumberField;
	IBOutlet FRRoundedBox *selectionBox;
	CGFloat viewHeight;
	NSString *theText;
}

@end
