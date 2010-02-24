/*
 * OPReferenceRendererGlue.m
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import "OPReferenceRendererGlue.h"

@implementation OPReferenceRenderer
- (NSString *)propertyByCode:(OSType)code {
    switch (code) {
        case 'pbnd': return @"bounds";
        case 'pcls': return @"class_";
        case 'hclb': return @"closeable";
        case 'isfl': return @"floating";
        case 'ID  ': return @"id_";
        case 'pidx': return @"index";
        case 'LOad': return @"loading";
        case 'ismn': return @"miniaturizable";
        case 'minU': return @"miniaturized";
        case 'pmod': return @"modal";
        case 'imod': return @"modified";
        case 'pnam': return @"name";
        case 'pALL': return @"properties";
        case 'prsz': return @"resizable";
        case 'ptit': return @"titled";
        case 'url ': return @"url";
        case 'pvis': return @"visible";
        case 'wndw': return @"window";
        case 'iszm': return @"zoomable";
        case 'pzum': return @"zoomed";
        default: return nil;
    }
}

- (NSString *)elementByCode:(OSType)code {
    switch (code) {
        case 'capp': return @"application";
        case 'docu': return @"document";
        case 'cobj': return @"items";
        case 'cwin': return @"window";
        default: return nil;
    }
}

- (NSString *)prefix {
    return @"OP";
}

@end

