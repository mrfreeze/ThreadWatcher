/*
 * CMConstantGlue.m
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import "CMConstantGlue.h"

@implementation CMConstant
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
        case 'fadb': return [self addressBookCollection];
        case 'alis': return [self alias];
        case '****': return [self anything];
        case 'capp': return [self application];
        case 'bund': return [self applicationBundleID];
        case 'rmte': return [self applicationResponses];
        case 'sign': return [self applicationSignature];
        case 'aprl': return [self applicationURL];
        case 'ask ': return [self ask];
        case 'best': return [self best];
        case 'fbjr': return [self bonjourCollection];
        case 'BMBk': return [self bookmark];
        case 'fbar': return [self bookmarkBarCollection];
        case 'BMFl': return [self bookmarkFolder];
        case 'BMIt': return [self bookmarkItem];
        case 'fmnu': return [self bookmarkMenuCollection];
        case 'bool': return [self boolean];
        case 'qdrt': return [self boundingRectangle];
        case 'pbnd': return [self bounds];
        case 'BWin': return [self browserWindow];
        case 'case': return [self case_];
        case 'cmtr': return [self centimeters];
        case 'gcli': return [self classInfo];
        case 'pcls': return [self class_];
        case 'hclb': return [self closeable];
        case 'clrt': return [self colorTable];
        case 'ccmt': return [self cubicCentimeters];
        case 'cfet': return [self cubicFeet];
        case 'cuin': return [self cubicInches];
        case 'cmet': return [self cubicMeters];
        case 'cyrd': return [self cubicYards];
        case 'pCTb': return [self currentTab];
        case 'tdas': return [self dashStyle];
        case 'rdat': return [self data];
        case 'ldt ': return [self date];
        case 'decm': return [self decimalStruct];
        case 'degc': return [self degreesCelsius];
        case 'degf': return [self degreesFahrenheit];
        case 'degk': return [self degreesKelvin];
        case 'pdes': return [self description_];
        case 'diac': return [self diacriticals];
        case 'comp': return [self doubleInteger];
        case 'elin': return [self elementInfo];
        case 'encs': return [self encodedString];
        case 'enum': return [self enumerator];
        case 'evin': return [self eventInfo];
        case 'expa': return [self expansion];
        case 'exte': return [self extendedFloat];
        case 'feet': return [self feet];
        case 'fsrf': return [self fileRef];
        case 'fss ': return [self fileSpecification];
        case 'furl': return [self fileURL];
        case 'fixd': return [self fixed];
        case 'fpnt': return [self fixedPoint];
        case 'frct': return [self fixedRectangle];
        case 'ldbl': return [self float128bit];
        case 'doub': return [self float_];
        case 'isfl': return [self floating];
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
        case 'pvst': return [self lastVisitDate];
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
        case 'pnam': return [self name];
        case 'no  ': return [self no];
        case 'null': return [self null];
        case 'nume': return [self numericStrings];
        case 'ozs ': return [self ounces];
        case 'pmin': return [self parameterInfo];
        case 'tpmm': return [self pixelMapRecord];
        case 'QDpt': return [self point];
        case 'lbs ': return [self pounds];
        case 'psn ': return [self processSerialNumber];
        case 'pALL': return [self properties];
        case 'prop': return [self property];
        case 'pinf': return [self propertyInfo];
        case 'punc': return [self punctuation];
        case 'qrts': return [self quarts];
        case 'reco': return [self record];
        case 'obj ': return [self reference];
        case 'prsz': return [self resizable];
        case 'trot': return [self rotation];
        case 'scpt': return [self script];
        case 'pSSr': return [self selectedSource];
        case 'pSTx': return [self selectedText];
        case 'sing': return [self shortFloat];
        case 'shor': return [self shortInteger];
        case 'psht': return [self shortcut];
        case 'pSrc': return [self source];
        case 'sqft': return [self squareFeet];
        case 'sqkm': return [self squareKilometers];
        case 'sqrm': return [self squareMeters];
        case 'sqmi': return [self squareMiles];
        case 'sqyd': return [self squareYards];
        case 'TEXT': return [self string];
        case 'styl': return [self styledClipboardText];
        case 'STXT': return [self styledText];
        case 'suin': return [self suiteInfo];
        case 'BTab': return [self tab];
        case 'pTxt': return [self text];
        case 'tsty': return [self textStyleInfo];
        case 'pTtl': return [self title];
        case 'ptit': return [self titled];
        case 'ftop': return [self topTenCollection];
        case 'type': return [self typeClass];
        case 'utxt': return [self unicodeText];
        case 'magn': return [self unsignedInteger];
        case 'ut16': return [self utf16Text];
        case 'utf8': return [self utf8Text];
        case 'vers': return [self version_];
        case 'pvis': return [self visible];
        case 'pvct': return [self visitCount];
        case 'whit': return [self whitespace];
        case 'cwin': return [self window];
        case 'psct': return [self writingCode];
        case 'yard': return [self yards];
        case 'yes ': return [self yes];
        case 'iszm': return [self zoomable];
        case 'pzum': return [self zoomed];
        default: return [[self superclass] constantWithCode: code_];
    }
}


/* Enumerators */

+ (CMConstant *)applicationResponses {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"applicationResponses" type: typeEnumerated code: 'rmte'];
    return constantObj;
}

+ (CMConstant *)ask {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"ask" type: typeEnumerated code: 'ask '];
    return constantObj;
}

+ (CMConstant *)case_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"case_" type: typeEnumerated code: 'case'];
    return constantObj;
}

+ (CMConstant *)diacriticals {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"diacriticals" type: typeEnumerated code: 'diac'];
    return constantObj;
}

+ (CMConstant *)expansion {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"expansion" type: typeEnumerated code: 'expa'];
    return constantObj;
}

+ (CMConstant *)hyphens {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"hyphens" type: typeEnumerated code: 'hyph'];
    return constantObj;
}

+ (CMConstant *)no {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"no" type: typeEnumerated code: 'no  '];
    return constantObj;
}

+ (CMConstant *)numericStrings {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"numericStrings" type: typeEnumerated code: 'nume'];
    return constantObj;
}

+ (CMConstant *)punctuation {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"punctuation" type: typeEnumerated code: 'punc'];
    return constantObj;
}

+ (CMConstant *)whitespace {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"whitespace" type: typeEnumerated code: 'whit'];
    return constantObj;
}

+ (CMConstant *)yes {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"yes" type: typeEnumerated code: 'yes '];
    return constantObj;
}


/* Types and properties */

+ (CMConstant *)April {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"April" type: typeType code: 'apr '];
    return constantObj;
}

+ (CMConstant *)August {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"August" type: typeType code: 'aug '];
    return constantObj;
}

+ (CMConstant *)December {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"December" type: typeType code: 'dec '];
    return constantObj;
}

+ (CMConstant *)EPSPicture {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"EPSPicture" type: typeType code: 'EPS '];
    return constantObj;
}

+ (CMConstant *)February {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"February" type: typeType code: 'feb '];
    return constantObj;
}

+ (CMConstant *)Friday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Friday" type: typeType code: 'fri '];
    return constantObj;
}

+ (CMConstant *)GIFPicture {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"GIFPicture" type: typeType code: 'GIFf'];
    return constantObj;
}

+ (CMConstant *)JPEGPicture {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"JPEGPicture" type: typeType code: 'JPEG'];
    return constantObj;
}

+ (CMConstant *)January {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"January" type: typeType code: 'jan '];
    return constantObj;
}

+ (CMConstant *)July {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"July" type: typeType code: 'jul '];
    return constantObj;
}

+ (CMConstant *)June {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"June" type: typeType code: 'jun '];
    return constantObj;
}

+ (CMConstant *)March {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"March" type: typeType code: 'mar '];
    return constantObj;
}

+ (CMConstant *)May {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"May" type: typeType code: 'may '];
    return constantObj;
}

+ (CMConstant *)Monday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Monday" type: typeType code: 'mon '];
    return constantObj;
}

+ (CMConstant *)November {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"November" type: typeType code: 'nov '];
    return constantObj;
}

+ (CMConstant *)October {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"October" type: typeType code: 'oct '];
    return constantObj;
}

+ (CMConstant *)PICTPicture {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"PICTPicture" type: typeType code: 'PICT'];
    return constantObj;
}

+ (CMConstant *)RGB16Color {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"RGB16Color" type: typeType code: 'tr16'];
    return constantObj;
}

+ (CMConstant *)RGB96Color {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"RGB96Color" type: typeType code: 'tr96'];
    return constantObj;
}

+ (CMConstant *)RGBColor {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"RGBColor" type: typeType code: 'cRGB'];
    return constantObj;
}

+ (CMConstant *)Saturday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Saturday" type: typeType code: 'sat '];
    return constantObj;
}

+ (CMConstant *)September {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"September" type: typeType code: 'sep '];
    return constantObj;
}

+ (CMConstant *)Sunday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Sunday" type: typeType code: 'sun '];
    return constantObj;
}

+ (CMConstant *)TIFFPicture {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"TIFFPicture" type: typeType code: 'TIFF'];
    return constantObj;
}

+ (CMConstant *)Thursday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Thursday" type: typeType code: 'thu '];
    return constantObj;
}

+ (CMConstant *)Tuesday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Tuesday" type: typeType code: 'tue '];
    return constantObj;
}

+ (CMConstant *)URL {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"URL" type: typeType code: 'pURL'];
    return constantObj;
}

+ (CMConstant *)Wednesday {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"Wednesday" type: typeType code: 'wed '];
    return constantObj;
}

+ (CMConstant *)addressBookCollection {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"addressBookCollection" type: typeType code: 'fadb'];
    return constantObj;
}

+ (CMConstant *)alias {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"alias" type: typeType code: 'alis'];
    return constantObj;
}

+ (CMConstant *)anything {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"anything" type: typeType code: '****'];
    return constantObj;
}

+ (CMConstant *)application {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"application" type: typeType code: 'capp'];
    return constantObj;
}

+ (CMConstant *)applicationBundleID {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"applicationBundleID" type: typeType code: 'bund'];
    return constantObj;
}

+ (CMConstant *)applicationSignature {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"applicationSignature" type: typeType code: 'sign'];
    return constantObj;
}

+ (CMConstant *)applicationURL {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"applicationURL" type: typeType code: 'aprl'];
    return constantObj;
}

+ (CMConstant *)best {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"best" type: typeType code: 'best'];
    return constantObj;
}

+ (CMConstant *)bonjourCollection {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bonjourCollection" type: typeType code: 'fbjr'];
    return constantObj;
}

+ (CMConstant *)bookmark {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bookmark" type: typeType code: 'BMBk'];
    return constantObj;
}

+ (CMConstant *)bookmarkBarCollection {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bookmarkBarCollection" type: typeType code: 'fbar'];
    return constantObj;
}

+ (CMConstant *)bookmarkFolder {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bookmarkFolder" type: typeType code: 'BMFl'];
    return constantObj;
}

+ (CMConstant *)bookmarkItem {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bookmarkItem" type: typeType code: 'BMIt'];
    return constantObj;
}

+ (CMConstant *)bookmarkMenuCollection {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bookmarkMenuCollection" type: typeType code: 'fmnu'];
    return constantObj;
}

+ (CMConstant *)boolean {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"boolean" type: typeType code: 'bool'];
    return constantObj;
}

+ (CMConstant *)boundingRectangle {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"boundingRectangle" type: typeType code: 'qdrt'];
    return constantObj;
}

+ (CMConstant *)bounds {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"bounds" type: typeType code: 'pbnd'];
    return constantObj;
}

+ (CMConstant *)browserWindow {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"browserWindow" type: typeType code: 'BWin'];
    return constantObj;
}

+ (CMConstant *)centimeters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"centimeters" type: typeType code: 'cmtr'];
    return constantObj;
}

+ (CMConstant *)classInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"classInfo" type: typeType code: 'gcli'];
    return constantObj;
}

+ (CMConstant *)class_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"class_" type: typeType code: 'pcls'];
    return constantObj;
}

+ (CMConstant *)closeable {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"closeable" type: typeType code: 'hclb'];
    return constantObj;
}

+ (CMConstant *)colorTable {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"colorTable" type: typeType code: 'clrt'];
    return constantObj;
}

+ (CMConstant *)cubicCentimeters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"cubicCentimeters" type: typeType code: 'ccmt'];
    return constantObj;
}

+ (CMConstant *)cubicFeet {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"cubicFeet" type: typeType code: 'cfet'];
    return constantObj;
}

+ (CMConstant *)cubicInches {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"cubicInches" type: typeType code: 'cuin'];
    return constantObj;
}

+ (CMConstant *)cubicMeters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"cubicMeters" type: typeType code: 'cmet'];
    return constantObj;
}

+ (CMConstant *)cubicYards {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"cubicYards" type: typeType code: 'cyrd'];
    return constantObj;
}

+ (CMConstant *)currentTab {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"currentTab" type: typeType code: 'pCTb'];
    return constantObj;
}

+ (CMConstant *)dashStyle {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"dashStyle" type: typeType code: 'tdas'];
    return constantObj;
}

+ (CMConstant *)data {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"data" type: typeType code: 'rdat'];
    return constantObj;
}

+ (CMConstant *)date {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"date" type: typeType code: 'ldt '];
    return constantObj;
}

+ (CMConstant *)decimalStruct {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"decimalStruct" type: typeType code: 'decm'];
    return constantObj;
}

+ (CMConstant *)degreesCelsius {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"degreesCelsius" type: typeType code: 'degc'];
    return constantObj;
}

+ (CMConstant *)degreesFahrenheit {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"degreesFahrenheit" type: typeType code: 'degf'];
    return constantObj;
}

+ (CMConstant *)degreesKelvin {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"degreesKelvin" type: typeType code: 'degk'];
    return constantObj;
}

+ (CMConstant *)description_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"description_" type: typeType code: 'pdes'];
    return constantObj;
}

+ (CMConstant *)doubleInteger {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"doubleInteger" type: typeType code: 'comp'];
    return constantObj;
}

+ (CMConstant *)elementInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"elementInfo" type: typeType code: 'elin'];
    return constantObj;
}

+ (CMConstant *)encodedString {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"encodedString" type: typeType code: 'encs'];
    return constantObj;
}

+ (CMConstant *)enumerator {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"enumerator" type: typeType code: 'enum'];
    return constantObj;
}

+ (CMConstant *)eventInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"eventInfo" type: typeType code: 'evin'];
    return constantObj;
}

+ (CMConstant *)extendedFloat {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"extendedFloat" type: typeType code: 'exte'];
    return constantObj;
}

+ (CMConstant *)feet {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"feet" type: typeType code: 'feet'];
    return constantObj;
}

+ (CMConstant *)fileRef {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fileRef" type: typeType code: 'fsrf'];
    return constantObj;
}

+ (CMConstant *)fileSpecification {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fileSpecification" type: typeType code: 'fss '];
    return constantObj;
}

+ (CMConstant *)fileURL {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fileURL" type: typeType code: 'furl'];
    return constantObj;
}

+ (CMConstant *)fixed {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fixed" type: typeType code: 'fixd'];
    return constantObj;
}

+ (CMConstant *)fixedPoint {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fixedPoint" type: typeType code: 'fpnt'];
    return constantObj;
}

+ (CMConstant *)fixedRectangle {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"fixedRectangle" type: typeType code: 'frct'];
    return constantObj;
}

+ (CMConstant *)float128bit {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"float128bit" type: typeType code: 'ldbl'];
    return constantObj;
}

+ (CMConstant *)float_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"float_" type: typeType code: 'doub'];
    return constantObj;
}

+ (CMConstant *)floating {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"floating" type: typeType code: 'isfl'];
    return constantObj;
}

+ (CMConstant *)frontmost {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"frontmost" type: typeType code: 'pisf'];
    return constantObj;
}

+ (CMConstant *)gallons {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"gallons" type: typeType code: 'galn'];
    return constantObj;
}

+ (CMConstant *)grams {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"grams" type: typeType code: 'gram'];
    return constantObj;
}

+ (CMConstant *)graphicText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"graphicText" type: typeType code: 'cgtx'];
    return constantObj;
}

+ (CMConstant *)id_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"id_" type: typeType code: 'ID  '];
    return constantObj;
}

+ (CMConstant *)inches {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"inches" type: typeType code: 'inch'];
    return constantObj;
}

+ (CMConstant *)index {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"index" type: typeType code: 'pidx'];
    return constantObj;
}

+ (CMConstant *)integer {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"integer" type: typeType code: 'long'];
    return constantObj;
}

+ (CMConstant *)internationalText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"internationalText" type: typeType code: 'itxt'];
    return constantObj;
}

+ (CMConstant *)internationalWritingCode {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"internationalWritingCode" type: typeType code: 'intl'];
    return constantObj;
}

+ (CMConstant *)item {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"item" type: typeType code: 'cobj'];
    return constantObj;
}

+ (CMConstant *)kernelProcessID {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"kernelProcessID" type: typeType code: 'kpid'];
    return constantObj;
}

+ (CMConstant *)kilograms {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"kilograms" type: typeType code: 'kgrm'];
    return constantObj;
}

+ (CMConstant *)kilometers {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"kilometers" type: typeType code: 'kmtr'];
    return constantObj;
}

+ (CMConstant *)lastVisitDate {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"lastVisitDate" type: typeType code: 'pvst'];
    return constantObj;
}

+ (CMConstant *)list {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"list" type: typeType code: 'list'];
    return constantObj;
}

+ (CMConstant *)liters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"liters" type: typeType code: 'litr'];
    return constantObj;
}

+ (CMConstant *)locationReference {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"locationReference" type: typeType code: 'insl'];
    return constantObj;
}

+ (CMConstant *)longFixed {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"longFixed" type: typeType code: 'lfxd'];
    return constantObj;
}

+ (CMConstant *)longFixedPoint {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"longFixedPoint" type: typeType code: 'lfpt'];
    return constantObj;
}

+ (CMConstant *)longFixedRectangle {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"longFixedRectangle" type: typeType code: 'lfrc'];
    return constantObj;
}

+ (CMConstant *)longPoint {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"longPoint" type: typeType code: 'lpnt'];
    return constantObj;
}

+ (CMConstant *)longRectangle {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"longRectangle" type: typeType code: 'lrct'];
    return constantObj;
}

+ (CMConstant *)machPort {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"machPort" type: typeType code: 'port'];
    return constantObj;
}

+ (CMConstant *)machine {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"machine" type: typeType code: 'mach'];
    return constantObj;
}

+ (CMConstant *)machineLocation {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"machineLocation" type: typeType code: 'mLoc'];
    return constantObj;
}

+ (CMConstant *)meters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"meters" type: typeType code: 'metr'];
    return constantObj;
}

+ (CMConstant *)miles {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"miles" type: typeType code: 'mile'];
    return constantObj;
}

+ (CMConstant *)miniaturizable {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"miniaturizable" type: typeType code: 'ismn'];
    return constantObj;
}

+ (CMConstant *)miniaturized {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"miniaturized" type: typeType code: 'pmnd'];
    return constantObj;
}

+ (CMConstant *)missingValue {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"missingValue" type: typeType code: 'msng'];
    return constantObj;
}

+ (CMConstant *)modal {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"modal" type: typeType code: 'pmod'];
    return constantObj;
}

+ (CMConstant *)name {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"name" type: typeType code: 'pnam'];
    return constantObj;
}

+ (CMConstant *)null {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"null" type: typeType code: 'null'];
    return constantObj;
}

+ (CMConstant *)ounces {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"ounces" type: typeType code: 'ozs '];
    return constantObj;
}

+ (CMConstant *)parameterInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"parameterInfo" type: typeType code: 'pmin'];
    return constantObj;
}

+ (CMConstant *)pixelMapRecord {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"pixelMapRecord" type: typeType code: 'tpmm'];
    return constantObj;
}

+ (CMConstant *)point {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"point" type: typeType code: 'QDpt'];
    return constantObj;
}

+ (CMConstant *)pounds {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"pounds" type: typeType code: 'lbs '];
    return constantObj;
}

+ (CMConstant *)processSerialNumber {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"processSerialNumber" type: typeType code: 'psn '];
    return constantObj;
}

+ (CMConstant *)properties {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"properties" type: typeType code: 'pALL'];
    return constantObj;
}

+ (CMConstant *)property {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"property" type: typeType code: 'prop'];
    return constantObj;
}

+ (CMConstant *)propertyInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"propertyInfo" type: typeType code: 'pinf'];
    return constantObj;
}

+ (CMConstant *)quarts {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"quarts" type: typeType code: 'qrts'];
    return constantObj;
}

+ (CMConstant *)record {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"record" type: typeType code: 'reco'];
    return constantObj;
}

+ (CMConstant *)reference {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"reference" type: typeType code: 'obj '];
    return constantObj;
}

+ (CMConstant *)resizable {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"resizable" type: typeType code: 'prsz'];
    return constantObj;
}

+ (CMConstant *)rotation {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"rotation" type: typeType code: 'trot'];
    return constantObj;
}

+ (CMConstant *)script {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"script" type: typeType code: 'scpt'];
    return constantObj;
}

+ (CMConstant *)selectedSource {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"selectedSource" type: typeType code: 'pSSr'];
    return constantObj;
}

+ (CMConstant *)selectedText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"selectedText" type: typeType code: 'pSTx'];
    return constantObj;
}

+ (CMConstant *)shortFloat {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"shortFloat" type: typeType code: 'sing'];
    return constantObj;
}

+ (CMConstant *)shortInteger {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"shortInteger" type: typeType code: 'shor'];
    return constantObj;
}

+ (CMConstant *)shortcut {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"shortcut" type: typeType code: 'psht'];
    return constantObj;
}

+ (CMConstant *)source {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"source" type: typeType code: 'pSrc'];
    return constantObj;
}

+ (CMConstant *)squareFeet {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"squareFeet" type: typeType code: 'sqft'];
    return constantObj;
}

+ (CMConstant *)squareKilometers {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"squareKilometers" type: typeType code: 'sqkm'];
    return constantObj;
}

+ (CMConstant *)squareMeters {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"squareMeters" type: typeType code: 'sqrm'];
    return constantObj;
}

+ (CMConstant *)squareMiles {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"squareMiles" type: typeType code: 'sqmi'];
    return constantObj;
}

+ (CMConstant *)squareYards {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"squareYards" type: typeType code: 'sqyd'];
    return constantObj;
}

+ (CMConstant *)string {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"string" type: typeType code: 'TEXT'];
    return constantObj;
}

+ (CMConstant *)styledClipboardText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"styledClipboardText" type: typeType code: 'styl'];
    return constantObj;
}

+ (CMConstant *)styledText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"styledText" type: typeType code: 'STXT'];
    return constantObj;
}

+ (CMConstant *)suiteInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"suiteInfo" type: typeType code: 'suin'];
    return constantObj;
}

+ (CMConstant *)tab {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"tab" type: typeType code: 'BTab'];
    return constantObj;
}

+ (CMConstant *)text {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"text" type: typeType code: 'pTxt'];
    return constantObj;
}

+ (CMConstant *)textStyleInfo {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"textStyleInfo" type: typeType code: 'tsty'];
    return constantObj;
}

+ (CMConstant *)title {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"title" type: typeType code: 'pTtl'];
    return constantObj;
}

+ (CMConstant *)titled {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"titled" type: typeType code: 'ptit'];
    return constantObj;
}

+ (CMConstant *)topTenCollection {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"topTenCollection" type: typeType code: 'ftop'];
    return constantObj;
}

+ (CMConstant *)typeClass {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"typeClass" type: typeType code: 'type'];
    return constantObj;
}

+ (CMConstant *)unicodeText {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"unicodeText" type: typeType code: 'utxt'];
    return constantObj;
}

+ (CMConstant *)unsignedInteger {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"unsignedInteger" type: typeType code: 'magn'];
    return constantObj;
}

+ (CMConstant *)utf16Text {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"utf16Text" type: typeType code: 'ut16'];
    return constantObj;
}

+ (CMConstant *)utf8Text {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"utf8Text" type: typeType code: 'utf8'];
    return constantObj;
}

+ (CMConstant *)version {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"version" type: typeType code: 'vers'];
    return constantObj;
}

+ (CMConstant *)version_ {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"version_" type: typeType code: 'vers'];
    return constantObj;
}

+ (CMConstant *)visible {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"visible" type: typeType code: 'pvis'];
    return constantObj;
}

+ (CMConstant *)visitCount {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"visitCount" type: typeType code: 'pvct'];
    return constantObj;
}

+ (CMConstant *)window {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"window" type: typeType code: 'cwin'];
    return constantObj;
}

+ (CMConstant *)writingCode {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"writingCode" type: typeType code: 'psct'];
    return constantObj;
}

+ (CMConstant *)yards {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"yards" type: typeType code: 'yard'];
    return constantObj;
}

+ (CMConstant *)zoomable {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"zoomable" type: typeType code: 'iszm'];
    return constantObj;
}

+ (CMConstant *)zoomed {
    static CMConstant *constantObj;
    if (!constantObj)
        constantObj = [CMConstant constantWithName: @"zoomed" type: typeType code: 'pzum'];
    return constantObj;
}

@end

