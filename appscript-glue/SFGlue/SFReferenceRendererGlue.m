/*
 * SFReferenceRendererGlue.m
 * /Applications/Safari.app
 * osaglue 0.5.1
 *
 */

#import "SFReferenceRendererGlue.h"

@implementation SFReferenceRenderer
- (NSString *)propertyByCode:(OSType)code {
    switch (code) {
        case 'pURL': return @"URL";
        case 'pbnd': return @"bounds";
        case 'pcls': return @"class_";
        case 'hclb': return @"closeable";
        case 'lwcl': return @"collating";
        case 'colr': return @"color";
        case 'lwcp': return @"copies";
        case 'cTab': return @"currentTab";
        case 'docu': return @"document";
        case 'lwlp': return @"endingPage";
        case 'lweh': return @"errorHandling";
        case 'faxn': return @"faxNumber";
        case 'atfn': return @"fileName";
        case 'isfl': return @"floating";
        case 'font': return @"font";
        case 'pisf': return @"frontmost";
        case 'ID  ': return @"id_";
        case 'pidx': return @"index";
        case 'ismn': return @"miniaturizable";
        case 'pmnd': return @"miniaturized";
        case 'pmod': return @"modal";
        case 'imod': return @"modified";
        case 'pnam': return @"name";
        case 'lwla': return @"pagesAcross";
        case 'lwld': return @"pagesDown";
        case 'ppth': return @"path";
        case 'pALL': return @"properties";
        case 'lwqt': return @"requestedPrintTime";
        case 'prsz': return @"resizable";
        case 'ptsz': return @"size";
        case 'conT': return @"source";
        case 'lwfp': return @"startingPage";
        case 'trpr': return @"targetPrinter";
        case 'ctxt': return @"text";
        case 'ptit': return @"titled";
        case 'vers': return @"version_";
        case 'pvis': return @"visible";
        case 'iszm': return @"zoomable";
        case 'pzum': return @"zoomed";
        default: return nil;
    }
}

- (NSString *)elementByCode:(OSType)code {
    switch (code) {
        case 'capp': return @"applications";
        case 'atts': return @"attachment";
        case 'catr': return @"attributeRuns";
        case 'cha ': return @"characters";
        case 'colr': return @"colors";
        case 'docu': return @"documents";
        case 'cobj': return @"items";
        case 'cpar': return @"paragraphs";
        case 'pset': return @"printSettings";
        case 'bTab': return @"tabs";
        case 'ctxt': return @"text";
        case 'cwin': return @"windows";
        case 'cwor': return @"words";
        default: return nil;
    }
}

- (NSString *)prefix {
    return @"SF";
}

@end

