/*
 * WKReferenceGlue.h
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "WKCommandGlue.h"
#import "WKReferenceRendererGlue.h"
#define WKApp ((WKReference *)[WKReference referenceWithAppData: nil aemReference: AEMApp])
#define WKCon ((WKReference *)[WKReference referenceWithAppData: nil aemReference: AEMCon])
#define WKIts ((WKReference *)[WKReference referenceWithAppData: nil aemReference: AEMIts])

@interface WKReference : ASReference

/* +app, +con, +its methods can be used in place of WKApp, WKCon, WKIts macros */

+ (WKReference *)app;
+ (WKReference *)con;
+ (WKReference *)its;

/* ********************************* */

- (NSString *)description;

/* Commands */

- (WKActivateCommand *)activate;
- (WKActivateCommand *)activate:(id)directParameter;
- (WKCloseCommand *)close;
- (WKCloseCommand *)close:(id)directParameter;
- (WKCountCommand *)count;
- (WKCountCommand *)count:(id)directParameter;
- (WKDeleteCommand *)delete;
- (WKDeleteCommand *)delete:(id)directParameter;
- (WKDoJavaScriptCommand *)doJavaScript;
- (WKDoJavaScriptCommand *)doJavaScript:(id)directParameter;
- (WKDuplicateCommand *)duplicate;
- (WKDuplicateCommand *)duplicate:(id)directParameter;
- (WKEmailContentsCommand *)emailContents;
- (WKEmailContentsCommand *)emailContents:(id)directParameter;
- (WKExistsCommand *)exists;
- (WKExistsCommand *)exists:(id)directParameter;
- (WKGetCommand *)get;
- (WKGetCommand *)get:(id)directParameter;
- (WKLaunchCommand *)launch;
- (WKLaunchCommand *)launch:(id)directParameter;
- (WKMakeCommand *)make;
- (WKMakeCommand *)make:(id)directParameter;
- (WKMoveCommand *)move;
- (WKMoveCommand *)move:(id)directParameter;
- (WKOpenCommand *)open;
- (WKOpenCommand *)open:(id)directParameter;
- (WKOpenLocationCommand *)openLocation;
- (WKOpenLocationCommand *)openLocation:(id)directParameter;
- (WKPrintCommand *)print;
- (WKPrintCommand *)print:(id)directParameter;
- (WKQuitCommand *)quit;
- (WKQuitCommand *)quit:(id)directParameter;
- (WKReopenCommand *)reopen;
- (WKReopenCommand *)reopen:(id)directParameter;
- (WKRunCommand *)run;
- (WKRunCommand *)run:(id)directParameter;
- (WKSaveCommand *)save;
- (WKSaveCommand *)save:(id)directParameter;
- (WKSetCommand *)set;
- (WKSetCommand *)set:(id)directParameter;
- (WKShowBookmarksCommand *)showBookmarks;
- (WKShowBookmarksCommand *)showBookmarks:(id)directParameter;

/* Elements */

- (WKReference *)applications;
- (WKReference *)attachment;
- (WKReference *)attributeRuns;
- (WKReference *)characters;
- (WKReference *)colors;
- (WKReference *)documents;
- (WKReference *)items;
- (WKReference *)paragraphs;
- (WKReference *)printSettings;
- (WKReference *)tabs;
- (WKReference *)text;
- (WKReference *)windows;
- (WKReference *)words;

/* Properties */

- (WKReference *)URL;
- (WKReference *)bounds;
- (WKReference *)class_;
- (WKReference *)closeable;
- (WKReference *)collating;
- (WKReference *)color;
- (WKReference *)copies;
- (WKReference *)currentTab;
- (WKReference *)document;
- (WKReference *)endingPage;
- (WKReference *)errorHandling;
- (WKReference *)faxNumber;
- (WKReference *)fileName;
- (WKReference *)floating;
- (WKReference *)font;
- (WKReference *)frontmost;
- (WKReference *)id_;
- (WKReference *)index;
- (WKReference *)miniaturizable;
- (WKReference *)miniaturized;
- (WKReference *)modal;
- (WKReference *)modified;
- (WKReference *)name;
- (WKReference *)pagesAcross;
- (WKReference *)pagesDown;
- (WKReference *)path;
- (WKReference *)properties;
- (WKReference *)requestedPrintTime;
- (WKReference *)resizable;
- (WKReference *)size;
- (WKReference *)source;
- (WKReference *)startingPage;
- (WKReference *)targetPrinter;
- (WKReference *)titled;
- (WKReference *)version_;
- (WKReference *)visible;
- (WKReference *)zoomable;
- (WKReference *)zoomed;

/* ********************************* */


/* ordinal selectors */

- (WKReference *)first;
- (WKReference *)middle;
- (WKReference *)last;
- (WKReference *)any;

/* by-index, by-name, by-id selectors */

- (WKReference *)at:(int)index;
- (WKReference *)byIndex:(id)index;
- (WKReference *)byName:(id)name;
- (WKReference *)byID:(id)id_;

/* by-relative-position selectors */

- (WKReference *)previous:(ASConstant *)class_;
- (WKReference *)next:(ASConstant *)class_;

/* by-range selector */

- (WKReference *)at:(int)fromIndex to:(int)toIndex;
- (WKReference *)byRange:(id)fromObject to:(id)toObject;

/* by-test selector */

- (WKReference *)byTest:(WKReference *)testReference;

/* insertion location selectors */

- (WKReference *)beginning;
- (WKReference *)end;
- (WKReference *)before;
- (WKReference *)after;

/* Comparison and logic tests */

- (WKReference *)greaterThan:(id)object;
- (WKReference *)greaterOrEquals:(id)object;
- (WKReference *)equals:(id)object;
- (WKReference *)notEquals:(id)object;
- (WKReference *)lessThan:(id)object;
- (WKReference *)lessOrEquals:(id)object;
- (WKReference *)beginsWith:(id)object;
- (WKReference *)endsWith:(id)object;
- (WKReference *)contains:(id)object;
- (WKReference *)isIn:(id)object;
- (WKReference *)AND:(id)remainingOperands;
- (WKReference *)OR:(id)remainingOperands;
- (WKReference *)NOT;
@end

