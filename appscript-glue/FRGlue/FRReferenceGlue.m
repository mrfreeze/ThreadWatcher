/*
 * FRReferenceGlue.m
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import "FRReferenceGlue.h"

@implementation FRReference

/* +app, +con, +its methods can be used in place of FRApp, FRCon, FRIts macros */

+ (FRReference *)app {
    return [self referenceWithAppData: nil aemReference: AEMApp];
}

+ (FRReference *)con {
    return [self referenceWithAppData: nil aemReference: AEMCon];
}

+ (FRReference *)its {
    return [self referenceWithAppData: nil aemReference: AEMIts];
}


/* ********************************* */

- (NSString *)description {
    return [FRReferenceRenderer formatObject: AS_aemReference appData: AS_appData];
}


/* Commands */

- (FRActivateCommand *)activate {
    return [FRActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRActivateCommand *)activate:(id)directParameter {
    return [FRActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRCloseCommand *)close {
    return [FRCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRCloseCommand *)close:(id)directParameter {
    return [FRCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRCountCommand *)count {
    return [FRCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRCountCommand *)count:(id)directParameter {
    return [FRCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRDeleteCommand *)delete {
    return [FRDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRDeleteCommand *)delete:(id)directParameter {
    return [FRDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRDuplicateCommand *)duplicate {
    return [FRDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRDuplicateCommand *)duplicate:(id)directParameter {
    return [FRDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRExistsCommand *)exists {
    return [FRExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRExistsCommand *)exists:(id)directParameter {
    return [FRExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRGetCommand *)get {
    return [FRGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRGetCommand *)get:(id)directParameter {
    return [FRGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRLaunchCommand *)launch {
    return [FRLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRLaunchCommand *)launch:(id)directParameter {
    return [FRLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRMakeCommand *)make {
    return [FRMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRMakeCommand *)make:(id)directParameter {
    return [FRMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRMoveCommand *)move {
    return [FRMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRMoveCommand *)move:(id)directParameter {
    return [FRMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: directParameter
                    parentReference: self];
}

- (FROpenCommand *)open {
    return [FROpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FROpenCommand *)open:(id)directParameter {
    return [FROpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (FROpenLocationCommand *)openLocation {
    return [FROpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FROpenLocationCommand *)openLocation:(id)directParameter {
    return [FROpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRPrintCommand *)print {
    return [FRPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRPrintCommand *)print:(id)directParameter {
    return [FRPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRQuitCommand *)quit {
    return [FRQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRQuitCommand *)quit:(id)directParameter {
    return [FRQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRReopenCommand *)reopen {
    return [FRReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRReopenCommand *)reopen:(id)directParameter {
    return [FRReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRRunCommand *)run {
    return [FRRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRRunCommand *)run:(id)directParameter {
    return [FRRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRSaveCommand *)save {
    return [FRSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRSaveCommand *)save:(id)directParameter {
    return [FRSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: directParameter
                    parentReference: self];
}

- (FRSetCommand *)set {
    return [FRSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (FRSetCommand *)set:(id)directParameter {
    return [FRSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: directParameter
                    parentReference: self];
}


/* Elements */

- (FRReference *)applications {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'capp']];
}

- (FRReference *)attachment {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'atts']];
}

- (FRReference *)attributeRuns {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'catr']];
}

- (FRReference *)characters {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cha ']];
}

- (FRReference *)colors {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'colr']];
}

- (FRReference *)documents {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'docu']];
}

- (FRReference *)items {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cobj']];
}

- (FRReference *)paragraphs {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cpar']];
}

- (FRReference *)printSettings {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'pset']];
}

- (FRReference *)text {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'ctxt']];
}

- (FRReference *)windows {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cwin']];
}

- (FRReference *)words {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cwor']];
}


/* Properties */

- (FRReference *)bounds {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pbnd']];
}

- (FRReference *)class_ {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pcls']];
}

- (FRReference *)closeable {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'hclb']];
}

- (FRReference *)collating {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwcl']];
}

- (FRReference *)color {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'colr']];
}

- (FRReference *)copies {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwcp']];
}

- (FRReference *)document {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'docu']];
}

- (FRReference *)endingPage {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwlp']];
}

- (FRReference *)errorHandling {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lweh']];
}

- (FRReference *)faxNumber {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'faxn']];
}

- (FRReference *)fileName {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'atfn']];
}

- (FRReference *)floating {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'isfl']];
}

- (FRReference *)font {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'font']];
}

- (FRReference *)frontmost {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pisf']];
}

- (FRReference *)id_ {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ID  ']];
}

- (FRReference *)index {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pidx']];
}

- (FRReference *)miniaturizable {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ismn']];
}

- (FRReference *)miniaturized {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmnd']];
}

- (FRReference *)modal {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmod']];
}

- (FRReference *)modified {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'imod']];
}

- (FRReference *)name {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pnam']];
}

- (FRReference *)pagesAcross {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwla']];
}

- (FRReference *)pagesDown {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwld']];
}

- (FRReference *)path {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ppth']];
}

- (FRReference *)properties {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pALL']];
}

- (FRReference *)requestedPrintTime {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwqt']];
}

- (FRReference *)resizable {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'prsz']];
}

- (FRReference *)size {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptsz']];
}

- (FRReference *)startingPage {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'lwfp']];
}

- (FRReference *)targetPrinter {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'trpr']];
}

- (FRReference *)titled {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptit']];
}

- (FRReference *)version_ {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'vers']];
}

- (FRReference *)visible {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvis']];
}

- (FRReference *)zoomable {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'iszm']];
}

- (FRReference *)zoomed {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pzum']];
}


/* ********************************* */


/* ordinal selectors */

- (FRReference *)first {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference first]];
}

- (FRReference *)middle {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference middle]];
}

- (FRReference *)last {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference last]];
}

- (FRReference *)any {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference any]];
}


/* by-index, by-name, by-id selectors */

- (FRReference *)at:(int)index {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: index]];
}

- (FRReference *)byIndex:(id)index {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byIndex: index]];
}

- (FRReference *)byName:(id)name {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byName: name]];
}

- (FRReference *)byID:(id)id_ {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byID: id_]];
}


/* by-relative-position selectors */

- (FRReference *)previous:(ASConstant *)class_ {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference previous: [class_ AS_code]]];
}

- (FRReference *)next:(ASConstant *)class_ {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference next: [class_ AS_code]]];
}


/* by-range selector */

- (FRReference *)at:(int)fromIndex to:(int)toIndex {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: fromIndex to: toIndex]];
}

- (FRReference *)byRange:(id)fromObject to:(id)toObject {
    // takes two con-based references, with other values being expanded as necessary
    if ([fromObject isKindOfClass: [FRReference class]])
        fromObject = [fromObject AS_aemReference];
    if ([toObject isKindOfClass: [FRReference class]])
        toObject = [toObject AS_aemReference];
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byRange: fromObject to: toObject]];
}


/* by-test selector */

- (FRReference *)byTest:(FRReference *)testReference {
    return [FRReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference byTest: [testReference AS_aemReference]]];
}


/* insertion location selectors */

- (FRReference *)beginning {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginning]];
}

- (FRReference *)end {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference end]];
}

- (FRReference *)before {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference before]];
}

- (FRReference *)after {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference after]];
}


/* Comparison and logic tests */

- (FRReference *)greaterThan:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterThan: object]];
}

- (FRReference *)greaterOrEquals:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterOrEquals: object]];
}

- (FRReference *)equals:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference equals: object]];
}

- (FRReference *)notEquals:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference notEquals: object]];
}

- (FRReference *)lessThan:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessThan: object]];
}

- (FRReference *)lessOrEquals:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessOrEquals: object]];
}

- (FRReference *)beginsWith:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginsWith: object]];
}

- (FRReference *)endsWith:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference endsWith: object]];
}

- (FRReference *)contains:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference contains: object]];
}

- (FRReference *)isIn:(id)object {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference isIn: object]];
}

- (FRReference *)AND:(id)remainingOperands {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference AND: remainingOperands]];
}

- (FRReference *)OR:(id)remainingOperands {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference OR: remainingOperands]];
}

- (FRReference *)NOT {
    return [FRReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference NOT]];
}

@end

