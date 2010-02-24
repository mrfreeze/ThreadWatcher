/*
 * OPReferenceGlue.m
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import "OPReferenceGlue.h"

@implementation OPReference

/* +app, +con, +its methods can be used in place of OPApp, OPCon, OPIts macros */

+ (OPReference *)app {
    return [self referenceWithAppData: nil aemReference: AEMApp];
}

+ (OPReference *)con {
    return [self referenceWithAppData: nil aemReference: AEMCon];
}

+ (OPReference *)its {
    return [self referenceWithAppData: nil aemReference: AEMIts];
}


/* ********************************* */

- (NSString *)description {
    return [OPReferenceRenderer formatObject: AS_aemReference appData: AS_appData];
}


/* Commands */

- (OPCloseAllWindowsCommand *)CloseAllWindows {
    return [OPCloseAllWindowsCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'CLSA'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPCloseAllWindowsCommand *)CloseAllWindows:(id)directParameter {
    return [OPCloseAllWindowsCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'CLSA'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPCloseWindowCommand *)CloseWindow {
    return [OPCloseWindowCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'CLOS'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPCloseWindowCommand *)CloseWindow:(id)directParameter {
    return [OPCloseWindowCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'CLOS'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPGetSourceCommand *)GetSource {
    return [OPGetSourceCommand commandWithAppData: AS_appData
                         eventClass: 'MSIE'
                            eventID: 'SORC'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPGetSourceCommand *)GetSource:(id)directParameter {
    return [OPGetSourceCommand commandWithAppData: AS_appData
                         eventClass: 'MSIE'
                            eventID: 'SORC'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPGetURLCommand *)GetURL {
    return [OPGetURLCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPGetURLCommand *)GetURL:(id)directParameter {
    return [OPGetURLCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPGetWindowInfoCommand *)GetWindowInfo {
    return [OPGetWindowInfoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'WNFO'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPGetWindowInfoCommand *)GetWindowInfo:(id)directParameter {
    return [OPGetWindowInfoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'WNFO'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPListWindowsCommand *)ListWindows {
    return [OPListWindowsCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'LSTW'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPListWindowsCommand *)ListWindows:(id)directParameter {
    return [OPListWindowsCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'LSTW'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPOpenURLCommand *)OpenURL {
    return [OPOpenURLCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'OURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPOpenURLCommand *)OpenURL:(id)directParameter {
    return [OPOpenURLCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'OURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPRegisterURLEchoCommand *)RegisterURLEcho {
    return [OPRegisterURLEchoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'RGUE'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPRegisterURLEchoCommand *)RegisterURLEcho:(id)directParameter {
    return [OPRegisterURLEchoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'RGUE'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPShowFileCommand *)ShowFile {
    return [OPShowFileCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'SHWF'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPShowFileCommand *)ShowFile:(id)directParameter {
    return [OPShowFileCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'SHWF'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPUnRegisterURLEchoCommand *)UnRegisterURLEcho {
    return [OPUnRegisterURLEchoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'UNRU'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPUnRegisterURLEchoCommand *)UnRegisterURLEcho:(id)directParameter {
    return [OPUnRegisterURLEchoCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'UNRU'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPActivateCommand *)activate {
    return [OPActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPActivateCommand *)activate:(id)directParameter {
    return [OPActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPCloseCommand *)close {
    return [OPCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPCloseCommand *)close:(id)directParameter {
    return [OPCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPCountCommand *)count {
    return [OPCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPCountCommand *)count:(id)directParameter {
    return [OPCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPDataSizeCommand *)dataSize {
    return [OPDataSizeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'dsiz'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPDataSizeCommand *)dataSize:(id)directParameter {
    return [OPDataSizeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'dsiz'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPExistsCommand *)exists {
    return [OPExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPExistsCommand *)exists:(id)directParameter {
    return [OPExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPGetCommand *)get {
    return [OPGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPGetCommand *)get:(id)directParameter {
    return [OPGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPLaunchCommand *)launch {
    return [OPLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPLaunchCommand *)launch:(id)directParameter {
    return [OPLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPMakeCommand *)make {
    return [OPMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPMakeCommand *)make:(id)directParameter {
    return [OPMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPOpenCommand *)open {
    return [OPOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPOpenCommand *)open:(id)directParameter {
    return [OPOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPOpenLocationCommand *)openLocation {
    return [OPOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPOpenLocationCommand *)openLocation:(id)directParameter {
    return [OPOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPPrintCommand *)print {
    return [OPPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPPrintCommand *)print:(id)directParameter {
    return [OPPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPQuitCommand *)quit {
    return [OPQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPQuitCommand *)quit:(id)directParameter {
    return [OPQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPReopenCommand *)reopen {
    return [OPReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPReopenCommand *)reopen:(id)directParameter {
    return [OPReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPRunCommand *)run {
    return [OPRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPRunCommand *)run:(id)directParameter {
    return [OPRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPSaveCommand *)save {
    return [OPSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPSaveCommand *)save:(id)directParameter {
    return [OPSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: directParameter
                    parentReference: self];
}

- (OPSetCommand *)set {
    return [OPSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (OPSetCommand *)set:(id)directParameter {
    return [OPSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: directParameter
                    parentReference: self];
}


/* Elements */

- (OPReference *)application {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'capp']];
}

- (OPReference *)document {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'docu']];
}

- (OPReference *)items {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cobj']];
}


/* Properties */

- (OPReference *)bounds {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pbnd']];
}

- (OPReference *)class_ {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pcls']];
}

- (OPReference *)closeable {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'hclb']];
}

- (OPReference *)floating {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'isfl']];
}

- (OPReference *)id_ {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ID  ']];
}

- (OPReference *)index {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pidx']];
}

- (OPReference *)loading {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'LOad']];
}

- (OPReference *)miniaturizable {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ismn']];
}

- (OPReference *)miniaturized {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'minU']];
}

- (OPReference *)modal {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmod']];
}

- (OPReference *)modified {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'imod']];
}

- (OPReference *)name {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pnam']];
}

- (OPReference *)properties {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pALL']];
}

- (OPReference *)resizable {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'prsz']];
}

- (OPReference *)titled {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptit']];
}

- (OPReference *)url {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'url ']];
}

- (OPReference *)visible {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvis']];
}

- (OPReference *)window {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'wndw']];
}

- (OPReference *)zoomable {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'iszm']];
}

- (OPReference *)zoomed {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pzum']];
}


/* ********************************* */


/* ordinal selectors */

- (OPReference *)first {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference first]];
}

- (OPReference *)middle {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference middle]];
}

- (OPReference *)last {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference last]];
}

- (OPReference *)any {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference any]];
}


/* by-index, by-name, by-id selectors */

- (OPReference *)at:(int)index {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: index]];
}

- (OPReference *)byIndex:(id)index {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byIndex: index]];
}

- (OPReference *)byName:(id)name {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byName: name]];
}

- (OPReference *)byID:(id)id_ {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byID: id_]];
}


/* by-relative-position selectors */

- (OPReference *)previous:(ASConstant *)class_ {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference previous: [class_ AS_code]]];
}

- (OPReference *)next:(ASConstant *)class_ {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference next: [class_ AS_code]]];
}


/* by-range selector */

- (OPReference *)at:(int)fromIndex to:(int)toIndex {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: fromIndex to: toIndex]];
}

- (OPReference *)byRange:(id)fromObject to:(id)toObject {
    // takes two con-based references, with other values being expanded as necessary
    if ([fromObject isKindOfClass: [OPReference class]])
        fromObject = [fromObject AS_aemReference];
    if ([toObject isKindOfClass: [OPReference class]])
        toObject = [toObject AS_aemReference];
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byRange: fromObject to: toObject]];
}


/* by-test selector */

- (OPReference *)byTest:(OPReference *)testReference {
    return [OPReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference byTest: [testReference AS_aemReference]]];
}


/* insertion location selectors */

- (OPReference *)beginning {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginning]];
}

- (OPReference *)end {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference end]];
}

- (OPReference *)before {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference before]];
}

- (OPReference *)after {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference after]];
}


/* Comparison and logic tests */

- (OPReference *)greaterThan:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterThan: object]];
}

- (OPReference *)greaterOrEquals:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterOrEquals: object]];
}

- (OPReference *)equals:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference equals: object]];
}

- (OPReference *)notEquals:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference notEquals: object]];
}

- (OPReference *)lessThan:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessThan: object]];
}

- (OPReference *)lessOrEquals:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessOrEquals: object]];
}

- (OPReference *)beginsWith:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginsWith: object]];
}

- (OPReference *)endsWith:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference endsWith: object]];
}

- (OPReference *)contains:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference contains: object]];
}

- (OPReference *)isIn:(id)object {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference isIn: object]];
}

- (OPReference *)AND:(id)remainingOperands {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference AND: remainingOperands]];
}

- (OPReference *)OR:(id)remainingOperands {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference OR: remainingOperands]];
}

- (OPReference *)NOT {
    return [OPReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference NOT]];
}

@end

