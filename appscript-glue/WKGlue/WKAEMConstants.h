/*
 * WKAEMConstants.h
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"

/* Types, enumerators, properties */

enum {
    kWKApplicationResponses = 'rmte',
    kWKAsk = 'ask ',
    kWKCase_ = 'case',
    kWKDetailed = 'lwdt',
    kWKDiacriticals = 'diac',
    kWKExpansion = 'expa',
    kWKHyphens = 'hyph',
    kWKNo = 'no  ',
    kWKNumericStrings = 'nume',
    kWKPunctuation = 'punc',
    kWKStandard = 'lwst',
    kWKWhitespace = 'whit',
    kWKYes = 'yes ',
    kWKApril = 'apr ',
    kWKAugust = 'aug ',
    kWKDecember = 'dec ',
    kWKEPSPicture = 'EPS ',
    kWKFebruary = 'feb ',
    kWKFriday = 'fri ',
    kWKGIFPicture = 'GIFf',
    kWKJPEGPicture = 'JPEG',
    kWKJanuary = 'jan ',
    kWKJuly = 'jul ',
    kWKJune = 'jun ',
    kWKMarch = 'mar ',
    kWKMay = 'may ',
    kWKMonday = 'mon ',
    kWKNovember = 'nov ',
    kWKOctober = 'oct ',
    kWKPICTPicture = 'PICT',
    kWKRGB16Color = 'tr16',
    kWKRGB96Color = 'tr96',
    kWKRGBColor = 'cRGB',
    kWKSaturday = 'sat ',
    kWKSeptember = 'sep ',
    kWKSunday = 'sun ',
    kWKTIFFPicture = 'TIFF',
    kWKThursday = 'thu ',
    kWKTuesday = 'tue ',
    kWKURL = 'pURL',
    kWKWednesday = 'wed ',
    kWKAlias = 'alis',
    kWKAnything = '****',
    kWKApplication = 'capp',
    kWKApplicationBundleID = 'bund',
    kWKApplicationSignature = 'sign',
    kWKApplicationURL = 'aprl',
    kWKAttachment = 'atts',
    kWKAttributeRun = 'catr',
    kWKBest = 'best',
    kWKBoolean = 'bool',
    kWKBoundingRectangle = 'qdrt',
    kWKBounds = 'pbnd',
    kWKCentimeters = 'cmtr',
    kWKCharacter = 'cha ',
    kWKClassInfo = 'gcli',
    kWKClass_ = 'pcls',
    kWKCloseable = 'hclb',
    kWKCollating = 'lwcl',
    kWKColor = 'colr',
    kWKColorTable = 'clrt',
    kWKCopies = 'lwcp',
    kWKCubicCentimeters = 'ccmt',
    kWKCubicFeet = 'cfet',
    kWKCubicInches = 'cuin',
    kWKCubicMeters = 'cmet',
    kWKCubicYards = 'cyrd',
    kWKCurrentTab = 'cTab',
    kWKDashStyle = 'tdas',
    kWKData = 'rdat',
    kWKDate = 'ldt ',
    kWKDecimalStruct = 'decm',
    kWKDegreesCelsius = 'degc',
    kWKDegreesFahrenheit = 'degf',
    kWKDegreesKelvin = 'degk',
    kWKDocument = 'docu',
    kWKDoubleInteger = 'comp',
    kWKElementInfo = 'elin',
    kWKEncodedString = 'encs',
    kWKEndingPage = 'lwlp',
    kWKEnumerator = 'enum',
    kWKErrorHandling = 'lweh',
    kWKEventInfo = 'evin',
    kWKExtendedFloat = 'exte',
    kWKFaxNumber = 'faxn',
    kWKFeet = 'feet',
    kWKFileName = 'atfn',
    kWKFileRef = 'fsrf',
    kWKFileSpecification = 'fss ',
    kWKFileURL = 'furl',
    kWKFixed = 'fixd',
    kWKFixedPoint = 'fpnt',
    kWKFixedRectangle = 'frct',
    kWKFloat128bit = 'ldbl',
    kWKFloat_ = 'doub',
    kWKFloating = 'isfl',
    kWKFont = 'font',
    kWKFrontmost = 'pisf',
    kWKGallons = 'galn',
    kWKGrams = 'gram',
    kWKGraphicText = 'cgtx',
    kWKId_ = 'ID  ',
    kWKInches = 'inch',
    kWKIndex = 'pidx',
    kWKInteger = 'long',
    kWKInternationalText = 'itxt',
    kWKInternationalWritingCode = 'intl',
    kWKItem = 'cobj',
    kWKKernelProcessID = 'kpid',
    kWKKilograms = 'kgrm',
    kWKKilometers = 'kmtr',
    kWKList = 'list',
    kWKLiters = 'litr',
    kWKLocationReference = 'insl',
    kWKLongFixed = 'lfxd',
    kWKLongFixedPoint = 'lfpt',
    kWKLongFixedRectangle = 'lfrc',
    kWKLongPoint = 'lpnt',
    kWKLongRectangle = 'lrct',
    kWKMachPort = 'port',
    kWKMachine = 'mach',
    kWKMachineLocation = 'mLoc',
    kWKMeters = 'metr',
    kWKMiles = 'mile',
    kWKMiniaturizable = 'ismn',
    kWKMiniaturized = 'pmnd',
    kWKMissingValue = 'msng',
    kWKModal = 'pmod',
    kWKModified = 'imod',
    kWKName = 'pnam',
    kWKNull = 'null',
    kWKOunces = 'ozs ',
    kWKPagesAcross = 'lwla',
    kWKPagesDown = 'lwld',
    kWKParagraph = 'cpar',
    kWKParameterInfo = 'pmin',
    kWKPath = 'ppth',
    kWKPixelMapRecord = 'tpmm',
    kWKPoint = 'QDpt',
    kWKPounds = 'lbs ',
    kWKPrintSettings = 'pset',
    kWKProcessSerialNumber = 'psn ',
    kWKProperties = 'pALL',
    kWKProperty = 'prop',
    kWKPropertyInfo = 'pinf',
    kWKQuarts = 'qrts',
    kWKRecord = 'reco',
    kWKReference = 'obj ',
    kWKRequestedPrintTime = 'lwqt',
    kWKResizable = 'prsz',
    kWKRotation = 'trot',
    kWKScript = 'scpt',
    kWKShortFloat = 'sing',
    kWKShortInteger = 'shor',
    kWKSize = 'ptsz',
    kWKSource = 'conT',
    kWKSquareFeet = 'sqft',
    kWKSquareKilometers = 'sqkm',
    kWKSquareMeters = 'sqrm',
    kWKSquareMiles = 'sqmi',
    kWKSquareYards = 'sqyd',
    kWKStartingPage = 'lwfp',
    kWKString = 'TEXT',
    kWKStyledClipboardText = 'styl',
    kWKStyledText = 'STXT',
    kWKSuiteInfo = 'suin',
    kWKTab = 'bTab',
    kWKTargetPrinter = 'trpr',
    kWKText = 'ctxt',
    kWKTextStyleInfo = 'tsty',
    kWKTitled = 'ptit',
    kWKTypeClass = 'type',
    kWKUnicodeText = 'utxt',
    kWKUnsignedInteger = 'magn',
    kWKUtf16Text = 'ut16',
    kWKUtf8Text = 'utf8',
    kWKVersion = 'vers',
    kWKVersion_ = 'vers',
    kWKVisible = 'pvis',
    kWKWindow = 'cwin',
    kWKWord = 'cwor',
    kWKWritingCode = 'psct',
    kWKYards = 'yard',
    kWKZoomable = 'iszm',
    kWKZoomed = 'pzum',
};

enum {
    eWKApplications = 'capp',
    eWKAttachment = 'atts',
    eWKAttributeRuns = 'catr',
    eWKCharacters = 'cha ',
    eWKColors = 'colr',
    eWKDocuments = 'docu',
    eWKItems = 'cobj',
    eWKParagraphs = 'cpar',
    eWKPrintSettings = 'pset',
    eWKTabs = 'bTab',
    eWKText = 'ctxt',
    eWKWindows = 'cwin',
    eWKWords = 'cwor',
    pWKURL = 'pURL',
    pWKBounds = 'pbnd',
    pWKClass_ = 'pcls',
    pWKCloseable = 'hclb',
    pWKCollating = 'lwcl',
    pWKColor = 'colr',
    pWKCopies = 'lwcp',
    pWKCurrentTab = 'cTab',
    pWKDocument = 'docu',
    pWKEndingPage = 'lwlp',
    pWKErrorHandling = 'lweh',
    pWKFaxNumber = 'faxn',
    pWKFileName = 'atfn',
    pWKFloating = 'isfl',
    pWKFont = 'font',
    pWKFrontmost = 'pisf',
    pWKId_ = 'ID  ',
    pWKIndex = 'pidx',
    pWKMiniaturizable = 'ismn',
    pWKMiniaturized = 'pmnd',
    pWKModal = 'pmod',
    pWKModified = 'imod',
    pWKName = 'pnam',
    pWKPagesAcross = 'lwla',
    pWKPagesDown = 'lwld',
    pWKPath = 'ppth',
    pWKProperties = 'pALL',
    pWKRequestedPrintTime = 'lwqt',
    pWKResizable = 'prsz',
    pWKSize = 'ptsz',
    pWKSource = 'conT',
    pWKStartingPage = 'lwfp',
    pWKTargetPrinter = 'trpr',
    pWKTitled = 'ptit',
    pWKVersion_ = 'vers',
    pWKVisible = 'pvis',
    pWKZoomable = 'iszm',
    pWKZoomed = 'pzum',
};


/* Events */

enum {
    ecWKActivate = 'misc',
    eiWKActivate = 'actv',
};

enum {
    ecWKClose = 'core',
    eiWKClose = 'clos',
    epWKSaving = 'savo',
    epWKSavingIn = 'kfil',
};

enum {
    ecWKCount = 'core',
    eiWKCount = 'cnte',
    epWKEach = 'kocl',
};

enum {
    ecWKDelete = 'core',
    eiWKDelete = 'delo',
};

enum {
    ecWKDoJavaScript = 'sfri',
    eiWKDoJavaScript = 'dojs',
    epWKIn = 'dcnm',
};

enum {
    ecWKDuplicate = 'core',
    eiWKDuplicate = 'clon',
    epWKTo = 'insh',
    epWKWithProperties = 'prdt',
};

enum {
    ecWKEmailContents = 'sfri',
    eiWKEmailContents = 'mlct',
    epWKOf = 'dcnm',
};

enum {
    ecWKExists = 'core',
    eiWKExists = 'doex',
};

enum {
    ecWKGet = 'core',
    eiWKGet = 'getd',
};

enum {
    ecWKLaunch = 'ascr',
    eiWKLaunch = 'noop',
};

enum {
    ecWKMake = 'core',
    eiWKMake = 'crel',
    epWKAt = 'insh',
    epWKNew_ = 'kocl',
    epWKWithData = 'data',
//  epWKWithProperties = 'prdt',
};

enum {
    ecWKMove = 'core',
    eiWKMove = 'move',
//  epWKTo = 'insh',
};

enum {
    ecWKOpen = 'aevt',
    eiWKOpen = 'odoc',
};

enum {
    ecWKOpenLocation = 'GURL',
    eiWKOpenLocation = 'GURL',
    epWKWindow = 'WIND',
};

enum {
    ecWKPrint = 'aevt',
    eiWKPrint = 'pdoc',
    epWKPrintDialog = 'pdlg',
//  epWKWithProperties = 'prdt',
};

enum {
    ecWKQuit = 'aevt',
    eiWKQuit = 'quit',
//  epWKSaving = 'savo',
};

enum {
    ecWKReopen = 'aevt',
    eiWKReopen = 'rapp',
};

enum {
    ecWKRun = 'aevt',
    eiWKRun = 'oapp',
};

enum {
    ecWKSave = 'core',
    eiWKSave = 'save',
    epWKAs = 'fltp',
//  epWKIn = 'kfil',
};

enum {
    ecWKSet = 'core',
    eiWKSet = 'setd',
//  epWKTo = 'data',
};

enum {
    ecWKShowBookmarks = 'sfri',
    eiWKShowBookmarks = 'opbk',
};

