/*
 * CMReferenceGlue.m
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import "CMReferenceGlue.h"

@implementation CMReference

/* +app, +con, +its methods can be used in place of CMApp, CMCon, CMIts macros */

+ (CMReference *)app {
    return [self referenceWithAppData: nil aemReference: AEMApp];
}

+ (CMReference *)con {
    return [self referenceWithAppData: nil aemReference: AEMCon];
}

+ (CMReference *)its {
    return [self referenceWithAppData: nil aemReference: AEMIts];
}


/* ********************************* */

- (NSString *)description {
    return [CMReferenceRenderer formatObject: AS_aemReference appData: AS_appData];
}


/* Commands */

- (CMDeprecatedOpenURLCommand *)DeprecatedOpenURL {
    return [CMDeprecatedOpenURLCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'OURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMDeprecatedOpenURLCommand *)DeprecatedOpenURL:(id)directParameter {
    return [CMDeprecatedOpenURLCommand commandWithAppData: AS_appData
                         eventClass: 'WWW!'
                            eventID: 'OURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMActivateCommand *)activate {
    return [CMActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMActivateCommand *)activate:(id)directParameter {
    return [CMActivateCommand commandWithAppData: AS_appData
                         eventClass: 'misc'
                            eventID: 'actv'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMCloseCommand *)close {
    return [CMCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMCloseCommand *)close:(id)directParameter {
    return [CMCloseCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clos'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMCountCommand *)count {
    return [CMCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMCountCommand *)count:(id)directParameter {
    return [CMCountCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'cnte'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMDeleteCommand *)delete {
    return [CMDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMDeleteCommand *)delete:(id)directParameter {
    return [CMDeleteCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'delo'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMDuplicateCommand *)duplicate {
    return [CMDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMDuplicateCommand *)duplicate:(id)directParameter {
    return [CMDuplicateCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'clon'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMExistsCommand *)exists {
    return [CMExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMExistsCommand *)exists:(id)directParameter {
    return [CMExistsCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'doex'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMGetCommand *)get {
    return [CMGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMGetCommand *)get:(id)directParameter {
    return [CMGetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'getd'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMLaunchCommand *)launch {
    return [CMLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMLaunchCommand *)launch:(id)directParameter {
    return [CMLaunchCommand commandWithAppData: AS_appData
                         eventClass: 'ascr'
                            eventID: 'noop'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMMakeCommand *)make {
    return [CMMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMMakeCommand *)make:(id)directParameter {
    return [CMMakeCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'crel'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMMoveCommand *)move {
    return [CMMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMMoveCommand *)move:(id)directParameter {
    return [CMMoveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'move'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMOpenCommand *)open {
    return [CMOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMOpenCommand *)open:(id)directParameter {
    return [CMOpenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'odoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMOpenLocationCommand *)openLocation {
    return [CMOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMOpenLocationCommand *)openLocation:(id)directParameter {
    return [CMOpenLocationCommand commandWithAppData: AS_appData
                         eventClass: 'GURL'
                            eventID: 'GURL'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMPrintCommand *)print {
    return [CMPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMPrintCommand *)print:(id)directParameter {
    return [CMPrintCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'pdoc'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMQuitCommand *)quit {
    return [CMQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMQuitCommand *)quit:(id)directParameter {
    return [CMQuitCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'quit'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMReopenCommand *)reopen {
    return [CMReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMReopenCommand *)reopen:(id)directParameter {
    return [CMReopenCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'rapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMRunCommand *)run {
    return [CMRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMRunCommand *)run:(id)directParameter {
    return [CMRunCommand commandWithAppData: AS_appData
                         eventClass: 'aevt'
                            eventID: 'oapp'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMSaveCommand *)save {
    return [CMSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMSaveCommand *)save:(id)directParameter {
    return [CMSaveCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'save'
                    directParameter: directParameter
                    parentReference: self];
}

- (CMSetCommand *)set {
    return [CMSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: kASNoDirectParameter
                    parentReference: self];
}

- (CMSetCommand *)set:(id)directParameter {
    return [CMSetCommand commandWithAppData: AS_appData
                         eventClass: 'core'
                            eventID: 'setd'
                    directParameter: directParameter
                    parentReference: self];
}


/* Elements */

- (CMReference *)applications {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'capp']];
}

- (CMReference *)bookmarkFolders {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'BMFl']];
}

- (CMReference *)bookmarkItems {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'BMIt']];
}

- (CMReference *)bookmarks {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'BMBk']];
}

- (CMReference *)browserWindows {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'BWin']];
}

- (CMReference *)items {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cobj']];
}

- (CMReference *)tabs {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'BTab']];
}

- (CMReference *)text {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'pTxt']];
}

- (CMReference *)windows {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference elements: 'cwin']];
}


/* Properties */

- (CMReference *)URL {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pURL']];
}

- (CMReference *)addressBookCollection {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'fadb']];
}

- (CMReference *)bonjourCollection {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'fbjr']];
}

- (CMReference *)bookmarkBarCollection {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'fbar']];
}

- (CMReference *)bookmarkMenuCollection {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'fmnu']];
}

- (CMReference *)bounds {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pbnd']];
}

- (CMReference *)class_ {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pcls']];
}

- (CMReference *)closeable {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'hclb']];
}

- (CMReference *)currentTab {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pCTb']];
}

- (CMReference *)description_ {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pdes']];
}

- (CMReference *)floating {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'isfl']];
}

- (CMReference *)frontmost {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pisf']];
}

- (CMReference *)id_ {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ID  ']];
}

- (CMReference *)index {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pidx']];
}

- (CMReference *)lastVisitDate {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvst']];
}

- (CMReference *)miniaturizable {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ismn']];
}

- (CMReference *)miniaturized {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmnd']];
}

- (CMReference *)modal {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pmod']];
}

- (CMReference *)name {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pnam']];
}

- (CMReference *)properties {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pALL']];
}

- (CMReference *)resizable {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'prsz']];
}

- (CMReference *)selectedSource {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pSSr']];
}

- (CMReference *)selectedText {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pSTx']];
}

- (CMReference *)shortcut {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'psht']];
}

- (CMReference *)source {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pSrc']];
}

- (CMReference *)title {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pTtl']];
}

- (CMReference *)titled {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ptit']];
}

- (CMReference *)topTenCollection {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'ftop']];
}

- (CMReference *)version_ {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'vers']];
}

- (CMReference *)visible {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvis']];
}

- (CMReference *)visitCount {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pvct']];
}

- (CMReference *)zoomable {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'iszm']];
}

- (CMReference *)zoomed {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference property: 'pzum']];
}


/* ********************************* */


/* ordinal selectors */

- (CMReference *)first {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference first]];
}

- (CMReference *)middle {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference middle]];
}

- (CMReference *)last {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference last]];
}

- (CMReference *)any {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference any]];
}


/* by-index, by-name, by-id selectors */

- (CMReference *)at:(int)index {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: index]];
}

- (CMReference *)byIndex:(id)index {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byIndex: index]];
}

- (CMReference *)byName:(id)name {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byName: name]];
}

- (CMReference *)byID:(id)id_ {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byID: id_]];
}


/* by-relative-position selectors */

- (CMReference *)previous:(ASConstant *)class_ {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference previous: [class_ AS_code]]];
}

- (CMReference *)next:(ASConstant *)class_ {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference next: [class_ AS_code]]];
}


/* by-range selector */

- (CMReference *)at:(int)fromIndex to:(int)toIndex {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference at: fromIndex to: toIndex]];
}

- (CMReference *)byRange:(id)fromObject to:(id)toObject {
    // takes two con-based references, with other values being expanded as necessary
    if ([fromObject isKindOfClass: [CMReference class]])
        fromObject = [fromObject AS_aemReference];
    if ([toObject isKindOfClass: [CMReference class]])
        toObject = [toObject AS_aemReference];
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference byRange: fromObject to: toObject]];
}


/* by-test selector */

- (CMReference *)byTest:(CMReference *)testReference {
    return [CMReference referenceWithAppData: AS_appData
                    aemReference: [AS_aemReference byTest: [testReference AS_aemReference]]];
}


/* insertion location selectors */

- (CMReference *)beginning {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginning]];
}

- (CMReference *)end {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference end]];
}

- (CMReference *)before {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference before]];
}

- (CMReference *)after {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference after]];
}


/* Comparison and logic tests */

- (CMReference *)greaterThan:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterThan: object]];
}

- (CMReference *)greaterOrEquals:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference greaterOrEquals: object]];
}

- (CMReference *)equals:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference equals: object]];
}

- (CMReference *)notEquals:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference notEquals: object]];
}

- (CMReference *)lessThan:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessThan: object]];
}

- (CMReference *)lessOrEquals:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference lessOrEquals: object]];
}

- (CMReference *)beginsWith:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference beginsWith: object]];
}

- (CMReference *)endsWith:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference endsWith: object]];
}

- (CMReference *)contains:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference contains: object]];
}

- (CMReference *)isIn:(id)object {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference isIn: object]];
}

- (CMReference *)AND:(id)remainingOperands {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference AND: remainingOperands]];
}

- (CMReference *)OR:(id)remainingOperands {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference OR: remainingOperands]];
}

- (CMReference *)NOT {
    return [CMReference referenceWithAppData: AS_appData
                                 aemReference: [AS_aemReference NOT]];
}

@end

