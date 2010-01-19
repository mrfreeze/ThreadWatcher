/*
 * WKConstantGlue.m
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import "WKConstantGlue.h"

@implementation WKConstant
+ (id)constantWithCode:(OSType)code_ {
    switch (code_) {
        case 'apr ': return [self April];
        case 'aug ': return [self August];
        case 'dec ': return [self December];
        case 'EPS ': return [self EPSPicture];
        case 'feb ': return [self February];
        case 'fri ': return [self Friday];
        case 'GIFf': return [self GIFPicture];
        case 'JPEG': return [self JPEGPicture];
        case 'jan ': return [self January];
        case 'jul ': return [self July];
        case 'jun ': return [self June];
        case 'mar ': return [self March];
        case 'may ': return [self May];
        case 'mon ': return [self Monday];
        case 'nov ': return [self November];
        case 'oct ': return [self October];
        case 'PICT': return [self PICTPicture];
        case 'tr16': return [self RGB16Color];
        case 'tr96': return [self RGB96Color];
        case 'cRGB': return [self RGBColor];
        case 'sat ': return [self Saturday];
        case 'sep ': return [self September];
        case 'sun ': return [self Sunday];
        case 'TIFF': return [self TIFFPicture];
        case 'thu ': return [self Thursday];
        case 'tue ': return [self Tuesday];
        case 'pURL': return [self URL];
        case 'wed ': return [self Wednesday];
        case 'alis': return [self alias];
        case '****': return [self anything];
        case 'capp': return [self application];
        case 'bund': return [self applicationBundleID];
        case 'rmte': return [self applicationResponses];
        case 'sign': return [self applicationSignature];
        case 'aprl': return [self applicationURL];
        case 'ask ': return [self ask];
        case 'atts': return [self attachment];
        case 'catr': return [self attributeRun];
        case 'best': return [self best];
        case 'bool': return [self boolean];
        case 'qdrt': return [self boundingRectangle];
        case 'pbnd': return [self bounds];
        case 'case': return [self case_];
        case 'cmtr': return [self centimeters];
        case 'cha ': return [self character];
        case 'gcli': return [self classInfo];
        case 'pcls': return [self class_];
        case 'hclb': return [self closeable];
        case 'lwcl': return [self collating];
        case 'colr': return [self color];
        case 'clrt': return [self colorTable];
        case 'lwcp': return [self copies];
        case 'ccmt': return [self cubicCentimeters];
        case 'cfet': return [self cubicFeet];
        case 'cuin': return [self cubicInches];
        case 'cmet': return [self cubicMeters];
        case 'cyrd': return [self cubicYards];
        case 'cTab': return [self currentTab];
        case 'tdas': return [self dashStyle];
        case 'rdat': return [self data];
        case 'ldt ': return [self date];
        case 'decm': return [self decimalStruct];
        case 'degc': return [self degreesCelsius];
        case 'degf': return [self degreesFahrenheit];
        case 'degk': return [self degreesKelvin];
        case 'lwdt': return [self detailed];
        case 'diac': return [self diacriticals];
        case 'docu': return [self document];
        case 'comp': return [self doubleInteger];
        case 'elin': return [self elementInfo];
        case 'encs': return [self encodedString];
        case 'lwlp': return [self endingPage];
        case 'enum': return [self enumerator];
        case 'lweh': return [self errorHandling];
        case 'evin': return [self eventInfo];
        case 'expa': return [self expansion];
        case 'exte': return [self extendedFloat];
        case 'faxn': return [self faxNumber];
        case 'feet': return [self feet];
        case 'atfn': return [self fileName];
        case 'fsrf': return [self fileRef];
        case 'fss ': return [self fileSpecification];
        case 'furl': return [self fileURL];
        case 'fixd': return [self fixed];
        case 'fpnt': return [self fixedPoint];
        case 'frct': return [self fixedRectangle];
        case 'ldbl': return [self float128bit];
        case 'doub': return [self float_];
        case 'isfl': return [self floating];
        case 'font': return [self font];
        case 'pisf': return [self frontmost];
        case 'galn': return [self gallons];
        case 'gram': return [self grams];
        case 'cgtx': return [self graphicText];
        case 'hyph': return [self hyphens];
        case 'ID  ': return [self id_];
        case 'inch': return [self inches];
        case 'pidx': return [self index];
        case 'long': return [self integer];
        case 'itxt': return [self internationalText];
        case 'intl': return [self internationalWritingCode];
        case 'cobj': return [self item];
        case 'kpid': return [self kernelProcessID];
        case 'kgrm': return [self kilograms];
        case 'kmtr': return [self kilometers];
        case 'list': return [self list];
        case 'litr': return [self liters];
        case 'insl': return [self locationReference];
        case 'lfxd': return [self longFixed];
        case 'lfpt': return [self longFixedPoint];
        case 'lfrc': return [self longFixedRectangle];
        case 'lpnt': return [self longPoint];
        case 'lrct': return [self longRectangle];
        case 'port': return [self machPort];
        case 'mach': return [self machine];
        case 'mLoc': return [self machineLocation];
        case 'metr': return [self meters];
        case 'mile': return [self miles];
        case 'ismn': return [self miniaturizable];
        case 'pmnd': return [self miniaturized];
        case 'msng': return [self missingValue];
        case 'pmod': return [self modal];
        case 'imod': return [self modified];
        case 'pnam': return [self name];
        case 'no  ': return [self no];
        case 'null': return [self null];
        case 'nume': return [self numericStrings];
        case 'ozs ': return [self ounces];
        case 'lwla': return [self pagesAcross];
        case 'lwld': return [self pagesDown];
        case 'cpar': return [self paragraph];
        case 'pmin': return [self parameterInfo];
        case 'ppth': return [self path];
        case 'tpmm': return [self pixelMapRecord];
        case 'QDpt': return [self point];
        case 'lbs ': return [self pounds];
        case 'pset': return [self printSettings];
        case 'psn ': return [self processSerialNumber];
        case 'pALL': return [self properties];
        case 'prop': return [self property];
        case 'pinf': return [self propertyInfo];
        case 'punc': return [self punctuation];
        case 'qrts': return [self quarts];
        case 'reco': return [self record];
        case 'obj ': return [self reference];
        case 'lwqt': return [self requestedPrintTime];
        case 'prsz': return [self resizable];
        case 'trot': return [self rotation];
        case 'scpt': return [self script];
        case 'sing': return [self shortFloat];
        case 'shor': return [self shortInteger];
        case 'ptsz': return [self size];
        case 'conT': return [self source];
        case 'sqft': return [self squareFeet];
        case 'sqkm': return [self squareKilometers];
        case 'sqrm': return [self squareMeters];
        case 'sqmi': return [self squareMiles];
        case 'sqyd': return [self squareYards];
        case 'lwst': return [self standard];
        case 'lwfp': return [self startingPage];
        case 'TEXT': return [self string];
        case 'styl': return [self styledClipboardText];
        case 'STXT': return [self styledText];
        case 'suin': return [self suiteInfo];
        case 'bTab': return [self tab];
        case 'trpr': return [self targetPrinter];
        case 'ctxt': return [self text];
        case 'tsty': return [self textStyleInfo];
        case 'ptit': return [self titled];
        case 'type': return [self typeClass];
        case 'utxt': return [self unicodeText];
        case 'magn': return [self unsignedInteger];
        case 'ut16': return [self utf16Text];
        case 'utf8': return [self utf8Text];
        case 'vers': return [self version_];
        case 'pvis': return [self visible];
        case 'whit': return [self whitespace];
        case 'cwin': return [self window];
        case 'cwor': return [self word];
        case 'psct': return [self writingCode];
        case 'yard': return [self yards];
        case 'yes ': return [self yes];
        case 'iszm': return [self zoomable];
        case 'pzum': return [self zoomed];
        default: return [[self superclass] constantWithCode: code_];
    }
}


/* Enumerators */

+ (WKConstant *)applicationResponses {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"applicationResponses" type: typeEnumerated code: 'rmte'];
    return constantObj;
}

+ (WKConstant *)ask {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"ask" type: typeEnumerated code: 'ask '];
    return constantObj;
}

+ (WKConstant *)case_ {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"case_" type: typeEnumerated code: 'case'];
    return constantObj;
}

+ (WKConstant *)detailed {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"detailed" type: typeEnumerated code: 'lwdt'];
    return constantObj;
}

+ (WKConstant *)diacriticals {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"diacriticals" type: typeEnumerated code: 'diac'];
    return constantObj;
}

+ (WKConstant *)expansion {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"expansion" type: typeEnumerated code: 'expa'];
    return constantObj;
}

+ (WKConstant *)hyphens {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"hyphens" type: typeEnumerated code: 'hyph'];
    return constantObj;
}

+ (WKConstant *)no {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"no" type: typeEnumerated code: 'no  '];
    return constantObj;
}

+ (WKConstant *)numericStrings {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"numericStrings" type: typeEnumerated code: 'nume'];
    return constantObj;
}

+ (WKConstant *)punctuation {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"punctuation" type: typeEnumerated code: 'punc'];
    return constantObj;
}

+ (WKConstant *)standard {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"standard" type: typeEnumerated code: 'lwst'];
    return constantObj;
}

+ (WKConstant *)whitespace {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"whitespace" type: typeEnumerated code: 'whit'];
    return constantObj;
}

+ (WKConstant *)yes {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"yes" type: typeEnumerated code: 'yes '];
    return constantObj;
}


/* Types and properties */

+ (WKConstant *)April {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"April" type: typeType code: 'apr '];
    return constantObj;
}

+ (WKConstant *)August {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"August" type: typeType code: 'aug '];
    return constantObj;
}

+ (WKConstant *)December {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"December" type: typeType code: 'dec '];
    return constantObj;
}

+ (WKConstant *)EPSPicture {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"EPSPicture" type: typeType code: 'EPS '];
    return constantObj;
}

+ (WKConstant *)February {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"February" type: typeType code: 'feb '];
    return constantObj;
}

+ (WKConstant *)Friday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Friday" type: typeType code: 'fri '];
    return constantObj;
}

+ (WKConstant *)GIFPicture {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"GIFPicture" type: typeType code: 'GIFf'];
    return constantObj;
}

+ (WKConstant *)JPEGPicture {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"JPEGPicture" type: typeType code: 'JPEG'];
    return constantObj;
}

+ (WKConstant *)January {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"January" type: typeType code: 'jan '];
    return constantObj;
}

+ (WKConstant *)July {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"July" type: typeType code: 'jul '];
    return constantObj;
}

+ (WKConstant *)June {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"June" type: typeType code: 'jun '];
    return constantObj;
}

+ (WKConstant *)March {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"March" type: typeType code: 'mar '];
    return constantObj;
}

+ (WKConstant *)May {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"May" type: typeType code: 'may '];
    return constantObj;
}

+ (WKConstant *)Monday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Monday" type: typeType code: 'mon '];
    return constantObj;
}

+ (WKConstant *)November {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"November" type: typeType code: 'nov '];
    return constantObj;
}

+ (WKConstant *)October {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"October" type: typeType code: 'oct '];
    return constantObj;
}

+ (WKConstant *)PICTPicture {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"PICTPicture" type: typeType code: 'PICT'];
    return constantObj;
}

+ (WKConstant *)RGB16Color {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"RGB16Color" type: typeType code: 'tr16'];
    return constantObj;
}

+ (WKConstant *)RGB96Color {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"RGB96Color" type: typeType code: 'tr96'];
    return constantObj;
}

+ (WKConstant *)RGBColor {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"RGBColor" type: typeType code: 'cRGB'];
    return constantObj;
}

+ (WKConstant *)Saturday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Saturday" type: typeType code: 'sat '];
    return constantObj;
}

+ (WKConstant *)September {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"September" type: typeType code: 'sep '];
    return constantObj;
}

+ (WKConstant *)Sunday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Sunday" type: typeType code: 'sun '];
    return constantObj;
}

+ (WKConstant *)TIFFPicture {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"TIFFPicture" type: typeType code: 'TIFF'];
    return constantObj;
}

+ (WKConstant *)Thursday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Thursday" type: typeType code: 'thu '];
    return constantObj;
}

+ (WKConstant *)Tuesday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Tuesday" type: typeType code: 'tue '];
    return constantObj;
}

+ (WKConstant *)URL {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"URL" type: typeType code: 'pURL'];
    return constantObj;
}

+ (WKConstant *)Wednesday {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"Wednesday" type: typeType code: 'wed '];
    return constantObj;
}

+ (WKConstant *)alias {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"alias" type: typeType code: 'alis'];
    return constantObj;
}

+ (WKConstant *)anything {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"anything" type: typeType code: '****'];
    return constantObj;
}

+ (WKConstant *)application {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"application" type: typeType code: 'capp'];
    return constantObj;
}

+ (WKConstant *)applicationBundleID {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"applicationBundleID" type: typeType code: 'bund'];
    return constantObj;
}

+ (WKConstant *)applicationSignature {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"applicationSignature" type: typeType code: 'sign'];
    return constantObj;
}

+ (WKConstant *)applicationURL {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"applicationURL" type: typeType code: 'aprl'];
    return constantObj;
}

+ (WKConstant *)attachment {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"attachment" type: typeType code: 'atts'];
    return constantObj;
}

+ (WKConstant *)attributeRun {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"attributeRun" type: typeType code: 'catr'];
    return constantObj;
}

+ (WKConstant *)best {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"best" type: typeType code: 'best'];
    return constantObj;
}

+ (WKConstant *)boolean {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"boolean" type: typeType code: 'bool'];
    return constantObj;
}

+ (WKConstant *)boundingRectangle {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"boundingRectangle" type: typeType code: 'qdrt'];
    return constantObj;
}

+ (WKConstant *)bounds {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"bounds" type: typeType code: 'pbnd'];
    return constantObj;
}

+ (WKConstant *)centimeters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"centimeters" type: typeType code: 'cmtr'];
    return constantObj;
}

+ (WKConstant *)character {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"character" type: typeType code: 'cha '];
    return constantObj;
}

+ (WKConstant *)classInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"classInfo" type: typeType code: 'gcli'];
    return constantObj;
}

+ (WKConstant *)class_ {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"class_" type: typeType code: 'pcls'];
    return constantObj;
}

+ (WKConstant *)closeable {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"closeable" type: typeType code: 'hclb'];
    return constantObj;
}

+ (WKConstant *)collating {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"collating" type: typeType code: 'lwcl'];
    return constantObj;
}

+ (WKConstant *)color {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"color" type: typeType code: 'colr'];
    return constantObj;
}

+ (WKConstant *)colorTable {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"colorTable" type: typeType code: 'clrt'];
    return constantObj;
}

+ (WKConstant *)copies {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"copies" type: typeType code: 'lwcp'];
    return constantObj;
}

+ (WKConstant *)cubicCentimeters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"cubicCentimeters" type: typeType code: 'ccmt'];
    return constantObj;
}

+ (WKConstant *)cubicFeet {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"cubicFeet" type: typeType code: 'cfet'];
    return constantObj;
}

+ (WKConstant *)cubicInches {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"cubicInches" type: typeType code: 'cuin'];
    return constantObj;
}

+ (WKConstant *)cubicMeters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"cubicMeters" type: typeType code: 'cmet'];
    return constantObj;
}

+ (WKConstant *)cubicYards {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"cubicYards" type: typeType code: 'cyrd'];
    return constantObj;
}

+ (WKConstant *)currentTab {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"currentTab" type: typeType code: 'cTab'];
    return constantObj;
}

+ (WKConstant *)dashStyle {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"dashStyle" type: typeType code: 'tdas'];
    return constantObj;
}

+ (WKConstant *)data {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"data" type: typeType code: 'rdat'];
    return constantObj;
}

+ (WKConstant *)date {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"date" type: typeType code: 'ldt '];
    return constantObj;
}

+ (WKConstant *)decimalStruct {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"decimalStruct" type: typeType code: 'decm'];
    return constantObj;
}

+ (WKConstant *)degreesCelsius {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"degreesCelsius" type: typeType code: 'degc'];
    return constantObj;
}

+ (WKConstant *)degreesFahrenheit {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"degreesFahrenheit" type: typeType code: 'degf'];
    return constantObj;
}

+ (WKConstant *)degreesKelvin {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"degreesKelvin" type: typeType code: 'degk'];
    return constantObj;
}

+ (WKConstant *)document {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"document" type: typeType code: 'docu'];
    return constantObj;
}

+ (WKConstant *)doubleInteger {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"doubleInteger" type: typeType code: 'comp'];
    return constantObj;
}

+ (WKConstant *)elementInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"elementInfo" type: typeType code: 'elin'];
    return constantObj;
}

+ (WKConstant *)encodedString {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"encodedString" type: typeType code: 'encs'];
    return constantObj;
}

+ (WKConstant *)endingPage {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"endingPage" type: typeType code: 'lwlp'];
    return constantObj;
}

+ (WKConstant *)enumerator {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"enumerator" type: typeType code: 'enum'];
    return constantObj;
}

+ (WKConstant *)errorHandling {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"errorHandling" type: typeType code: 'lweh'];
    return constantObj;
}

+ (WKConstant *)eventInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"eventInfo" type: typeType code: 'evin'];
    return constantObj;
}

+ (WKConstant *)extendedFloat {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"extendedFloat" type: typeType code: 'exte'];
    return constantObj;
}

+ (WKConstant *)faxNumber {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"faxNumber" type: typeType code: 'faxn'];
    return constantObj;
}

+ (WKConstant *)feet {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"feet" type: typeType code: 'feet'];
    return constantObj;
}

+ (WKConstant *)fileName {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fileName" type: typeType code: 'atfn'];
    return constantObj;
}

+ (WKConstant *)fileRef {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fileRef" type: typeType code: 'fsrf'];
    return constantObj;
}

+ (WKConstant *)fileSpecification {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fileSpecification" type: typeType code: 'fss '];
    return constantObj;
}

+ (WKConstant *)fileURL {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fileURL" type: typeType code: 'furl'];
    return constantObj;
}

+ (WKConstant *)fixed {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fixed" type: typeType code: 'fixd'];
    return constantObj;
}

+ (WKConstant *)fixedPoint {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fixedPoint" type: typeType code: 'fpnt'];
    return constantObj;
}

+ (WKConstant *)fixedRectangle {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"fixedRectangle" type: typeType code: 'frct'];
    return constantObj;
}

+ (WKConstant *)float128bit {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"float128bit" type: typeType code: 'ldbl'];
    return constantObj;
}

+ (WKConstant *)float_ {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"float_" type: typeType code: 'doub'];
    return constantObj;
}

+ (WKConstant *)floating {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"floating" type: typeType code: 'isfl'];
    return constantObj;
}

+ (WKConstant *)font {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"font" type: typeType code: 'font'];
    return constantObj;
}

+ (WKConstant *)frontmost {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"frontmost" type: typeType code: 'pisf'];
    return constantObj;
}

+ (WKConstant *)gallons {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"gallons" type: typeType code: 'galn'];
    return constantObj;
}

+ (WKConstant *)grams {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"grams" type: typeType code: 'gram'];
    return constantObj;
}

+ (WKConstant *)graphicText {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"graphicText" type: typeType code: 'cgtx'];
    return constantObj;
}

+ (WKConstant *)id_ {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"id_" type: typeType code: 'ID  '];
    return constantObj;
}

+ (WKConstant *)inches {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"inches" type: typeType code: 'inch'];
    return constantObj;
}

+ (WKConstant *)index {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"index" type: typeType code: 'pidx'];
    return constantObj;
}

+ (WKConstant *)integer {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"integer" type: typeType code: 'long'];
    return constantObj;
}

+ (WKConstant *)internationalText {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"internationalText" type: typeType code: 'itxt'];
    return constantObj;
}

+ (WKConstant *)internationalWritingCode {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"internationalWritingCode" type: typeType code: 'intl'];
    return constantObj;
}

+ (WKConstant *)item {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"item" type: typeType code: 'cobj'];
    return constantObj;
}

+ (WKConstant *)kernelProcessID {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"kernelProcessID" type: typeType code: 'kpid'];
    return constantObj;
}

+ (WKConstant *)kilograms {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"kilograms" type: typeType code: 'kgrm'];
    return constantObj;
}

+ (WKConstant *)kilometers {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"kilometers" type: typeType code: 'kmtr'];
    return constantObj;
}

+ (WKConstant *)list {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"list" type: typeType code: 'list'];
    return constantObj;
}

+ (WKConstant *)liters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"liters" type: typeType code: 'litr'];
    return constantObj;
}

+ (WKConstant *)locationReference {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"locationReference" type: typeType code: 'insl'];
    return constantObj;
}

+ (WKConstant *)longFixed {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"longFixed" type: typeType code: 'lfxd'];
    return constantObj;
}

+ (WKConstant *)longFixedPoint {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"longFixedPoint" type: typeType code: 'lfpt'];
    return constantObj;
}

+ (WKConstant *)longFixedRectangle {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"longFixedRectangle" type: typeType code: 'lfrc'];
    return constantObj;
}

+ (WKConstant *)longPoint {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"longPoint" type: typeType code: 'lpnt'];
    return constantObj;
}

+ (WKConstant *)longRectangle {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"longRectangle" type: typeType code: 'lrct'];
    return constantObj;
}

+ (WKConstant *)machPort {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"machPort" type: typeType code: 'port'];
    return constantObj;
}

+ (WKConstant *)machine {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"machine" type: typeType code: 'mach'];
    return constantObj;
}

+ (WKConstant *)machineLocation {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"machineLocation" type: typeType code: 'mLoc'];
    return constantObj;
}

+ (WKConstant *)meters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"meters" type: typeType code: 'metr'];
    return constantObj;
}

+ (WKConstant *)miles {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"miles" type: typeType code: 'mile'];
    return constantObj;
}

+ (WKConstant *)miniaturizable {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"miniaturizable" type: typeType code: 'ismn'];
    return constantObj;
}

+ (WKConstant *)miniaturized {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"miniaturized" type: typeType code: 'pmnd'];
    return constantObj;
}

+ (WKConstant *)missingValue {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"missingValue" type: typeType code: 'msng'];
    return constantObj;
}

+ (WKConstant *)modal {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"modal" type: typeType code: 'pmod'];
    return constantObj;
}

+ (WKConstant *)modified {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"modified" type: typeType code: 'imod'];
    return constantObj;
}

+ (WKConstant *)name {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"name" type: typeType code: 'pnam'];
    return constantObj;
}

+ (WKConstant *)null {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"null" type: typeType code: 'null'];
    return constantObj;
}

+ (WKConstant *)ounces {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"ounces" type: typeType code: 'ozs '];
    return constantObj;
}

+ (WKConstant *)pagesAcross {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"pagesAcross" type: typeType code: 'lwla'];
    return constantObj;
}

+ (WKConstant *)pagesDown {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"pagesDown" type: typeType code: 'lwld'];
    return constantObj;
}

+ (WKConstant *)paragraph {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"paragraph" type: typeType code: 'cpar'];
    return constantObj;
}

+ (WKConstant *)parameterInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"parameterInfo" type: typeType code: 'pmin'];
    return constantObj;
}

+ (WKConstant *)path {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"path" type: typeType code: 'ppth'];
    return constantObj;
}

+ (WKConstant *)pixelMapRecord {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"pixelMapRecord" type: typeType code: 'tpmm'];
    return constantObj;
}

+ (WKConstant *)point {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"point" type: typeType code: 'QDpt'];
    return constantObj;
}

+ (WKConstant *)pounds {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"pounds" type: typeType code: 'lbs '];
    return constantObj;
}

+ (WKConstant *)printSettings {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"printSettings" type: typeType code: 'pset'];
    return constantObj;
}

+ (WKConstant *)processSerialNumber {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"processSerialNumber" type: typeType code: 'psn '];
    return constantObj;
}

+ (WKConstant *)properties {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"properties" type: typeType code: 'pALL'];
    return constantObj;
}

+ (WKConstant *)property {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"property" type: typeType code: 'prop'];
    return constantObj;
}

+ (WKConstant *)propertyInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"propertyInfo" type: typeType code: 'pinf'];
    return constantObj;
}

+ (WKConstant *)quarts {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"quarts" type: typeType code: 'qrts'];
    return constantObj;
}

+ (WKConstant *)record {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"record" type: typeType code: 'reco'];
    return constantObj;
}

+ (WKConstant *)reference {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"reference" type: typeType code: 'obj '];
    return constantObj;
}

+ (WKConstant *)requestedPrintTime {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"requestedPrintTime" type: typeType code: 'lwqt'];
    return constantObj;
}

+ (WKConstant *)resizable {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"resizable" type: typeType code: 'prsz'];
    return constantObj;
}

+ (WKConstant *)rotation {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"rotation" type: typeType code: 'trot'];
    return constantObj;
}

+ (WKConstant *)script {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"script" type: typeType code: 'scpt'];
    return constantObj;
}

+ (WKConstant *)shortFloat {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"shortFloat" type: typeType code: 'sing'];
    return constantObj;
}

+ (WKConstant *)shortInteger {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"shortInteger" type: typeType code: 'shor'];
    return constantObj;
}

+ (WKConstant *)size {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"size" type: typeType code: 'ptsz'];
    return constantObj;
}

+ (WKConstant *)source {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"source" type: typeType code: 'conT'];
    return constantObj;
}

+ (WKConstant *)squareFeet {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"squareFeet" type: typeType code: 'sqft'];
    return constantObj;
}

+ (WKConstant *)squareKilometers {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"squareKilometers" type: typeType code: 'sqkm'];
    return constantObj;
}

+ (WKConstant *)squareMeters {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"squareMeters" type: typeType code: 'sqrm'];
    return constantObj;
}

+ (WKConstant *)squareMiles {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"squareMiles" type: typeType code: 'sqmi'];
    return constantObj;
}

+ (WKConstant *)squareYards {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"squareYards" type: typeType code: 'sqyd'];
    return constantObj;
}

+ (WKConstant *)startingPage {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"startingPage" type: typeType code: 'lwfp'];
    return constantObj;
}

+ (WKConstant *)string {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"string" type: typeType code: 'TEXT'];
    return constantObj;
}

+ (WKConstant *)styledClipboardText {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"styledClipboardText" type: typeType code: 'styl'];
    return constantObj;
}

+ (WKConstant *)styledText {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"styledText" type: typeType code: 'STXT'];
    return constantObj;
}

+ (WKConstant *)suiteInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"suiteInfo" type: typeType code: 'suin'];
    return constantObj;
}

+ (WKConstant *)tab {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"tab" type: typeType code: 'bTab'];
    return constantObj;
}

+ (WKConstant *)targetPrinter {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"targetPrinter" type: typeType code: 'trpr'];
    return constantObj;
}

+ (WKConstant *)text {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"text" type: typeType code: 'ctxt'];
    return constantObj;
}

+ (WKConstant *)textStyleInfo {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"textStyleInfo" type: typeType code: 'tsty'];
    return constantObj;
}

+ (WKConstant *)titled {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"titled" type: typeType code: 'ptit'];
    return constantObj;
}

+ (WKConstant *)typeClass {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"typeClass" type: typeType code: 'type'];
    return constantObj;
}

+ (WKConstant *)unicodeText {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"unicodeText" type: typeType code: 'utxt'];
    return constantObj;
}

+ (WKConstant *)unsignedInteger {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"unsignedInteger" type: typeType code: 'magn'];
    return constantObj;
}

+ (WKConstant *)utf16Text {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"utf16Text" type: typeType code: 'ut16'];
    return constantObj;
}

+ (WKConstant *)utf8Text {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"utf8Text" type: typeType code: 'utf8'];
    return constantObj;
}

+ (WKConstant *)version {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"version" type: typeType code: 'vers'];
    return constantObj;
}

+ (WKConstant *)version_ {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"version_" type: typeType code: 'vers'];
    return constantObj;
}

+ (WKConstant *)visible {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"visible" type: typeType code: 'pvis'];
    return constantObj;
}

+ (WKConstant *)window {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"window" type: typeType code: 'cwin'];
    return constantObj;
}

+ (WKConstant *)word {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"word" type: typeType code: 'cwor'];
    return constantObj;
}

+ (WKConstant *)writingCode {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"writingCode" type: typeType code: 'psct'];
    return constantObj;
}

+ (WKConstant *)yards {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"yards" type: typeType code: 'yard'];
    return constantObj;
}

+ (WKConstant *)zoomable {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"zoomable" type: typeType code: 'iszm'];
    return constantObj;
}

+ (WKConstant *)zoomed {
    static WKConstant *constantObj;
    if (!constantObj)
        constantObj = [WKConstant constantWithName: @"zoomed" type: typeType code: 'pzum'];
    return constantObj;
}

@end

