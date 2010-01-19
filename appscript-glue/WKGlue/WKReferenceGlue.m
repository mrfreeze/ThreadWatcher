/*
 * WKReferenceGlue.m
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import "WKReferenceGlue.h"

@implementation WKReference

/* +app, +con, +its methods can be used in place of WKApp, WKCon, WKIts macros */

+ (WKReference *)app {
    return [self referenceWithAppData: nil aemReference: AEMApp];
}

+ (WKReference *)con {
    return [self referenceWithAppData: nil aemReference: AEMCon];
}

+ (WKReference *)its {
    return [self referenceWithAppData: nil aemReference: AEMIts];
}


/* ********************************* */

- (NSString *)description {
    return [WKReferenceRenderer formatObject: AS_aemReference appData: AS_appData];
}


/* Commands */

- (WKActivateCommand *)activate {
    return [WKActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKActivateCommand *)activate:(id)directParameter {
    return [WKActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKCloseCommand *)close {
    return [WKCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKCloseCommand *)close:(id)directParameter {
    return [WKCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKCountCommand *)count {
    return [WKCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKCountCommand *)count:(id)directParameter {
    return [WKCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKDeleteCommand *)delete {
    return [WKDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKDeleteCommand *)delete:(id)directParameter {
    return [WKDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKDoJavaScriptCommand *)doJavaScript {
    return [WKDoJavaScriptCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'dojs'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKDoJavaScriptCommand *)doJavaScript:(id)directParameter {
    return [WKDoJavaScriptCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'dojs'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKDuplicateCommand *)duplicate {
    return [WKDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKDuplicateCommand *)duplicate:(id)directParameter {
    return [WKDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKEmailContentsCommand *)emailContents {
    return [WKEmailContentsCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'mlct'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKEmailContentsCommand *)emailContents:(id)directParameter {
    return [WKEmailContentsCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'mlct'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKExistsCommand *)exists {
    return [WKExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKExistsCommand *)exists:(id)directParameter {
    return [WKExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKGetCommand *)get {
    return [WKGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKGetCommand *)get:(id)directParameter {
    return [WKGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKLaunchCommand *)launch {
    return [WKLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKLaunchCommand *)launch:(id)directParameter {
    return [WKLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKMakeCommand *)make {
    return [WKMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKMakeCommand *)make:(id)directParameter {
    return [WKMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKMoveCommand *)move {
    return [WKMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKMoveCommand *)move:(id)directParameter {
    return [WKMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKOpenCommand *)open {
    return [WKOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKOpenCommand *)open:(id)directParameter {
    return [WKOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKOpenLocationCommand *)openLocation {
    return [WKOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKOpenLocationCommand *)openLocation:(id)directParameter {
    return [WKOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKPrintCommand *)print {
    return [WKPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKPrintCommand *)print:(id)directParameter {
    return [WKPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKQuitCommand *)quit {
    return [WKQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKQuitCommand *)quit:(id)directParameter {
    return [WKQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKReopenCommand *)reopen {
    return [WKReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKReopenCommand *)reopen:(id)directParameter {
    return [WKReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKRunCommand *)run {
    return [WKRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKRunCommand *)run:(id)directParameter {
    return [WKRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKSaveCommand *)save {
    return [WKSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKSaveCommand *)save:(id)directParameter {
    return [WKSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKSetCommand *)set {
    return [WKSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKSetCommand *)set:(id)directParameter {
    return [WKSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: directParameter
                    parentReference: self];
}

- (WKShowBookmarksCommand *)showBookmarks {
    return [WKShowBookmarksCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'opbk'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (WKShowBookmarksCommand *)showBookmarks:(id)directParameter {
    return [WKShowBookmarksCommand commandWithAppData: AS_appData
                         eventClass: 'sfri'
                            eventID: 'opbk'
                    directParameter: directParameter
                    parentReference: self];
}


/* Elements */

- (WKReference *)applications {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'capp']];
}

- (WKReference *)attachment {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'atts']];
}

- (WKReference *)attributeRuns {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'catr']];
}

- (WKReference *)characters {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cha ']];
}

- (WKReference *)colors {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'colr']];
}

- (WKReference *)documents {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'docu']];
}

- (WKReference *)items {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cobj']];
}

- (WKReference *)paragraphs {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cpar']];
}

- (WKReference *)printSettings {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'pset']];
}

- (WKReference *)tabs {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'bTab']];
}

- (WKReference *)text {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'ctxt']];
}

- (WKReference *)windows {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cwin']];
}

- (WKReference *)words {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cwor']];
}


/* Properties */

- (WKReference *)URL {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pURL']];
}

- (WKReference *)bounds {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pbnd']];
}

- (WKReference *)class_ {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pcls']];
}

- (WKReference *)closeable {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'hclb']];
}

- (WKReference *)collating {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwcl']];
}

- (WKReference *)color {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'colr']];
}

- (WKReference *)copies {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwcp']];
}

- (WKReference *)currentTab {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'cTab']];
}

- (WKReference *)document {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'docu']];
}

- (WKReference *)endingPage {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwlp']];
}

- (WKReference *)errorHandling {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lweh']];
}

- (WKReference *)faxNumber {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'faxn']];
}

- (WKReference *)fileName {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'atfn']];
}

- (WKReference *)floating {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'isfl']];
}

- (WKReference *)font {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'font']];
}

- (WKReference *)frontmost {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pisf']];
}

- (WKReference *)id_ {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ID  ']];
}

- (WKReference *)index {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pidx']];
}

- (WKReference *)miniaturizable {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ismn']];
}

- (WKReference *)miniaturized {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmnd']];
}

- (WKReference *)modal {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmod']];
}

- (WKReference *)modified {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'imod']];
}

- (WKReference *)name {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pnam']];
}

- (WKReference *)pagesAcross {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwla']];
}

- (WKReference *)pagesDown {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwld']];
}

- (WKReference *)path {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ppth']];
}

- (WKReference *)properties {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pALL']];
}

- (WKReference *)requestedPrintTime {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwqt']];
}

- (WKReference *)resizable {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'prsz']];
}

- (WKReference *)size {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptsz']];
}

- (WKReference *)source {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'conT']];
}

- (WKReference *)startingPage {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwfp']];
}

- (WKReference *)targetPrinter {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'trpr']];
}

- (WKReference *)titled {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptit']];
}

- (WKReference *)version_ {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'vers']];
}

- (WKReference *)visible {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvis']];
}

- (WKReference *)zoomable {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'iszm']];
}

- (WKReference *)zoomed {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pzum']];
}


/* ********************************* */


/* ordinal selectors */

- (WKReference *)first {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference first]];
}

- (WKReference *)middle {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference middle]];
}

- (WKReference *)last {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference last]];
}

- (WKReference *)any {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference any]];
}


/* by-index, by-name, by-id selectors */

- (WKReference *)at:(int)index {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: index]];
}

- (WKReference *)byIndex:(id)index {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byIndex: index]];
}

- (WKReference *)byName:(id)name {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byName: name]];
}

- (WKReference *)byID:(id)id_ {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byID: id_]];
}


/* by-relative-position selectors */

- (WKReference *)previous:(ASConstant *)class_ {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference previous: [class_ AS_code]]];
}

- (WKReference *)next:(ASConstant *)class_ {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference next: [class_ AS_code]]];
}


/* by-range selector */

- (WKReference *)at:(int)fromIndex to:(int)toIndex {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: fromIndex to: toIndex]];
}

- (WKReference *)byRange:(id)fromObject to:(id)toObject {
    // takes two con-based references, with other values being expanded as necessary
    if ([fromObject isKindOfClass: [WKReference class]])
        fromObject = [fromObject AS_aemReference];
    if ([toObject isKindOfClass: [WKReference class]])
        toObject = [toObject AS_aemReference];
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byRange: fromObject to: toObject]];
}


/* by-test selector */

- (WKReference *)byTest:(WKReference *)testReference {
    return [WKReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference byTest: [testReference AS_aemReference]]];
}


/* insertion location selectors */

- (WKReference *)beginning {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginning]];
}

- (WKReference *)end {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference end]];
}

- (WKReference *)before {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference before]];
}

- (WKReference *)after {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference after]];
}


/* Comparison and logic tests */

- (WKReference *)greaterThan:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterThan: object]];
}

- (WKReference *)greaterOrEquals:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterOrEquals: object]];
}

- (WKReference *)equals:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference equals: object]];
}

- (WKReference *)notEquals:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference notEquals: object]];
}

- (WKReference *)lessThan:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessThan: object]];
}

- (WKReference *)lessOrEquals:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessOrEquals: object]];
}

- (WKReference *)beginsWith:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginsWith: object]];
}

- (WKReference *)endsWith:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference endsWith: object]];
}

- (WKReference *)contains:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference contains: object]];
}

- (WKReference *)isIn:(id)object {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference isIn: object]];
}

- (WKReference *)AND:(id)remainingOperands {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference AND: remainingOperands]];
}

- (WKReference *)OR:(id)remainingOperands {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference OR: remainingOperands]];
}

- (WKReference *)NOT {
    return [WKReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference NOT]];
}

@end

