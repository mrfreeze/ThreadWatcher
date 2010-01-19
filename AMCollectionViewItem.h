//
//  AMCollectionViewItem.h
//  AMCollectionViewTest
//
//  Created by Andreas on 20.11.07.
//  Copyright 2007 Andreas Mayer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AMCollectionView;


@interface AMCollectionViewItem : NSObject <NSCoding> {
	IBOutlet AMCollectionView *collectionView; // weak reference
	IBOutlet NSView *view;
	id representedObject;
	BOOL selected;
}

- (id)initWithCollectionView:(AMCollectionView *)theCollectionView representedObject:(id)theObject;

- (void)removeFromCollectionView;

- (AMCollectionView *)collectionView;
- (void)setCollectionView:(AMCollectionView *)value;

- (id)representedObject;
- (void)setRepresentedObject:(id)value;

- (NSView *)view;
- (void)setView:(NSView *)value;

- (BOOL)isSelected;

@property (readwrite) BOOL selected;

@end
