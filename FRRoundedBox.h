//
//  FRRoundedBox.h
//  ThreadWatcher
//
//  Created by Mr. Freeze on 13/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRFullThreadCollectionViewItem.h"
#import "FRTextView.h"

@class FRFullThreadCollectionViewItem;
@class FRTextView;

/*
 * The box that encloses individual posts in the full thread view
 */

@interface FRRoundedBox : NSBox 
{
	FRFullThreadCollectionViewItem *collectionItem;
	IBOutlet FRTextView *postTextView;
}

@property (readwrite, assign) FRFullThreadCollectionViewItem *collectionItem;

@end
