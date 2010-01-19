//
//  FRCollectionItemView.h
//  ThreadWatcher
//
//  Created by Mr Freeze on 10/12/2009.
//  Copyright 2009 Mr. Freeze. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRAppDelegate.h"
#import "FRPostedImage.h"

@class FRImageView;

/*
 * The objects used for the icon view -
 * the collection view itself
 * the box that shows selection
 * and the imageview that contains the thumbnail
 */


// the view for each item in the NSCollectionView
@interface FRCollectionItemViewSelectionBox : NSBox 
{
	IBOutlet NSCollectionViewItem *collectionController;
	NSEvent *mouseDownEvent;
}

- (void)mouseDown:(NSEvent *)theEvent from:(id)source;

@property (assign) IBOutlet NSCollectionViewItem *collectionController;
@end

// ---------------------------------------------------------------------------------

// our collection view
@interface FRIconCollectionView : NSCollectionView
@end

// ----------------------------------------------------------------------------------
// the imageview used to display the thumbnail in the collectionview
@interface	FRImageView : NSImageView
{
	IBOutlet FRPostedImage *representedObject;
	IBOutlet NSCollectionViewItem *collectionController;
	IBOutlet FRCollectionItemViewSelectionBox *boxView;
}
@property (readwrite, retain) IBOutlet FRPostedImage *representedObject;
@property (assign) IBOutlet FRCollectionItemViewSelectionBox *boxView;
@property (assign) IBOutlet NSCollectionViewItem *collectionController;
@end

// ------------------------------------------------------------------------------------

// the view that lets the user set the rating (0 - 5 stars)
@interface FRLevelIndicatorCell : NSLevelIndicatorCell
@end

