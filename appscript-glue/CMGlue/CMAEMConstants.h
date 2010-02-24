/*
 * CMAEMConstants.h
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"

/* Types, enumerators, properties */

enum {
    kCMApplicationResponses = 'rmte',
    kCMAsk = 'ask ',
    kCMCase_ = 'case',
    kCMDiacriticals = 'diac',
    kCMExpansion = 'expa',
    kCMHyphens = 'hyph',
    kCMNo = 'no  ',
    kCMNumericStrings = 'nume',
    kCMPunctuation = 'punc',
    kCMWhitespace = 'whit',
    kCMYes = 'yes ',
    kCMApril = 'apr ',
    kCMAugust = 'aug ',
    kCMDecember = 'dec ',
    kCMEPSPicture = 'EPS ',
    kCMFebruary = 'feb ',
    kCMFriday = 'fri ',
    kCMGIFPicture = 'GIFf',
    kCMJPEGPicture = 'JPEG',
    kCMJanuary = 'jan ',
    kCMJuly = 'jul ',
    kCMJune = 'jun ',
    kCMMarch = 'mar ',
    kCMMay = 'may ',
    kCMMonday = 'mon ',
    kCMNovember = 'nov ',
    kCMOctober = 'oct ',
    kCMPICTPicture = 'PICT',
    kCMRGB16Color = 'tr16',
    kCMRGB96Color = 'tr96',
    kCMRGBColor = 'cRGB',
    kCMSaturday = 'sat ',
    kCMSeptember = 'sep ',
    kCMSunday = 'sun ',
    kCMTIFFPicture = 'TIFF',
    kCMThursday = 'thu ',
    kCMTuesday = 'tue ',
    kCMURL = 'pURL',
    kCMWednesday = 'wed ',
    kCMAddressBookCollection = 'fadb',
    kCMAlias = 'alis',
    kCMAnything = '****',
    kCMApplication = 'capp',
    kCMApplicationBundleID = 'bund',
    kCMApplicationSignature = 'sign',
    kCMApplicationURL = 'aprl',
    kCMBest = 'best',
    kCMBonjourCollection = 'fbjr',
    kCMBookmark = 'BMBk',
    kCMBookmarkBarCollection = 'fbar',
    kCMBookmarkFolder = 'BMFl',
    kCMBookmarkItem = 'BMIt',
    kCMBookmarkMenuCollection = 'fmnu',
    kCMBoolean = 'bool',
    kCMBoundingRectangle = 'qdrt',
    kCMBounds = 'pbnd',
    kCMBrowserWindow = 'BWin',
    kCMCentimeters = 'cmtr',
    kCMClassInfo = 'gcli',
    kCMClass_ = 'pcls',
    kCMCloseable = 'hclb',
    kCMColorTable = 'clrt',
    kCMCubicCentimeters = 'ccmt',
    kCMCubicFeet = 'cfet',
    kCMCubicInches = 'cuin',
    kCMCubicMeters = 'cmet',
    kCMCubicYards = 'cyrd',
    kCMCurrentTab = 'pCTb',
    kCMDashStyle = 'tdas',
    kCMData = 'rdat',
    kCMDate = 'ldt ',
    kCMDecimalStruct = 'decm',
    kCMDegreesCelsius = 'degc',
    kCMDegreesFahrenheit = 'degf',
    kCMDegreesKelvin = 'degk',
    kCMDescription_ = 'pdes',
    kCMDoubleInteger = 'comp',
    kCMElementInfo = 'elin',
    kCMEncodedString = 'encs',
    kCMEnumerator = 'enum',
    kCMEventInfo = 'evin',
    kCMExtendedFloat = 'exte',
    kCMFeet = 'feet',
    kCMFileRef = 'fsrf',
    kCMFileSpecification = 'fss ',
    kCMFileURL = 'furl',
    kCMFixed = 'fixd',
    kCMFixedPoint = 'fpnt',
    kCMFixedRectangle = 'frct',
    kCMFloat128bit = 'ldbl',
    kCMFloat_ = 'doub',
    kCMFloating = 'isfl',
    kCMFrontmost = 'pisf',
    kCMGallons = 'galn',
    kCMGrams = 'gram',
    kCMGraphicText = 'cgtx',
    kCMId_ = 'ID  ',
    kCMInches = 'inch',
    kCMIndex = 'pidx',
    kCMInteger = 'long',
    kCMInternationalText = 'itxt',
    kCMInternationalWritingCode = 'intl',
    kCMItem = 'cobj',
    kCMKernelProcessID = 'kpid',
    kCMKilograms = 'kgrm',
    kCMKilometers = 'kmtr',
    kCMLastVisitDate = 'pvst',
    kCMList = 'list',
    kCMLiters = 'litr',
    kCMLocationReference = 'insl',
    kCMLongFixed = 'lfxd',
    kCMLongFixedPoint = 'lfpt',
    kCMLongFixedRectangle = 'lfrc',
    kCMLongPoint = 'lpnt',
    kCMLongRectangle = 'lrct',
    kCMMachPort = 'port',
    kCMMachine = 'mach',
    kCMMachineLocation = 'mLoc',
    kCMMeters = 'metr',
    kCMMiles = 'mile',
    kCMMiniaturizable = 'ismn',
    kCMMiniaturized = 'pmnd',
    kCMMissingValue = 'msng',
    kCMModal = 'pmod',
    kCMName = 'pnam',
    kCMNull = 'null',
    kCMOunces = 'ozs ',
    kCMParameterInfo = 'pmin',
    kCMPixelMapRecord = 'tpmm',
    kCMPoint = 'QDpt',
    kCMPounds = 'lbs ',
    kCMProcessSerialNumber = 'psn ',
    kCMProperties = 'pALL',
    kCMProperty = 'prop',
    kCMPropertyInfo = 'pinf',
    kCMQuarts = 'qrts',
    kCMRecord = 'reco',
    kCMReference = 'obj ',
    kCMResizable = 'prsz',
    kCMRotation = 'trot',
    kCMScript = 'scpt',
    kCMSelectedSource = 'pSSr',
    kCMSelectedText = 'pSTx',
    kCMShortFloat = 'sing',
    kCMShortInteger = 'shor',
    kCMShortcut = 'psht',
    kCMSource = 'pSrc',
    kCMSquareFeet = 'sqft',
    kCMSquareKilometers = 'sqkm',
    kCMSquareMeters = 'sqrm',
    kCMSquareMiles = 'sqmi',
    kCMSquareYards = 'sqyd',
    kCMString = 'TEXT',
    kCMStyledClipboardText = 'styl',
    kCMStyledText = 'STXT',
    kCMSuiteInfo = 'suin',
    kCMTab = 'BTab',
    kCMText = 'pTxt',
    kCMTextStyleInfo = 'tsty',
    kCMTitle = 'pTtl',
    kCMTitled = 'ptit',
    kCMTopTenCollection = 'ftop',
    kCMTypeClass = 'type',
    kCMUnicodeText = 'utxt',
    kCMUnsignedInteger = 'magn',
    kCMUtf16Text = 'ut16',
    kCMUtf8Text = 'utf8',
    kCMVersion = 'vers',
    kCMVersion_ = 'vers',
    kCMVisible = 'pvis',
    kCMVisitCount = 'pvct',
    kCMWindow = 'cwin',
    kCMWritingCode = 'psct',
    kCMYards = 'yard',
    kCMZoomable = 'iszm',
    kCMZoomed = 'pzum',
};

enum {
    eCMApplications = 'capp',
    eCMBookmarkFolders = 'BMFl',
    eCMBookmarkItems = 'BMIt',
    eCMBookmarks = 'BMBk',
    eCMBrowserWindows = 'BWin',
    eCMItems = 'cobj',
    eCMTabs = 'BTab',
    eCMText = 'pTxt',
    eCMWindows = 'cwin',
    pCMURL = 'pURL',
    pCMAddressBookCollection = 'fadb',
    pCMBonjourCollection = 'fbjr',
    pCMBookmarkBarCollection = 'fbar',
    pCMBookmarkMenuCollection = 'fmnu',
    pCMBounds = 'pbnd',
    pCMClass_ = 'pcls',
    pCMCloseable = 'hclb',
    pCMCurrentTab = 'pCTb',
    pCMDescription_ = 'pdes',
    pCMFloating = 'isfl',
    pCMFrontmost = 'pisf',
    pCMId_ = 'ID  ',
    pCMIndex = 'pidx',
    pCMLastVisitDate = 'pvst',
    pCMMiniaturizable = 'ismn',
    pCMMiniaturized = 'pmnd',
    pCMModal = 'pmod',
    pCMName = 'pnam',
    pCMProperties = 'pALL',
    pCMResizable = 'prsz',
    pCMSelectedSource = 'pSSr',
    pCMSelectedText = 'pSTx',
    pCMShortcut = 'psht',
    pCMSource = 'pSrc',
    pCMTitle = 'pTtl',
    pCMTitled = 'ptit',
    pCMTopTenCollection = 'ftop',
    pCMVersion_ = 'vers',
    pCMVisible = 'pvis',
    pCMVisitCount = 'pvct',
    pCMZoomable = 'iszm',
    pCMZoomed = 'pzum',
};


/* Events */

enum {
    ecCMDeprecatedOpenURL = 'WWW!',
    eiCMDeprecatedOpenURL = 'OURL',
};

enum {
    ecCMActivate = 'misc',
    eiCMActivate = 'actv',
};

enum {
    ecCMClose = 'core',
    eiCMClose = 'clos',
};

enum {
    ecCMCount = 'core',
    eiCMCount = 'cnte',
    epCMEach = 'kocl',
};

enum {
    ecCMDelete = 'core',
    eiCMDelete = 'delo',
};

enum {
    ecCMDuplicate = 'core',
    eiCMDuplicate = 'clon',
    epCMTo = 'insh',
    epCMWithProperties = 'prdt',
};

enum {
    ecCMExists = 'core',
    eiCMExists = 'doex',
};

enum {
    ecCMGet = 'core',
    eiCMGet = 'getd',
};

enum {
    ecCMLaunch = 'ascr',
    eiCMLaunch = 'noop',
};

enum {
    ecCMMake = 'core',
    eiCMMake = 'crel',
    epCMAt = 'insh',
    epCMNew_ = 'kocl',
    epCMWithData = 'data',
//  epCMWithProperties = 'prdt',
};

enum {
    ecCMMove = 'core',
    eiCMMove = 'move',
//  epCMTo = 'insh',
};

enum {
    ecCMOpen = 'aevt',
    eiCMOpen = 'odoc',
};

enum {
    ecCMOpenLocation = 'GURL',
    eiCMOpenLocation = 'GURL',
};

enum {
    ecCMPrint = 'aevt',
    eiCMPrint = 'pdoc',
};

enum {
    ecCMQuit = 'aevt',
    eiCMQuit = 'quit',
};

enum {
    ecCMReopen = 'aevt',
    eiCMReopen = 'rapp',
};

enum {
    ecCMRun = 'aevt',
    eiCMRun = 'oapp',
};

enum {
    ecCMSave = 'core',
    eiCMSave = 'save',
    epCMAs = 'fltp',
    epCMIn = 'kfil',
};

enum {
    ecCMSet = 'core',
    eiCMSet = 'setd',
//  epCMTo = 'data',
};

