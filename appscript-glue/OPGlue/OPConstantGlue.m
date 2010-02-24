/*
 * OPConstantGlue.m
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import "OPConstantGlue.h"

@implementation OPConstant
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
        case 'wed ': return [self Wednesday];
        case 'alis': return [self alias];
        case '****': return [self anything];
        case 'capp': return [self application];
        case 'bund': return [self applicationBundleID];
        case 'rmte': return [self applicationResponses];
        case 'sign': return [self applicationSignature];
        case 'aprl': return [self applicationURL];
        case 'ask ': return [self ask];
        case 'best': return [self best];
        case 'bool': return [self boolean];
        case 'qdrt': return [self boundingRectangle];
        case 'pbnd': return [self bounds];
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
        case 'tdas': return [self dashStyle];
        case 'rdat': return [self data];
        case 'ldt ': return [self date];
        case 'decm': return [self decimalStruct];
        case 'degc': return [self degreesCelsius];
        case 'degf': return [self degreesFahrenheit];
        case 'degk': return [self degreesKelvin];
        case 'diac': return [self diacriticals];
        case 'docu': return [self document];
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
        case 'LOad': return [self loading];
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
        case 'minU': return [self miniaturized];
        case 'msng': return [self missingValue];
        case 'pmod': return [self modal];
        case 'imod': return [self modified];
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
        case 'sing': return [self shortFloat];
        case 'shor': return [self shortInteger];
        case 'sqft': return [self squareFeet];
        case 'sqkm': return [self squareKilometers];
        case 'sqrm': return [self squareMeters];
        case 'sqmi': return [self squareMiles];
        case 'sqyd': return [self squareYards];
        case 'TEXT': return [self string];
        case 'styl': return [self styledClipboardText];
        case 'STXT': return [self styledText];
        case 'suin': return [self suiteInfo];
        case 'tsty': return [self textStyleInfo];
        case 'ptit': return [self titled];
        case 'type': return [self typeClass];
        case 'utxt': return [self unicodeText];
        case 'magn': return [self unsignedInteger];
        case 'url ': return [self url];
        case 'ut16': return [self utf16Text];
        case 'utf8': return [self utf8Text];
        case 'vers': return [self version];
        case 'pvis': return [self visible];
        case 'whit': return [self whitespace];
        case 'cwin': return [self window];
        case 'wndw': return [self window];
        case 'psct': return [self writingCode];
        case 'yard': return [self yards];
        case 'yes ': return [self yes];
        case 'iszm': return [self zoomable];
        case 'pzum': return [self zoomed];
        default: return [[self superclass] constantWithCode: code_];
    }
}


/* Enumerators */

+ (OPConstant *)applicationResponses {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"applicationResponses" type: typeEnumerated code: 'rmte'];
    return constantObj;
}

+ (OPConstant *)ask {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"ask" type: typeEnumerated code: 'ask '];
    return constantObj;
}

+ (OPConstant *)case_ {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"case_" type: typeEnumerated code: 'case'];
    return constantObj;
}

+ (OPConstant *)diacriticals {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"diacriticals" type: typeEnumerated code: 'diac'];
    return constantObj;
}

+ (OPConstant *)expansion {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"expansion" type: typeEnumerated code: 'expa'];
    return constantObj;
}

+ (OPConstant *)hyphens {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"hyphens" type: typeEnumerated code: 'hyph'];
    return constantObj;
}

+ (OPConstant *)no {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"no" type: typeEnumerated code: 'no  '];
    return constantObj;
}

+ (OPConstant *)numericStrings {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"numericStrings" type: typeEnumerated code: 'nume'];
    return constantObj;
}

+ (OPConstant *)punctuation {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"punctuation" type: typeEnumerated code: 'punc'];
    return constantObj;
}

+ (OPConstant *)whitespace {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"whitespace" type: typeEnumerated code: 'whit'];
    return constantObj;
}

+ (OPConstant *)yes {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"yes" type: typeEnumerated code: 'yes '];
    return constantObj;
}


/* Types and properties */

+ (OPConstant *)April {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"April" type: typeType code: 'apr '];
    return constantObj;
}

+ (OPConstant *)August {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"August" type: typeType code: 'aug '];
    return constantObj;
}

+ (OPConstant *)December {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"December" type: typeType code: 'dec '];
    return constantObj;
}

+ (OPConstant *)EPSPicture {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"EPSPicture" type: typeType code: 'EPS '];
    return constantObj;
}

+ (OPConstant *)February {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"February" type: typeType code: 'feb '];
    return constantObj;
}

+ (OPConstant *)Friday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Friday" type: typeType code: 'fri '];
    return constantObj;
}

+ (OPConstant *)GIFPicture {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"GIFPicture" type: typeType code: 'GIFf'];
    return constantObj;
}

+ (OPConstant *)JPEGPicture {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"JPEGPicture" type: typeType code: 'JPEG'];
    return constantObj;
}

+ (OPConstant *)January {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"January" type: typeType code: 'jan '];
    return constantObj;
}

+ (OPConstant *)July {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"July" type: typeType code: 'jul '];
    return constantObj;
}

+ (OPConstant *)June {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"June" type: typeType code: 'jun '];
    return constantObj;
}

+ (OPConstant *)March {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"March" type: typeType code: 'mar '];
    return constantObj;
}

+ (OPConstant *)May {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"May" type: typeType code: 'may '];
    return constantObj;
}

+ (OPConstant *)Monday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Monday" type: typeType code: 'mon '];
    return constantObj;
}

+ (OPConstant *)November {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"November" type: typeType code: 'nov '];
    return constantObj;
}

+ (OPConstant *)October {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"October" type: typeType code: 'oct '];
    return constantObj;
}

+ (OPConstant *)PICTPicture {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"PICTPicture" type: typeType code: 'PICT'];
    return constantObj;
}

+ (OPConstant *)RGB16Color {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"RGB16Color" type: typeType code: 'tr16'];
    return constantObj;
}

+ (OPConstant *)RGB96Color {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"RGB96Color" type: typeType code: 'tr96'];
    return constantObj;
}

+ (OPConstant *)RGBColor {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"RGBColor" type: typeType code: 'cRGB'];
    return constantObj;
}

+ (OPConstant *)Saturday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Saturday" type: typeType code: 'sat '];
    return constantObj;
}

+ (OPConstant *)September {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"September" type: typeType code: 'sep '];
    return constantObj;
}

+ (OPConstant *)Sunday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Sunday" type: typeType code: 'sun '];
    return constantObj;
}

+ (OPConstant *)TIFFPicture {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"TIFFPicture" type: typeType code: 'TIFF'];
    return constantObj;
}

+ (OPConstant *)Thursday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Thursday" type: typeType code: 'thu '];
    return constantObj;
}

+ (OPConstant *)Tuesday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Tuesday" type: typeType code: 'tue '];
    return constantObj;
}

+ (OPConstant *)Wednesday {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"Wednesday" type: typeType code: 'wed '];
    return constantObj;
}

+ (OPConstant *)alias {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"alias" type: typeType code: 'alis'];
    return constantObj;
}

+ (OPConstant *)anything {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"anything" type: typeType code: '****'];
    return constantObj;
}

+ (OPConstant *)application {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"application" type: typeType code: 'capp'];
    return constantObj;
}

+ (OPConstant *)applicationBundleID {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"applicationBundleID" type: typeType code: 'bund'];
    return constantObj;
}

+ (OPConstant *)applicationSignature {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"applicationSignature" type: typeType code: 'sign'];
    return constantObj;
}

+ (OPConstant *)applicationURL {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"applicationURL" type: typeType code: 'aprl'];
    return constantObj;
}

+ (OPConstant *)best {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"best" type: typeType code: 'best'];
    return constantObj;
}

+ (OPConstant *)boolean {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"boolean" type: typeType code: 'bool'];
    return constantObj;
}

+ (OPConstant *)boundingRectangle {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"boundingRectangle" type: typeType code: 'qdrt'];
    return constantObj;
}

+ (OPConstant *)bounds {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"bounds" type: typeType code: 'pbnd'];
    return constantObj;
}

+ (OPConstant *)centimeters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"centimeters" type: typeType code: 'cmtr'];
    return constantObj;
}

+ (OPConstant *)classInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"classInfo" type: typeType code: 'gcli'];
    return constantObj;
}

+ (OPConstant *)class_ {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"class_" type: typeType code: 'pcls'];
    return constantObj;
}

+ (OPConstant *)closeable {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"closeable" type: typeType code: 'hclb'];
    return constantObj;
}

+ (OPConstant *)colorTable {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"colorTable" type: typeType code: 'clrt'];
    return constantObj;
}

+ (OPConstant *)cubicCentimeters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"cubicCentimeters" type: typeType code: 'ccmt'];
    return constantObj;
}

+ (OPConstant *)cubicFeet {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"cubicFeet" type: typeType code: 'cfet'];
    return constantObj;
}

+ (OPConstant *)cubicInches {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"cubicInches" type: typeType code: 'cuin'];
    return constantObj;
}

+ (OPConstant *)cubicMeters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"cubicMeters" type: typeType code: 'cmet'];
    return constantObj;
}

+ (OPConstant *)cubicYards {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"cubicYards" type: typeType code: 'cyrd'];
    return constantObj;
}

+ (OPConstant *)dashStyle {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"dashStyle" type: typeType code: 'tdas'];
    return constantObj;
}

+ (OPConstant *)data {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"data" type: typeType code: 'rdat'];
    return constantObj;
}

+ (OPConstant *)date {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"date" type: typeType code: 'ldt '];
    return constantObj;
}

+ (OPConstant *)decimalStruct {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"decimalStruct" type: typeType code: 'decm'];
    return constantObj;
}

+ (OPConstant *)degreesCelsius {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"degreesCelsius" type: typeType code: 'degc'];
    return constantObj;
}

+ (OPConstant *)degreesFahrenheit {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"degreesFahrenheit" type: typeType code: 'degf'];
    return constantObj;
}

+ (OPConstant *)degreesKelvin {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"degreesKelvin" type: typeType code: 'degk'];
    return constantObj;
}

+ (OPConstant *)document {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"document" type: typeType code: 'docu'];
    return constantObj;
}

+ (OPConstant *)doubleInteger {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"doubleInteger" type: typeType code: 'comp'];
    return constantObj;
}

+ (OPConstant *)elementInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"elementInfo" type: typeType code: 'elin'];
    return constantObj;
}

+ (OPConstant *)encodedString {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"encodedString" type: typeType code: 'encs'];
    return constantObj;
}

+ (OPConstant *)enumerator {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"enumerator" type: typeType code: 'enum'];
    return constantObj;
}

+ (OPConstant *)eventInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"eventInfo" type: typeType code: 'evin'];
    return constantObj;
}

+ (OPConstant *)extendedFloat {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"extendedFloat" type: typeType code: 'exte'];
    return constantObj;
}

+ (OPConstant *)feet {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"feet" type: typeType code: 'feet'];
    return constantObj;
}

+ (OPConstant *)fileRef {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fileRef" type: typeType code: 'fsrf'];
    return constantObj;
}

+ (OPConstant *)fileSpecification {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fileSpecification" type: typeType code: 'fss '];
    return constantObj;
}

+ (OPConstant *)fileURL {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fileURL" type: typeType code: 'furl'];
    return constantObj;
}

+ (OPConstant *)fixed {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fixed" type: typeType code: 'fixd'];
    return constantObj;
}

+ (OPConstant *)fixedPoint {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fixedPoint" type: typeType code: 'fpnt'];
    return constantObj;
}

+ (OPConstant *)fixedRectangle {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"fixedRectangle" type: typeType code: 'frct'];
    return constantObj;
}

+ (OPConstant *)float128bit {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"float128bit" type: typeType code: 'ldbl'];
    return constantObj;
}

+ (OPConstant *)float_ {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"float_" type: typeType code: 'doub'];
    return constantObj;
}

+ (OPConstant *)floating {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"floating" type: typeType code: 'isfl'];
    return constantObj;
}

+ (OPConstant *)gallons {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"gallons" type: typeType code: 'galn'];
    return constantObj;
}

+ (OPConstant *)grams {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"grams" type: typeType code: 'gram'];
    return constantObj;
}

+ (OPConstant *)graphicText {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"graphicText" type: typeType code: 'cgtx'];
    return constantObj;
}

+ (OPConstant *)id_ {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"id_" type: typeType code: 'ID  '];
    return constantObj;
}

+ (OPConstant *)inches {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"inches" type: typeType code: 'inch'];
    return constantObj;
}

+ (OPConstant *)index {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"index" type: typeType code: 'pidx'];
    return constantObj;
}

+ (OPConstant *)integer {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"integer" type: typeType code: 'long'];
    return constantObj;
}

+ (OPConstant *)internationalText {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"internationalText" type: typeType code: 'itxt'];
    return constantObj;
}

+ (OPConstant *)internationalWritingCode {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"internationalWritingCode" type: typeType code: 'intl'];
    return constantObj;
}

+ (OPConstant *)item {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"item" type: typeType code: 'cobj'];
    return constantObj;
}

+ (OPConstant *)kernelProcessID {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"kernelProcessID" type: typeType code: 'kpid'];
    return constantObj;
}

+ (OPConstant *)kilograms {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"kilograms" type: typeType code: 'kgrm'];
    return constantObj;
}

+ (OPConstant *)kilometers {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"kilometers" type: typeType code: 'kmtr'];
    return constantObj;
}

+ (OPConstant *)list {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"list" type: typeType code: 'list'];
    return constantObj;
}

+ (OPConstant *)liters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"liters" type: typeType code: 'litr'];
    return constantObj;
}

+ (OPConstant *)loading {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"loading" type: typeType code: 'LOad'];
    return constantObj;
}

+ (OPConstant *)locationReference {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"locationReference" type: typeType code: 'insl'];
    return constantObj;
}

+ (OPConstant *)longFixed {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"longFixed" type: typeType code: 'lfxd'];
    return constantObj;
}

+ (OPConstant *)longFixedPoint {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"longFixedPoint" type: typeType code: 'lfpt'];
    return constantObj;
}

+ (OPConstant *)longFixedRectangle {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"longFixedRectangle" type: typeType code: 'lfrc'];
    return constantObj;
}

+ (OPConstant *)longPoint {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"longPoint" type: typeType code: 'lpnt'];
    return constantObj;
}

+ (OPConstant *)longRectangle {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"longRectangle" type: typeType code: 'lrct'];
    return constantObj;
}

+ (OPConstant *)machPort {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"machPort" type: typeType code: 'port'];
    return constantObj;
}

+ (OPConstant *)machine {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"machine" type: typeType code: 'mach'];
    return constantObj;
}

+ (OPConstant *)machineLocation {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"machineLocation" type: typeType code: 'mLoc'];
    return constantObj;
}

+ (OPConstant *)meters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"meters" type: typeType code: 'metr'];
    return constantObj;
}

+ (OPConstant *)miles {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"miles" type: typeType code: 'mile'];
    return constantObj;
}

+ (OPConstant *)miniaturizable {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"miniaturizable" type: typeType code: 'ismn'];
    return constantObj;
}

+ (OPConstant *)miniaturized {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"miniaturized" type: typeType code: 'minU'];
    return constantObj;
}

+ (OPConstant *)missingValue {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"missingValue" type: typeType code: 'msng'];
    return constantObj;
}

+ (OPConstant *)modal {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"modal" type: typeType code: 'pmod'];
    return constantObj;
}

+ (OPConstant *)modified {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"modified" type: typeType code: 'imod'];
    return constantObj;
}

+ (OPConstant *)name {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"name" type: typeType code: 'pnam'];
    return constantObj;
}

+ (OPConstant *)null {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"null" type: typeType code: 'null'];
    return constantObj;
}

+ (OPConstant *)ounces {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"ounces" type: typeType code: 'ozs '];
    return constantObj;
}

+ (OPConstant *)parameterInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"parameterInfo" type: typeType code: 'pmin'];
    return constantObj;
}

+ (OPConstant *)pixelMapRecord {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"pixelMapRecord" type: typeType code: 'tpmm'];
    return constantObj;
}

+ (OPConstant *)point {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"point" type: typeType code: 'QDpt'];
    return constantObj;
}

+ (OPConstant *)pounds {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"pounds" type: typeType code: 'lbs '];
    return constantObj;
}

+ (OPConstant *)processSerialNumber {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"processSerialNumber" type: typeType code: 'psn '];
    return constantObj;
}

+ (OPConstant *)properties {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"properties" type: typeType code: 'pALL'];
    return constantObj;
}

+ (OPConstant *)property {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"property" type: typeType code: 'prop'];
    return constantObj;
}

+ (OPConstant *)propertyInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"propertyInfo" type: typeType code: 'pinf'];
    return constantObj;
}

+ (OPConstant *)quarts {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"quarts" type: typeType code: 'qrts'];
    return constantObj;
}

+ (OPConstant *)record {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"record" type: typeType code: 'reco'];
    return constantObj;
}

+ (OPConstant *)reference {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"reference" type: typeType code: 'obj '];
    return constantObj;
}

+ (OPConstant *)resizable {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"resizable" type: typeType code: 'prsz'];
    return constantObj;
}

+ (OPConstant *)rotation {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"rotation" type: typeType code: 'trot'];
    return constantObj;
}

+ (OPConstant *)script {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"script" type: typeType code: 'scpt'];
    return constantObj;
}

+ (OPConstant *)shortFloat {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"shortFloat" type: typeType code: 'sing'];
    return constantObj;
}

+ (OPConstant *)shortInteger {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"shortInteger" type: typeType code: 'shor'];
    return constantObj;
}

+ (OPConstant *)squareFeet {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"squareFeet" type: typeType code: 'sqft'];
    return constantObj;
}

+ (OPConstant *)squareKilometers {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"squareKilometers" type: typeType code: 'sqkm'];
    return constantObj;
}

+ (OPConstant *)squareMeters {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"squareMeters" type: typeType code: 'sqrm'];
    return constantObj;
}

+ (OPConstant *)squareMiles {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"squareMiles" type: typeType code: 'sqmi'];
    return constantObj;
}

+ (OPConstant *)squareYards {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"squareYards" type: typeType code: 'sqyd'];
    return constantObj;
}

+ (OPConstant *)string {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"string" type: typeType code: 'TEXT'];
    return constantObj;
}

+ (OPConstant *)styledClipboardText {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"styledClipboardText" type: typeType code: 'styl'];
    return constantObj;
}

+ (OPConstant *)styledText {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"styledText" type: typeType code: 'STXT'];
    return constantObj;
}

+ (OPConstant *)suiteInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"suiteInfo" type: typeType code: 'suin'];
    return constantObj;
}

+ (OPConstant *)textStyleInfo {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"textStyleInfo" type: typeType code: 'tsty'];
    return constantObj;
}

+ (OPConstant *)titled {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"titled" type: typeType code: 'ptit'];
    return constantObj;
}

+ (OPConstant *)typeClass {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"typeClass" type: typeType code: 'type'];
    return constantObj;
}

+ (OPConstant *)unicodeText {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"unicodeText" type: typeType code: 'utxt'];
    return constantObj;
}

+ (OPConstant *)unsignedInteger {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"unsignedInteger" type: typeType code: 'magn'];
    return constantObj;
}

+ (OPConstant *)url {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"url" type: typeType code: 'url '];
    return constantObj;
}

+ (OPConstant *)utf16Text {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"utf16Text" type: typeType code: 'ut16'];
    return constantObj;
}

+ (OPConstant *)utf8Text {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"utf8Text" type: typeType code: 'utf8'];
    return constantObj;
}

+ (OPConstant *)version {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"version" type: typeType code: 'vers'];
    return constantObj;
}

+ (OPConstant *)visible {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"visible" type: typeType code: 'pvis'];
    return constantObj;
}

+ (OPConstant *)window {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"window" type: typeType code: 'cwin'];
    return constantObj;
}

+ (OPConstant *)writingCode {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"writingCode" type: typeType code: 'psct'];
    return constantObj;
}

+ (OPConstant *)yards {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"yards" type: typeType code: 'yard'];
    return constantObj;
}

+ (OPConstant *)zoomable {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"zoomable" type: typeType code: 'iszm'];
    return constantObj;
}

+ (OPConstant *)zoomed {
    static OPConstant *constantObj;
    if (!constantObj)
        constantObj = [OPConstant constantWithName: @"zoomed" type: typeType code: 'pzum'];
    return constantObj;
}

@end

