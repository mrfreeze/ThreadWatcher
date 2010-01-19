/*
 * FRReferenceGlue.h
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "FRCommandGlue.h"
#import "FRReferenceRendererGlue.h"
#define FRApp ((FRReference *)[FRReference referenceWithAppData: nil aemReference: AEMApp])
#define FRCon ((FRReference *)[FRReference referenceWithAppData: nil aemReference: AEMCon])
#define FRIts ((FRReference *)[FRReference referenceWithAppData: nil aemReference: AEMIts])

@interface FRReference : ASReference

/* +app, +con, +its methods can be used in place of FRApp, FRCon, FRIts macros */

+ (FRReference *)app;
+ (FRReference *)con;
+ (FRReference *)its;

/* ********************************* */

- (NSString *)description;

/* Commands */

- (FRActivateCommand *)activate;
- (FRActivateCommand *)activate:(id)directParameter;
- (FRCloseCommand *)close;
- (FRCloseCommand *)close:(id)directParameter;
- (FRCountCommand *)count;
- (FRCountCommand *)count:(id)directParameter;
- (FRDeleteCommand *)delete;
- (FRDeleteCommand *)delete:(id)directParameter;
- (FRDuplicateCommand *)duplicate;
- (FRDuplicateCommand *)duplicate:(id)directParameter;
- (FRExistsCommand *)exists;
- (FRExistsCommand *)exists:(id)directParameter;
- (FRGetCommand *)get;
- (FRGetCommand *)get:(id)directParameter;
- (FRLaunchCommand *)launch;
- (FRLaunchCommand *)launch:(id)directParameter;
- (FRMakeCommand *)make;
- (FRMakeCommand *)make:(id)directParameter;
- (FRMoveCommand *)move;
- (FRMoveCommand *)move:(id)directParameter;
- (FROpenCommand *)open;
- (FROpenCommand *)open:(id)directParameter;
- (FROpenLocationCommand *)openLocation;
- (FROpenLocationCommand *)openLocation:(id)directParameter;
- (FRPrintCommand *)print;
- (FRPrintCommand *)print:(id)directParameter;
- (FRQuitCommand *)quit;
- (FRQuitCommand *)quit:(id)directParameter;
- (FRReopenCommand *)reopen;
- (FRReopenCommand *)reopen:(id)directParameter;
- (FRRunCommand *)run;
- (FRRunCommand *)run:(id)directParameter;
- (FRSaveCommand *)save;
- (FRSaveCommand *)save:(id)directParameter;
- (FRSetCommand *)set;
- (FRSetCommand *)set:(id)directParameter;

/* Elements */

- (FRReference *)applications;
- (FRReference *)attachment;
- (FRReference *)attributeRuns;
- (FRReference *)characters;
- (FRReference *)colors;
- (FRReference *)documents;
- (FRReference *)items;
- (FRReference *)paragraphs;
- (FRReference *)printSettings;
- (FRReference *)text;
- (FRReference *)windows;
- (FRReference *)words;

/* Properties */

- (FRReference *)bounds;
- (FRReference *)class_;
- (FRReference *)closeable;
- (FRReference *)collating;
- (FRReference *)color;
- (FRReference *)copies;
- (FRReference *)document;
- (FRReference *)endingPage;
- (FRReference *)errorHandling;
- (FRReference *)faxNumber;
- (FRReference *)fileName;
- (FRReference *)floating;
- (FRReference *)font;
- (FRReference *)frontmost;
- (FRReference *)id_;
- (FRReference *)index;
- (FRReference *)miniaturizable;
- (FRReference *)miniaturized;
- (FRReference *)modal;
- (FRReference *)modified;
- (FRReference *)name;
- (FRReference *)pagesAcross;
- (FRReference *)pagesDown;
- (FRReference *)path;
- (FRReference *)properties;
- (FRReference *)requestedPrintTime;
- (FRReference *)resizable;
- (FRReference *)size;
- (FRReference *)startingPage;
- (FRReference *)targetPrinter;
- (FRReference *)titled;
- (FRReference *)version_;
- (FRReference *)visible;
- (FRReference *)zoomable;
- (FRReference *)zoomed;

/* ********************************* */


/* ordinal selectors */

- (FRReference *)first;
- (FRReference *)middle;
- (FRReference *)last;
- (FRReference *)any;

/* by-index, by-name, by-id selectors */

- (FRReference *)at:(int)index;
- (FRReference *)byIndex:(id)index;
- (FRReference *)byName:(id)name;
- (FRReference *)byID:(id)id_;

/* by-relative-position selectors */

- (FRReference *)previous:(ASConstant *)class_;
- (FRReference *)next:(ASConstant *)class_;

/* by-range selector */

- (FRReference *)at:(int)fromIndex to:(int)toIndex;
- (FRReference *)byRange:(id)fromObject to:(id)toObject;

/* by-test selector */

- (FRReference *)byTest:(FRReference *)testReference;

/* insertion location selectors */

- (FRReference *)beginning;
- (FRReference *)end;
- (FRReference *)before;
- (FRReference *)after;

/* Comparison and logic tests */

- (FRReference *)greaterThan:(id)object;
- (FRReference *)greaterOrEquals:(id)object;
- (FRReference *)equals:(id)object;
- (FRReference *)notEquals:(id)object;
- (FRReference *)lessThan:(id)object;
- (FRReference *)lessOrEquals:(id)object;
- (FRReference *)beginsWith:(id)object;
- (FRReference *)endsWith:(id)object;
- (FRReference *)contains:(id)object;
- (FRReference *)isIn:(id)object;
- (FRReference *)AND:(id)remainingOperands;
- (FRReference *)OR:(id)remainingOperands;
- (FRReference *)NOT;
@end

