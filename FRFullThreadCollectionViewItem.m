//
//  FRFullThreadViewCollectionItem.m
//  ThreadWatcher
//
//  Created by Mr. Freeze on 15/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//

#import "FRFullThreadCollectionViewItem.h"
#import "FRPostedImage.h"
#import "FRFullThreadCollectionView.h"

@interface FRFullThreadCollectionViewItem ()
- (void)calcSize;
- (void)createLinks;
- (void)setupTextView;
- (BOOL)validLink:(NSString *)link;
@end


@implementation FRFullThreadCollectionViewItem

- (id)init
{
	self = [super init];
	if (self)
	{
		theText = nil;
	}
	return self;
}

- (id)initWithCollectionView:(AMCollectionView *)theCollectionView representedObject:(id)theObject
{
	self = [super initWithCollectionView:theCollectionView representedObject:theObject];
	if (self) 
	{
		if ([NSBundle loadNibNamed:@"fullThreadViewItem" owner:self]) 
		{
			[postTextField unbind:@"value"];
			[postNumberField unbind:@"value"];
			[imageThumbView unbind:@"value"];
			[selectionBox unbind:@"transparent"];
			[self setupTextView];
			if (theObject) 
			{
				[selectionBox setFillColor:[NSColor	lightGrayColor]];
				theText = [(FRPostedImage *)theObject postText];
				[self calcSize];
				[selectionBox setCollectionItem:self];
				[self createLinks];
			}
			[self willChangeValueForKey:@"representedObject"];
			[super setRepresentedObject:theObject];
			[self didChangeValueForKey:@"representedObject"];
		} 
		else 
		{
			[self release];
			self = nil;
		}
	}
	return self;
}

- (void)setupTextView
{
	[postTextField setDrawsBackground:NO];
	[postTextField setEditable:NO];
	[postTextField setSelectable:YES];
	[postTextField setAllowsUndo:NO];
	[postTextField setContinuousSpellCheckingEnabled:NO];
	[postTextField setGrammarCheckingEnabled:NO];
}

// -----------------------------------------------------------------------------
#pragma mark selection

- (void)setSelected:(BOOL)newStatus
{
	if (newStatus) 
		[selectionBox setFillColor:[NSColor grayColor]];
	else 
		[selectionBox setFillColor:[NSColor	lightGrayColor]];
	
	[super setSelected:newStatus];
}

// --------------------------------------------------------------------------------
#pragma mark encoding/decoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	postTextField = [coder decodeObjectForKey:@"PostTextField"];
	postNumberField = [coder decodeObjectForKey:@"PostNumberField"];
	imageThumbView = [coder decodeObjectForKey:@"ImageThumbView"];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	[coder encodeConditionalObject:postTextField forKey:@"PostTextField"];
	[coder encodeConditionalObject:postNumberField forKey:@"PostNumberField"];
	[coder encodeConditionalObject:imageThumbView forKey:@"ImageThumbView"];
}

// ------------------------------------------------------------------------------
#pragma mark view size

- (void)calcSize
{	
	NSTextContainer *textContainer = [postTextField textContainer];
	NSLayoutManager *layoutManager = [postTextField layoutManager];
	
	(void) [layoutManager glyphRangeForTextContainer:textContainer];
	
	float grow = [layoutManager usedRectForTextContainer:textContainer].size.height;
	
	// make sure our view is always at least the minimum size
	if (grow < 99.0) 
		grow = 99.0;
	
	viewHeight = 143.0 + (grow - 99.0);
 }

- (NSSize)sizeForViewWithProposedSize:(NSSize)newSize
{
	if (!representedObject) 
		return NSZeroSize;

	[self calcSize];
	NSSize new = NSMakeSize(newSize.width, viewHeight);
	
	if (!NSEqualSizes(newSize, new))
		[postTextField setNeedsDisplay:YES];
		
	return new;
}

// -----------------------------------------------------------------------------
#pragma mark internal links

- (void)createLinks
{
	if (theText) 
	{
		// find any links
		NSScanner *scanner = [NSScanner scannerWithString:theText];
		NSString *linkStart = @">>";
		NSMutableArray *links = [[NSMutableArray alloc] init];
		NSMutableArray *linkLocations = [[NSMutableArray alloc] init];
		while (![scanner isAtEnd]) 
		{
			NSString *aLink = nil;
			[scanner scanUpToString:linkStart intoString:nil];
			[linkLocations addObject:[NSNumber numberWithInt:[scanner scanLocation]]];
			[scanner scanString:linkStart intoString:nil]; 
			[scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] 
									intoString:&aLink];

			if ([self validLink:aLink])
				[links addObject:aLink];
			else 
				[linkLocations removeLastObject];
		} 
		
		// find any quotes
		NSScanner *quoteScanner = [NSScanner scannerWithString:theText];
		NSString *quoteStart = @">";
		NSMutableArray *quotes = [[NSMutableArray alloc] init];
		while (![quoteScanner isAtEnd]) 
		{
			NSString *aQuote = nil;
			[quoteScanner scanUpToString:quoteStart intoString:nil];
			
			// ignore if it's a link rather than a quote
			BOOL link = FALSE;
			for (NSNumber *n in linkLocations)
			{
				if ([quoteScanner scanLocation] == [n intValue])
				{
					link = TRUE;
					break;
				}
			}
			
			if (link)
			{
				// get rid of the second > character so we don't hit it 
				// again next time
				[quoteScanner scanString:quoteStart intoString:nil];
				[quoteScanner scanString:quoteStart intoString:nil];
				continue;
			}
					 
			// scan the actual quoted text
			[quoteScanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] 
										 intoString:&aQuote];
			if (aQuote) 
				[quotes addObject:aQuote];
		} 
		
		NSMutableAttributedString *textWithLinks = 
			[[NSMutableAttributedString alloc] initWithString:theText];
		
		// set quotes in green
		[textWithLinks beginEditing];
		for (NSString *s in quotes)
		{
			NSRange range = [theText rangeOfString:s];
			NSRange r = NSMakeRange(range.location, range.length);
			
			// TODO: see if we can find a better green colour here
			[textWithLinks addAttribute:NSForegroundColorAttributeName 
								  value:[NSColor colorWithCalibratedRed:0.1 
																  green:0.5 
																   blue:0.15 
																  alpha:1.0]
								  range:r];
		}
		
		// make the links clickable
		for (NSString *s in links)
		{
			NSRange range = [theText rangeOfString:s];
			NSRange r = NSMakeRange(range.location-2, range.length+2);
			
			[textWithLinks addAttribute:NSLinkAttributeName value:s range:r];
		}
		[textWithLinks endEditing];
		
		[[postTextField textStorage] setAttributedString:textWithLinks];
	}
}

- (BOOL)validLink:(NSString *)link
{
	if (!link)
		return NO;
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	NSNumber *num = [formatter numberFromString:link];
	
	if (num)
		return YES;
	else 
		return NO;
}

- (void)createGreenText
{
	if (theText) 
	{

		
		
	}
}


// select linked post
- (BOOL)textView:(NSTextView *)aTextView clickedOnLink:(id)link atIndex:(NSUInteger)charIndex
{
	// get array of posts in the thread
	NSArray *posts = [collectionView content];
	
	for (FRPostedImage *post in posts)
	{
		if ([[post postNumber] isEqual:(NSString *)link])
		{
			// found the matching post
			[(FRFullThreadCollectionView *)collectionView selectItemsForObjects:[NSArray arrayWithObject:post]];
			[(FRFullThreadCollectionView *)collectionView scrollObjectToVisible:post];
		}
	}
	
	return YES;
}



@end



