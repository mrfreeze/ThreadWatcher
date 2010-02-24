/*
 * OPAEMConstants.h
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"

/* Types, enumerators, properties */

enum {
    kOPApplicationResponses = 'rmte',
    kOPAsk = 'ask ',
    kOPCase_ = 'case',
    kOPDiacriticals = 'diac',
    kOPExpansion = 'expa',
    kOPHyphens = 'hyph',
    kOPNo = 'no  ',
    kOPNumericStrings = 'nume',
    kOPPunctuation = 'punc',
    kOPWhitespace = 'whit',
    kOPYes = 'yes ',
    kOPApril = 'apr ',
    kOPAugust = 'aug ',
    kOPDecember = 'dec ',
    kOPEPSPicture = 'EPS ',
    kOPFebruary = 'feb ',
    kOPFriday = 'fri ',
    kOPGIFPicture = 'GIFf',
    kOPJPEGPicture = 'JPEG',
    kOPJanuary = 'jan ',
    kOPJuly = 'jul ',
    kOPJune = 'jun ',
    kOPMarch = 'mar ',
    kOPMay = 'may ',
    kOPMonday = 'mon ',
    kOPNovember = 'nov ',
    kOPOctober = 'oct ',
    kOPPICTPicture = 'PICT',
    kOPRGB16Color = 'tr16',
    kOPRGB96Color = 'tr96',
    kOPRGBColor = 'cRGB',
    kOPSaturday = 'sat ',
    kOPSeptember = 'sep ',
    kOPSunday = 'sun ',
    kOPTIFFPicture = 'TIFF',
    kOPThursday = 'thu ',
    kOPTuesday = 'tue ',
    kOPWednesday = 'wed ',
    kOPAlias = 'alis',
    kOPAnything = '****',
    kOPApplication = 'capp',
    kOPApplicationBundleID = 'bund',
    kOPApplicationSignature = 'sign',
    kOPApplicationURL = 'aprl',
    kOPBest = 'best',
    kOPBoolean = 'bool',
    kOPBoundingRectangle = 'qdrt',
    kOPBounds = 'pbnd',
    kOPCentimeters = 'cmtr',
    kOPClassInfo = 'gcli',
    kOPClass_ = 'pcls',
    kOPCloseable = 'hclb',
    kOPColorTable = 'clrt',
    kOPCubicCentimeters = 'ccmt',
    kOPCubicFeet = 'cfet',
    kOPCubicInches = 'cuin',
    kOPCubicMeters = 'cmet',
    kOPCubicYards = 'cyrd',
    kOPDashStyle = 'tdas',
    kOPData = 'rdat',
    kOPDate = 'ldt ',
    kOPDecimalStruct = 'decm',
    kOPDegreesCelsius = 'degc',
    kOPDegreesFahrenheit = 'degf',
    kOPDegreesKelvin = 'degk',
    kOPDocument = 'docu',
    kOPDoubleInteger = 'comp',
    kOPElementInfo = 'elin',
    kOPEncodedString = 'encs',
    kOPEnumerator = 'enum',
    kOPEventInfo = 'evin',
    kOPExtendedFloat = 'exte',
    kOPFeet = 'feet',
    kOPFileRef = 'fsrf',
    kOPFileSpecification = 'fss ',
    kOPFileURL = 'furl',
    kOPFixed = 'fixd',
    kOPFixedPoint = 'fpnt',
    kOPFixedRectangle = 'frct',
    kOPFloat128bit = 'ldbl',
    kOPFloat_ = 'doub',
    kOPFloating = 'isfl',
    kOPGallons = 'galn',
    kOPGrams = 'gram',
    kOPGraphicText = 'cgtx',
    kOPId_ = 'ID  ',
    kOPInches = 'inch',
    kOPIndex = 'pidx',
    kOPInteger = 'long',
    kOPInternationalText = 'itxt',
    kOPInternationalWritingCode = 'intl',
    kOPItem = 'cobj',
    kOPKernelProcessID = 'kpid',
    kOPKilograms = 'kgrm',
    kOPKilometers = 'kmtr',
    kOPList = 'list',
    kOPLiters = 'litr',
    kOPLoading = 'LOad',
    kOPLocationReference = 'insl',
    kOPLongFixed = 'lfxd',
    kOPLongFixedPoint = 'lfpt',
    kOPLongFixedRectangle = 'lfrc',
    kOPLongPoint = 'lpnt',
    kOPLongRectangle = 'lrct',
    kOPMachPort = 'port',
    kOPMachine = 'mach',
    kOPMachineLocation = 'mLoc',
    kOPMeters = 'metr',
    kOPMiles = 'mile',
    kOPMiniaturizable = 'ismn',
    kOPMiniaturized = 'minU',
    kOPMissingValue = 'msng',
    kOPModal = 'pmod',
    kOPModified = 'imod',
    kOPName = 'pnam',
    kOPNull = 'null',
    kOPOunces = 'ozs ',
    kOPParameterInfo = 'pmin',
    kOPPixelMapRecord = 'tpmm',
    kOPPoint = 'QDpt',
    kOPPounds = 'lbs ',
    kOPProcessSerialNumber = 'psn ',
    kOPProperties = 'pALL',
    kOPProperty = 'prop',
    kOPPropertyInfo = 'pinf',
    kOPQuarts = 'qrts',
    kOPRecord = 'reco',
    kOPReference = 'obj ',
    kOPResizable = 'prsz',
    kOPRotation = 'trot',
    kOPScript = 'scpt',
    kOPShortFloat = 'sing',
    kOPShortInteger = 'shor',
    kOPSquareFeet = 'sqft',
    kOPSquareKilometers = 'sqkm',
    kOPSquareMeters = 'sqrm',
    kOPSquareMiles = 'sqmi',
    kOPSquareYards = 'sqyd',
    kOPString = 'TEXT',
    kOPStyledClipboardText = 'styl',
    kOPStyledText = 'STXT',
    kOPSuiteInfo = 'suin',
    kOPTextStyleInfo = 'tsty',
    kOPTitled = 'ptit',
    kOPTypeClass = 'type',
    kOPUnicodeText = 'utxt',
    kOPUnsignedInteger = 'magn',
    kOPUrl = 'url ',
    kOPUtf16Text = 'ut16',
    kOPUtf8Text = 'utf8',
    kOPVersion = 'vers',
    kOPVisible = 'pvis',
    kOPWindow = 'cwin',
    kOPWritingCode = 'psct',
    kOPYards = 'yard',
    kOPZoomable = 'iszm',
    kOPZoomed = 'pzum',
};

enum {
    eOPApplication = 'capp',
    eOPDocument = 'docu',
    eOPItems = 'cobj',
    pOPBounds = 'pbnd',
    pOPClass_ = 'pcls',
    pOPCloseable = 'hclb',
    pOPFloating = 'isfl',
    pOPId_ = 'ID  ',
    pOPIndex = 'pidx',
    pOPLoading = 'LOad',
    pOPMiniaturizable = 'ismn',
    pOPMiniaturized = 'minU',
    pOPModal = 'pmod',
    pOPModified = 'imod',
    pOPName = 'pnam',
    pOPProperties = 'pALL',
    pOPResizable = 'prsz',
    pOPTitled = 'ptit',
    pOPUrl = 'url ',
    pOPVisible = 'pvis',
    pOPWindow = 'wndw',
    pOPZoomable = 'iszm',
    pOPZoomed = 'pzum',
};


/* Events */

enum {
    ecOPCloseAllWindows = 'WWW!',
    eiOPCloseAllWindows = 'CLSA',
};

enum {
    ecOPCloseWindow = 'WWW!',
    eiOPCloseWindow = 'CLOS',
    epOPID_ = 'WIND',
    epOPTitle = 'TITL',
};

enum {
    ecOPGetSource = 'MSIE',
    eiOPGetSource = 'SORC',
};

enum {
    ecOPGetURL = 'GURL',
    eiOPGetURL = 'GURL',
    epOPTo = 'dest',
};

enum {
    ecOPGetWindowInfo = 'WWW!',
    eiOPGetWindowInfo = 'WNFO',
};

enum {
    ecOPListWindows = 'WWW!',
    eiOPListWindows = 'LSTW',
};

enum {
    ecOPOpenURL = 'WWW!',
    eiOPOpenURL = 'OURL',
    epOPFlags = 'FLGS',
    epOPFormData = 'POST',
    epOPMIMEType = 'MIME',
    epOPProgressApp = 'PROG',
    epOPResultApp = 'RSLT',
//  epOPTo = 'INTO',
    epOPToWindow = 'WIND',
};

enum {
    ecOPRegisterURLEcho = 'WWW!',
    eiOPRegisterURLEcho = 'RGUE',
};

enum {
    ecOPShowFile = 'WWW!',
    eiOPShowFile = 'SHWF',
//  epOPMIMEType = 'MIME',
//  epOPResultApp = 'RSLT',
    epOPURL = 'URL ',
    epOPWindowID = 'WIND',
};

enum {
    ecOPUnRegisterURLEcho = 'WWW!',
    eiOPUnRegisterURLEcho = 'UNRU',
};

enum {
    ecOPActivate = 'misc',
    eiOPActivate = 'actv',
};

enum {
    ecOPClose = 'core',
    eiOPClose = 'clos',
    epOPIn = 'kfil',
    epOPSaving = 'savo',
};

enum {
    ecOPCount = 'core',
    eiOPCount = 'cnte',
    epOPEach = 'kocl',
};

enum {
    ecOPDataSize = 'core',
    eiOPDataSize = 'dsiz',
};

enum {
    ecOPExists = 'core',
    eiOPExists = 'doex',
};

enum {
    ecOPGet = 'core',
    eiOPGet = 'getd',
};

enum {
    ecOPLaunch = 'ascr',
    eiOPLaunch = 'noop',
};

enum {
    ecOPMake = 'core',
    eiOPMake = 'crel',
    epOPAt = 'insh',
    epOPNew_ = 'kocl',
    epOPWithData = 'data',
    epOPWithProperties = 'prdt',
};

enum {
    ecOPOpen = 'aevt',
    eiOPOpen = 'odoc',
};

enum {
    ecOPOpenLocation = 'GURL',
    eiOPOpenLocation = 'GURL',
    epOPWindow = 'WIND',
};

enum {
    ecOPPrint = 'aevt',
    eiOPPrint = 'pdoc',
};

enum {
    ecOPQuit = 'aevt',
    eiOPQuit = 'quit',
//  epOPSaving = 'savo',
};

enum {
    ecOPReopen = 'aevt',
    eiOPReopen = 'rapp',
};

enum {
    ecOPRun = 'aevt',
    eiOPRun = 'oapp',
};

enum {
    ecOPSave = 'core',
    eiOPSave = 'save',
    epOPAs = 'fltp',
//  epOPIn = 'kfil',
};

enum {
    ecOPSet = 'core',
    eiOPSet = 'setd',
//  epOPTo = 'data',
};

