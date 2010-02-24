/*
 * OPReferenceGlue.h
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "OPCommandGlue.h"
#import "OPReferenceRendererGlue.h"
#define OPApp ((OPReference *)[OPReference referenceWithAppData: nil aemReference: AEMApp])
#define OPCon ((OPReference *)[OPReference referenceWithAppData: nil aemReference: AEMCon])
#define OPIts ((OPReference *)[OPReference referenceWithAppData: nil aemReference: AEMIts])

@interface OPReference : ASReference

/* +app, +con, +its methods can be used in place of OPApp, OPCon, OPIts macros */

+ (OPReference *)app;
+ (OPReference *)con;
+ (OPReference *)its;

/* ********************************* */

- (NSString *)description;

/* Commands */

- (OPCloseAllWindowsCommand *)CloseAllWindows;
- (OPCloseAllWindowsCommand *)CloseAllWindows:(id)directParameter;
- (OPCloseWindowCommand *)CloseWindow;
- (OPCloseWindowCommand *)CloseWindow:(id)directParameter;
- (OPGetSourceCommand *)GetSource;
- (OPGetSourceCommand *)GetSource:(id)directParameter;
- (OPGetURLCommand *)GetURL;
- (OPGetURLCommand *)GetURL:(id)directParameter;
- (OPGetWindowInfoCommand *)GetWindowInfo;
- (OPGetWindowInfoCommand *)GetWindowInfo:(id)directParameter;
- (OPListWindowsCommand *)ListWindows;
- (OPListWindowsCommand *)ListWindows:(id)directParameter;
- (OPOpenURLCommand *)OpenURL;
- (OPOpenURLCommand *)OpenURL:(id)directParameter;
- (OPRegisterURLEchoCommand *)RegisterURLEcho;
- (OPRegisterURLEchoCommand *)RegisterURLEcho:(id)directParameter;
- (OPShowFileCommand *)ShowFile;
- (OPShowFileCommand *)ShowFile:(id)directParameter;
- (OPUnRegisterURLEchoCommand *)UnRegisterURLEcho;
- (OPUnRegisterURLEchoCommand *)UnRegisterURLEcho:(id)directParameter;
- (OPActivateCommand *)activate;
- (OPActivateCommand *)activate:(id)directParameter;
- (OPCloseCommand *)close;
- (OPCloseCommand *)close:(id)directParameter;
- (OPCountCommand *)count;
- (OPCountCommand *)count:(id)directParameter;
- (OPDataSizeCommand *)dataSize;
- (OPDataSizeCommand *)dataSize:(id)directParameter;
- (OPExistsCommand *)exists;
- (OPExistsCommand *)exists:(id)directParameter;
- (OPGetCommand *)get;
- (OPGetCommand *)get:(id)directParameter;
- (OPLaunchCommand *)launch;
- (OPLaunchCommand *)launch:(id)directParameter;
- (OPMakeCommand *)make;
- (OPMakeCommand *)make:(id)directParameter;
- (OPOpenCommand *)open;
- (OPOpenCommand *)open:(id)directParameter;
- (OPOpenLocationCommand *)openLocation;
- (OPOpenLocationCommand *)openLocation:(id)directParameter;
- (OPPrintCommand *)print;
- (OPPrintCommand *)print:(id)directParameter;
- (OPQuitCommand *)quit;
- (OPQuitCommand *)quit:(id)directParameter;
- (OPReopenCommand *)reopen;
- (OPReopenCommand *)reopen:(id)directParameter;
- (OPRunCommand *)run;
- (OPRunCommand *)run:(id)directParameter;
- (OPSaveCommand *)save;
- (OPSaveCommand *)save:(id)directParameter;
- (OPSetCommand *)set;
- (OPSetCommand *)set:(id)directParameter;

/* Elements */

- (OPReference *)application;
- (OPReference *)document;
- (OPReference *)items;

/* Properties */

- (OPReference *)bounds;
- (OPReference *)class_;
- (OPReference *)closeable;
- (OPReference *)floating;
- (OPReference *)id_;
- (OPReference *)index;
- (OPReference *)loading;
- (OPReference *)miniaturizable;
- (OPReference *)miniaturized;
- (OPReference *)modal;
- (OPReference *)modified;
- (OPReference *)name;
- (OPReference *)properties;
- (OPReference *)resizable;
- (OPReference *)titled;
- (OPReference *)url;
- (OPReference *)visible;
- (OPReference *)window;
- (OPReference *)zoomable;
- (OPReference *)zoomed;

/* ********************************* */


/* ordinal selectors */

- (OPReference *)first;
- (OPReference *)middle;
- (OPReference *)last;
- (OPReference *)any;

/* by-index, by-name, by-id selectors */

- (OPReference *)at:(int)index;
- (OPReference *)byIndex:(id)index;
- (OPReference *)byName:(id)name;
- (OPReference *)byID:(id)id_;

/* by-relative-position selectors */

- (OPReference *)previous:(ASConstant *)class_;
- (OPReference *)next:(ASConstant *)class_;

/* by-range selector */

- (OPReference *)at:(int)fromIndex to:(int)toIndex;
- (OPReference *)byRange:(id)fromObject to:(id)toObject;

/* by-test selector */

- (OPReference *)byTest:(OPReference *)testReference;

/* insertion location selectors */

- (OPReference *)beginning;
- (OPReference *)end;
- (OPReference *)before;
- (OPReference *)after;

/* Comparison and logic tests */

- (OPReference *)greaterThan:(id)object;
- (OPReference *)greaterOrEquals:(id)object;
- (OPReference *)equals:(id)object;
- (OPReference *)notEquals:(id)object;
- (OPReference *)lessThan:(id)object;
- (OPReference *)lessOrEquals:(id)object;
- (OPReference *)beginsWith:(id)object;
- (OPReference *)endsWith:(id)object;
- (OPReference *)contains:(id)object;
- (OPReference *)isIn:(id)object;
- (OPReference *)AND:(id)remainingOperands;
- (OPReference *)OR:(id)remainingOperands;
- (OPReference *)NOT;
@end

