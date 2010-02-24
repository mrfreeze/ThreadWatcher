/*
 * CMReferenceRendererGlue.m
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import "CMReferenceRendererGlue.h"

@implementation CMReferenceRenderer
- (NSString *)propertyByCode:(OSType)code {
    switch (code) {
        case 'pURL': return @"URL";
        case 'fadb': return @"addressBookCollection";
        case 'fbjr': return @"bonjourCollection";
        case 'fbar': return @"bookmarkBarCollection";
        case 'fmnu': return @"bookmarkMenuCollection";
        case 'pbnd': return @"bounds";
        case 'pcls': return @"class_";
        case 'hclb': return @"closeable";
        case 'pCTb': return @"currentTab";
        case 'pdes': return @"description_";
        case 'isfl': return @"floating";
        case 'pisf': return @"frontmost";
        case 'ID  ': return @"id_";
        case 'pidx': return @"index";
        case 'pvst': return @"lastVisitDate";
        case 'ismn': return @"miniaturizable";
        case 'pmnd': return @"miniaturized";
        case 'pmod': return @"modal";
        case 'pnam': return @"name";
        case 'pALL': return @"properties";
        case 'prsz': return @"resizable";
        case 'pSSr': return @"selectedSource";
        case 'pSTx': return @"selectedText";
        case 'psht': return @"shortcut";
        case 'pSrc': return @"source";
        case 'pTxt': return @"text";
        case 'pTtl': return @"title";
        case 'ptit': return @"titled";
        case 'ftop': return @"topTenCollection";
        case 'vers': return @"version_";
        case 'pvis': return @"visible";
        case 'pvct': return @"visitCount";
        case 'iszm': return @"zoomable";
        case 'pzum': return @"zoomed";
        default: return nil;
    }
}

- (NSString *)elementByCode:(OSType)code {
    switch (code) {
        case 'capp': return @"applications";
        case 'BMFl': return @"bookmarkFolders";
        case 'BMIt': return @"bookmarkItems";
        case 'BMBk': return @"bookmarks";
        case 'BWin': return @"browserWindows";
        case 'cobj': return @"items";
        case 'BTab': return @"tabs";
        case 'cwin': return @"windows";
        default: return nil;
    }
}

- (NSString *)prefix {
    return @"CM";
}

@end

