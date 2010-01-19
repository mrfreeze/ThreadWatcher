/*
 * FRConstantGlue.m
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import "FRConstantGlue.h"

@implementation FRConstant
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

+ (FRConstant *)applicationResponses {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"applicationResponses" type: typeEnumerated code: 'rmte'];
    return constantObj;
}

+ (FRConstant *)ask {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"ask" type: typeEnumerated code: 'ask '];
    return constantObj;
}

+ (FRConstant *)case_ {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"case_" type: typeEnumerated code: 'case'];
    return constantObj;
}

+ (FRConstant *)detailed {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"detailed" type: typeEnumerated code: 'lwdt'];
    return constantObj;
}

+ (FRConstant *)diacriticals {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"diacriticals" type: typeEnumerated code: 'diac'];
    return constantObj;
}

+ (FRConstant *)expansion {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"expansion" type: typeEnumerated code: 'expa'];
    return constantObj;
}

+ (FRConstant *)hyphens {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"hyphens" type: typeEnumerated code: 'hyph'];
    return constantObj;
}

+ (FRConstant *)no {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"no" type: typeEnumerated code: 'no  '];
    return constantObj;
}

+ (FRConstant *)numericStrings {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"numericStrings" type: typeEnumerated code: 'nume'];
    return constantObj;
}

+ (FRConstant *)punctuation {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"punctuation" type: typeEnumerated code: 'punc'];
    return constantObj;
}

+ (FRConstant *)standard {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"standard" type: typeEnumerated code: 'lwst'];
    return constantObj;
}

+ (FRConstant *)whitespace {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"whitespace" type: typeEnumerated code: 'whit'];
    return constantObj;
}

+ (FRConstant *)yes {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"yes" type: typeEnumerated code: 'yes '];
    return constantObj;
}


/* Types and properties */

+ (FRConstant *)April {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"April" type: typeType code: 'apr '];
    return constantObj;
}

+ (FRConstant *)August {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"August" type: typeType code: 'aug '];
    return constantObj;
}

+ (FRConstant *)December {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"December" type: typeType code: 'dec '];
    return constantObj;
}

+ (FRConstant *)EPSPicture {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"EPSPicture" type: typeType code: 'EPS '];
    return constantObj;
}

+ (FRConstant *)February {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"February" type: typeType code: 'feb '];
    return constantObj;
}

+ (FRConstant *)Friday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Friday" type: typeType code: 'fri '];
    return constantObj;
}

+ (FRConstant *)GIFPicture {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"GIFPicture" type: typeType code: 'GIFf'];
    return constantObj;
}

+ (FRConstant *)JPEGPicture {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"JPEGPicture" type: typeType code: 'JPEG'];
    return constantObj;
}

+ (FRConstant *)January {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"January" type: typeType code: 'jan '];
    return constantObj;
}

+ (FRConstant *)July {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"July" type: typeType code: 'jul '];
    return constantObj;
}

+ (FRConstant *)June {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"June" type: typeType code: 'jun '];
    return constantObj;
}

+ (FRConstant *)March {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"March" type: typeType code: 'mar '];
    return constantObj;
}

+ (FRConstant *)May {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"May" type: typeType code: 'may '];
    return constantObj;
}

+ (FRConstant *)Monday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Monday" type: typeType code: 'mon '];
    return constantObj;
}

+ (FRConstant *)November {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"November" type: typeType code: 'nov '];
    return constantObj;
}

+ (FRConstant *)October {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"October" type: typeType code: 'oct '];
    return constantObj;
}

+ (FRConstant *)PICTPicture {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"PICTPicture" type: typeType code: 'PICT'];
    return constantObj;
}

+ (FRConstant *)RGB16Color {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"RGB16Color" type: typeType code: 'tr16'];
    return constantObj;
}

+ (FRConstant *)RGB96Color {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"RGB96Color" type: typeType code: 'tr96'];
    return constantObj;
}

+ (FRConstant *)RGBColor {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"RGBColor" type: typeType code: 'cRGB'];
    return constantObj;
}

+ (FRConstant *)Saturday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Saturday" type: typeType code: 'sat '];
    return constantObj;
}

+ (FRConstant *)September {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"September" type: typeType code: 'sep '];
    return constantObj;
}

+ (FRConstant *)Sunday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Sunday" type: typeType code: 'sun '];
    return constantObj;
}

+ (FRConstant *)TIFFPicture {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"TIFFPicture" type: typeType code: 'TIFF'];
    return constantObj;
}

+ (FRConstant *)Thursday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Thursday" type: typeType code: 'thu '];
    return constantObj;
}

+ (FRConstant *)Tuesday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Tuesday" type: typeType code: 'tue '];
    return constantObj;
}

+ (FRConstant *)Wednesday {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"Wednesday" type: typeType code: 'wed '];
    return constantObj;
}

+ (FRConstant *)alias {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"alias" type: typeType code: 'alis'];
    return constantObj;
}

+ (FRConstant *)anything {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"anything" type: typeType code: '****'];
    return constantObj;
}

+ (FRConstant *)application {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"application" type: typeType code: 'capp'];
    return constantObj;
}

+ (FRConstant *)applicationBundleID {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"applicationBundleID" type: typeType code: 'bund'];
    return constantObj;
}

+ (FRConstant *)applicationSignature {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"applicationSignature" type: typeType code: 'sign'];
    return constantObj;
}

+ (FRConstant *)applicationURL {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"applicationURL" type: typeType code: 'aprl'];
    return constantObj;
}

+ (FRConstant *)attachment {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"attachment" type: typeType code: 'atts'];
    return constantObj;
}

+ (FRConstant *)attributeRun {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"attributeRun" type: typeType code: 'catr'];
    return constantObj;
}

+ (FRConstant *)best {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"best" type: typeType code: 'best'];
    return constantObj;
}

+ (FRConstant *)boolean {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"boolean" type: typeType code: 'bool'];
    return constantObj;
}

+ (FRConstant *)boundingRectangle {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"boundingRectangle" type: typeType code: 'qdrt'];
    return constantObj;
}

+ (FRConstant *)bounds {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"bounds" type: typeType code: 'pbnd'];
    return constantObj;
}

+ (FRConstant *)centimeters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"centimeters" type: typeType code: 'cmtr'];
    return constantObj;
}

+ (FRConstant *)character {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"character" type: typeType code: 'cha '];
    return constantObj;
}

+ (FRConstant *)classInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"classInfo" type: typeType code: 'gcli'];
    return constantObj;
}

+ (FRConstant *)class_ {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"class_" type: typeType code: 'pcls'];
    return constantObj;
}

+ (FRConstant *)closeable {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"closeable" type: typeType code: 'hclb'];
    return constantObj;
}

+ (FRConstant *)collating {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"collating" type: typeType code: 'lwcl'];
    return constantObj;
}

+ (FRConstant *)color {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"color" type: typeType code: 'colr'];
    return constantObj;
}

+ (FRConstant *)colorTable {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"colorTable" type: typeType code: 'clrt'];
    return constantObj;
}

+ (FRConstant *)copies {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"copies" type: typeType code: 'lwcp'];
    return constantObj;
}

+ (FRConstant *)cubicCentimeters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"cubicCentimeters" type: typeType code: 'ccmt'];
    return constantObj;
}

+ (FRConstant *)cubicFeet {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"cubicFeet" type: typeType code: 'cfet'];
    return constantObj;
}

+ (FRConstant *)cubicInches {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"cubicInches" type: typeType code: 'cuin'];
    return constantObj;
}

+ (FRConstant *)cubicMeters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"cubicMeters" type: typeType code: 'cmet'];
    return constantObj;
}

+ (FRConstant *)cubicYards {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"cubicYards" type: typeType code: 'cyrd'];
    return constantObj;
}

+ (FRConstant *)dashStyle {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"dashStyle" type: typeType code: 'tdas'];
    return constantObj;
}

+ (FRConstant *)data {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"data" type: typeType code: 'rdat'];
    return constantObj;
}

+ (FRConstant *)date {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"date" type: typeType code: 'ldt '];
    return constantObj;
}

+ (FRConstant *)decimalStruct {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"decimalStruct" type: typeType code: 'decm'];
    return constantObj;
}

+ (FRConstant *)degreesCelsius {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"degreesCelsius" type: typeType code: 'degc'];
    return constantObj;
}

+ (FRConstant *)degreesFahrenheit {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"degreesFahrenheit" type: typeType code: 'degf'];
    return constantObj;
}

+ (FRConstant *)degreesKelvin {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"degreesKelvin" type: typeType code: 'degk'];
    return constantObj;
}

+ (FRConstant *)document {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"document" type: typeType code: 'docu'];
    return constantObj;
}

+ (FRConstant *)doubleInteger {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"doubleInteger" type: typeType code: 'comp'];
    return constantObj;
}

+ (FRConstant *)elementInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"elementInfo" type: typeType code: 'elin'];
    return constantObj;
}

+ (FRConstant *)encodedString {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"encodedString" type: typeType code: 'encs'];
    return constantObj;
}

+ (FRConstant *)endingPage {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"endingPage" type: typeType code: 'lwlp'];
    return constantObj;
}

+ (FRConstant *)enumerator {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"enumerator" type: typeType code: 'enum'];
    return constantObj;
}

+ (FRConstant *)errorHandling {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"errorHandling" type: typeType code: 'lweh'];
    return constantObj;
}

+ (FRConstant *)eventInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"eventInfo" type: typeType code: 'evin'];
    return constantObj;
}

+ (FRConstant *)extendedFloat {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"extendedFloat" type: typeType code: 'exte'];
    return constantObj;
}

+ (FRConstant *)faxNumber {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"faxNumber" type: typeType code: 'faxn'];
    return constantObj;
}

+ (FRConstant *)feet {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"feet" type: typeType code: 'feet'];
    return constantObj;
}

+ (FRConstant *)fileName {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fileName" type: typeType code: 'atfn'];
    return constantObj;
}

+ (FRConstant *)fileRef {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fileRef" type: typeType code: 'fsrf'];
    return constantObj;
}

+ (FRConstant *)fileSpecification {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fileSpecification" type: typeType code: 'fss '];
    return constantObj;
}

+ (FRConstant *)fileURL {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fileURL" type: typeType code: 'furl'];
    return constantObj;
}

+ (FRConstant *)fixed {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fixed" type: typeType code: 'fixd'];
    return constantObj;
}

+ (FRConstant *)fixedPoint {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fixedPoint" type: typeType code: 'fpnt'];
    return constantObj;
}

+ (FRConstant *)fixedRectangle {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"fixedRectangle" type: typeType code: 'frct'];
    return constantObj;
}

+ (FRConstant *)float128bit {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"float128bit" type: typeType code: 'ldbl'];
    return constantObj;
}

+ (FRConstant *)float_ {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"float_" type: typeType code: 'doub'];
    return constantObj;
}

+ (FRConstant *)floating {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"floating" type: typeType code: 'isfl'];
    return constantObj;
}

+ (FRConstant *)font {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"font" type: typeType code: 'font'];
    return constantObj;
}

+ (FRConstant *)frontmost {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"frontmost" type: typeType code: 'pisf'];
    return constantObj;
}

+ (FRConstant *)gallons {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"gallons" type: typeType code: 'galn'];
    return constantObj;
}

+ (FRConstant *)grams {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"grams" type: typeType code: 'gram'];
    return constantObj;
}

+ (FRConstant *)graphicText {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"graphicText" type: typeType code: 'cgtx'];
    return constantObj;
}

+ (FRConstant *)id_ {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"id_" type: typeType code: 'ID  '];
    return constantObj;
}

+ (FRConstant *)inches {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"inches" type: typeType code: 'inch'];
    return constantObj;
}

+ (FRConstant *)index {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"index" type: typeType code: 'pidx'];
    return constantObj;
}

+ (FRConstant *)integer {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"integer" type: typeType code: 'long'];
    return constantObj;
}

+ (FRConstant *)internationalText {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"internationalText" type: typeType code: 'itxt'];
    return constantObj;
}

+ (FRConstant *)internationalWritingCode {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"internationalWritingCode" type: typeType code: 'intl'];
    return constantObj;
}

+ (FRConstant *)item {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"item" type: typeType code: 'cobj'];
    return constantObj;
}

+ (FRConstant *)kernelProcessID {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"kernelProcessID" type: typeType code: 'kpid'];
    return constantObj;
}

+ (FRConstant *)kilograms {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"kilograms" type: typeType code: 'kgrm'];
    return constantObj;
}

+ (FRConstant *)kilometers {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"kilometers" type: typeType code: 'kmtr'];
    return constantObj;
}

+ (FRConstant *)list {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"list" type: typeType code: 'list'];
    return constantObj;
}

+ (FRConstant *)liters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"liters" type: typeType code: 'litr'];
    return constantObj;
}

+ (FRConstant *)locationReference {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"locationReference" type: typeType code: 'insl'];
    return constantObj;
}

+ (FRConstant *)longFixed {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"longFixed" type: typeType code: 'lfxd'];
    return constantObj;
}

+ (FRConstant *)longFixedPoint {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"longFixedPoint" type: typeType code: 'lfpt'];
    return constantObj;
}

+ (FRConstant *)longFixedRectangle {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"longFixedRectangle" type: typeType code: 'lfrc'];
    return constantObj;
}

+ (FRConstant *)longPoint {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"longPoint" type: typeType code: 'lpnt'];
    return constantObj;
}

+ (FRConstant *)longRectangle {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"longRectangle" type: typeType code: 'lrct'];
    return constantObj;
}

+ (FRConstant *)machPort {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"machPort" type: typeType code: 'port'];
    return constantObj;
}

+ (FRConstant *)machine {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"machine" type: typeType code: 'mach'];
    return constantObj;
}

+ (FRConstant *)machineLocation {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"machineLocation" type: typeType code: 'mLoc'];
    return constantObj;
}

+ (FRConstant *)meters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"meters" type: typeType code: 'metr'];
    return constantObj;
}

+ (FRConstant *)miles {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"miles" type: typeType code: 'mile'];
    return constantObj;
}

+ (FRConstant *)miniaturizable {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"miniaturizable" type: typeType code: 'ismn'];
    return constantObj;
}

+ (FRConstant *)miniaturized {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"miniaturized" type: typeType code: 'pmnd'];
    return constantObj;
}

+ (FRConstant *)missingValue {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"missingValue" type: typeType code: 'msng'];
    return constantObj;
}

+ (FRConstant *)modal {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"modal" type: typeType code: 'pmod'];
    return constantObj;
}

+ (FRConstant *)modified {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"modified" type: typeType code: 'imod'];
    return constantObj;
}

+ (FRConstant *)name {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"name" type: typeType code: 'pnam'];
    return constantObj;
}

+ (FRConstant *)null {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"null" type: typeType code: 'null'];
    return constantObj;
}

+ (FRConstant *)ounces {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"ounces" type: typeType code: 'ozs '];
    return constantObj;
}

+ (FRConstant *)pagesAcross {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"pagesAcross" type: typeType code: 'lwla'];
    return constantObj;
}

+ (FRConstant *)pagesDown {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"pagesDown" type: typeType code: 'lwld'];
    return constantObj;
}

+ (FRConstant *)paragraph {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"paragraph" type: typeType code: 'cpar'];
    return constantObj;
}

+ (FRConstant *)parameterInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"parameterInfo" type: typeType code: 'pmin'];
    return constantObj;
}

+ (FRConstant *)path {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"path" type: typeType code: 'ppth'];
    return constantObj;
}

+ (FRConstant *)pixelMapRecord {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"pixelMapRecord" type: typeType code: 'tpmm'];
    return constantObj;
}

+ (FRConstant *)point {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"point" type: typeType code: 'QDpt'];
    return constantObj;
}

+ (FRConstant *)pounds {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"pounds" type: typeType code: 'lbs '];
    return constantObj;
}

+ (FRConstant *)printSettings {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"printSettings" type: typeType code: 'pset'];
    return constantObj;
}

+ (FRConstant *)processSerialNumber {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"processSerialNumber" type: typeType code: 'psn '];
    return constantObj;
}

+ (FRConstant *)properties {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"properties" type: typeType code: 'pALL'];
    return constantObj;
}

+ (FRConstant *)property {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"property" type: typeType code: 'prop'];
    return constantObj;
}

+ (FRConstant *)propertyInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"propertyInfo" type: typeType code: 'pinf'];
    return constantObj;
}

+ (FRConstant *)quarts {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"quarts" type: typeType code: 'qrts'];
    return constantObj;
}

+ (FRConstant *)record {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"record" type: typeType code: 'reco'];
    return constantObj;
}

+ (FRConstant *)reference {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"reference" type: typeType code: 'obj '];
    return constantObj;
}

+ (FRConstant *)requestedPrintTime {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"requestedPrintTime" type: typeType code: 'lwqt'];
    return constantObj;
}

+ (FRConstant *)resizable {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"resizable" type: typeType code: 'prsz'];
    return constantObj;
}

+ (FRConstant *)rotation {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"rotation" type: typeType code: 'trot'];
    return constantObj;
}

+ (FRConstant *)script {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"script" type: typeType code: 'scpt'];
    return constantObj;
}

+ (FRConstant *)shortFloat {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"shortFloat" type: typeType code: 'sing'];
    return constantObj;
}

+ (FRConstant *)shortInteger {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"shortInteger" type: typeType code: 'shor'];
    return constantObj;
}

+ (FRConstant *)size {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"size" type: typeType code: 'ptsz'];
    return constantObj;
}

+ (FRConstant *)squareFeet {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"squareFeet" type: typeType code: 'sqft'];
    return constantObj;
}

+ (FRConstant *)squareKilometers {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"squareKilometers" type: typeType code: 'sqkm'];
    return constantObj;
}

+ (FRConstant *)squareMeters {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"squareMeters" type: typeType code: 'sqrm'];
    return constantObj;
}

+ (FRConstant *)squareMiles {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"squareMiles" type: typeType code: 'sqmi'];
    return constantObj;
}

+ (FRConstant *)squareYards {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"squareYards" type: typeType code: 'sqyd'];
    return constantObj;
}

+ (FRConstant *)startingPage {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"startingPage" type: typeType code: 'lwfp'];
    return constantObj;
}

+ (FRConstant *)string {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"string" type: typeType code: 'TEXT'];
    return constantObj;
}

+ (FRConstant *)styledClipboardText {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"styledClipboardText" type: typeType code: 'styl'];
    return constantObj;
}

+ (FRConstant *)styledText {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"styledText" type: typeType code: 'STXT'];
    return constantObj;
}

+ (FRConstant *)suiteInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"suiteInfo" type: typeType code: 'suin'];
    return constantObj;
}

+ (FRConstant *)targetPrinter {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"targetPrinter" type: typeType code: 'trpr'];
    return constantObj;
}

+ (FRConstant *)text {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"text" type: typeType code: 'ctxt'];
    return constantObj;
}

+ (FRConstant *)textStyleInfo {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"textStyleInfo" type: typeType code: 'tsty'];
    return constantObj;
}

+ (FRConstant *)titled {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"titled" type: typeType code: 'ptit'];
    return constantObj;
}

+ (FRConstant *)typeClass {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"typeClass" type: typeType code: 'type'];
    return constantObj;
}

+ (FRConstant *)unicodeText {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"unicodeText" type: typeType code: 'utxt'];
    return constantObj;
}

+ (FRConstant *)unsignedInteger {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"unsignedInteger" type: typeType code: 'magn'];
    return constantObj;
}

+ (FRConstant *)utf16Text {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"utf16Text" type: typeType code: 'ut16'];
    return constantObj;
}

+ (FRConstant *)utf8Text {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"utf8Text" type: typeType code: 'utf8'];
    return constantObj;
}

+ (FRConstant *)version {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"version" type: typeType code: 'vers'];
    return constantObj;
}

+ (FRConstant *)version_ {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"version_" type: typeType code: 'vers'];
    return constantObj;
}

+ (FRConstant *)visible {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"visible" type: typeType code: 'pvis'];
    return constantObj;
}

+ (FRConstant *)window {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"window" type: typeType code: 'cwin'];
    return constantObj;
}

+ (FRConstant *)word {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"word" type: typeType code: 'cwor'];
    return constantObj;
}

+ (FRConstant *)writingCode {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"writingCode" type: typeType code: 'psct'];
    return constantObj;
}

+ (FRConstant *)yards {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"yards" type: typeType code: 'yard'];
    return constantObj;
}

+ (FRConstant *)zoomable {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"zoomable" type: typeType code: 'iszm'];
    return constantObj;
}

+ (FRConstant *)zoomed {
    static FRConstant *constantObj;
    if (!constantObj)
        constantObj = [FRConstant constantWithName: @"zoomed" type: typeType code: 'pzum'];
    return constantObj;
}

@end

