/*
 * CMReferenceGlue.h
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "CMCommandGlue.h"
#import "CMReferenceRendererGlue.h"
#define CMApp ((CMReference *)[CMReference referenceWithAppData: nil aemReference: AEMApp])
#define CMCon ((CMReference *)[CMReference referenceWithAppData: nil aemReference: AEMCon])
#define CMIts ((CMReference *)[CMReference referenceWithAppData: nil aemReference: AEMIts])

@interface CMReference : ASReference

/* +app, +con, +its methods can be used in place of CMApp, CMCon, CMIts macros */

+ (CMReference *)app;
+ (CMReference *)con;
+ (CMReference *)its;

/* ********************************* */

- (NSString *)description;

/* Commands */

- (CMDeprecatedOpenURLCommand *)DeprecatedOpenURL;
- (CMDeprecatedOpenURLCommand *)DeprecatedOpenURL:(id)directParameter;
- (CMActivateCommand *)activate;
- (CMActivateCommand *)activate:(id)directParameter;
- (CMCloseCommand *)close;
- (CMCloseCommand *)close:(id)directParameter;
- (CMCountCommand *)count;
- (CMCountCommand *)count:(id)directParameter;
- (CMDeleteCommand *)delete;
- (CMDeleteCommand *)delete:(id)directParameter;
- (CMDuplicateCommand *)duplicate;
- (CMDuplicateCommand *)duplicate:(id)directParameter;
- (CMExistsCommand *)exists;
- (CMExistsCommand *)exists:(id)directParameter;
- (CMGetCommand *)get;
- (CMGetCommand *)get:(id)directParameter;
- (CMLaunchCommand *)launch;
- (CMLaunchCommand *)launch:(id)directParameter;
- (CMMakeCommand *)make;
- (CMMakeCommand *)make:(id)directParameter;
- (CMMoveCommand *)move;
- (CMMoveCommand *)move:(id)directParameter;
- (CMOpenCommand *)open;
- (CMOpenCommand *)open:(id)directParameter;
- (CMOpenLocationCommand *)openLocation;
- (CMOpenLocationCommand *)openLocation:(id)directParameter;
- (CMPrintCommand *)print;
- (CMPrintCommand *)print:(id)directParameter;
- (CMQuitCommand *)quit;
- (CMQuitCommand *)quit:(id)directParameter;
- (CMReopenCommand *)reopen;
- (CMReopenCommand *)reopen:(id)directParameter;
- (CMRunCommand *)run;
- (CMRunCommand *)run:(id)directParameter;
- (CMSaveCommand *)save;
- (CMSaveCommand *)save:(id)directParameter;
- (CMSetCommand *)set;
- (CMSetCommand *)set:(id)directParameter;

/* Elements */

- (CMReference *)applications;
- (CMReference *)bookmarkFolders;
- (CMReference *)bookmarkItems;
- (CMReference *)bookmarks;
- (CMReference *)browserWindows;
- (CMReference *)items;
- (CMReference *)tabs;
- (CMReference *)text;
- (CMReference *)windows;

/* Properties */

- (CMReference *)URL;
- (CMReference *)addressBookCollection;
- (CMReference *)bonjourCollection;
- (CMReference *)bookmarkBarCollection;
- (CMReference *)bookmarkMenuCollection;
- (CMReference *)bounds;
- (CMReference *)class_;
- (CMReference *)closeable;
- (CMReference *)currentTab;
- (CMReference *)description_;
- (CMReference *)floating;
- (CMReference *)frontmost;
- (CMReference *)id_;
- (CMReference *)index;
- (CMReference *)lastVisitDate;
- (CMReference *)miniaturizable;
- (CMReference *)miniaturized;
- (CMReference *)modal;
- (CMReference *)name;
- (CMReference *)properties;
- (CMReference *)resizable;
- (CMReference *)selectedSource;
- (CMReference *)selectedText;
- (CMReference *)shortcut;
- (CMReference *)source;
- (CMReference *)title;
- (CMReference *)titled;
- (CMReference *)topTenCollection;
- (CMReference *)version_;
- (CMReference *)visible;
- (CMReference *)visitCount;
- (CMReference *)zoomable;
- (CMReference *)zoomed;

/* ********************************* */


/* ordinal selectors */

- (CMReference *)first;
- (CMReference *)middle;
- (CMReference *)last;
- (CMReference *)any;

/* by-index, by-name, by-id selectors */

- (CMReference *)at:(int)index;
- (CMReference *)byIndex:(id)index;
- (CMReference *)byName:(id)name;
- (CMReference *)byID:(id)id_;

/* by-relative-position selectors */

- (CMReference *)previous:(ASConstant *)class_;
- (CMReference *)next:(ASConstant *)class_;

/* by-range selector */

- (CMReference *)at:(int)fromIndex to:(int)toIndex;
- (CMReference *)byRange:(id)fromObject to:(id)toObject;

/* by-test selector */

- (CMReference *)byTest:(CMReference *)testReference;

/* insertion location selectors */

- (CMReference *)beginning;
- (CMReference *)end;
- (CMReference *)before;
- (CMReference *)after;

/* Comparison and logic tests */

- (CMReference *)greaterThan:(id)object;
- (CMReference *)greaterOrEquals:(id)object;
- (CMReference *)equals:(id)object;
- (CMReference *)notEquals:(id)object;
- (CMReference *)lessThan:(id)object;
- (CMReference *)lessOrEquals:(id)object;
- (CMReference *)beginsWith:(id)object;
- (CMReference *)endsWith:(id)object;
- (CMReference *)contains:(id)object;
- (CMReference *)isIn:(id)object;
- (CMReference *)AND:(id)remainingOperands;
- (CMReference *)OR:(id)remainingOperands;
- (CMReference *)NOT;
@end

