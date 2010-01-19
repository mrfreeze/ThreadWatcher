/*
 * FRAEMConstants.h
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"

/* Types, enumerators, properties */

enum {
    kFRApplicationResponses = 'rmte',
    kFRAsk = 'ask ',
    kFRCase_ = 'case',
    kFRDetailed = 'lwdt',
    kFRDiacriticals = 'diac',
    kFRExpansion = 'expa',
    kFRHyphens = 'hyph',
    kFRNo = 'no  ',
    kFRNumericStrings = 'nume',
    kFRPunctuation = 'punc',
    kFRStandard = 'lwst',
    kFRWhitespace = 'whit',
    kFRYes = 'yes ',
    kFRApril = 'apr ',
    kFRAugust = 'aug ',
    kFRDecember = 'dec ',
    kFREPSPicture = 'EPS ',
    kFRFebruary = 'feb ',
    kFRFriday = 'fri ',
    kFRGIFPicture = 'GIFf',
    kFRJPEGPicture = 'JPEG',
    kFRJanuary = 'jan ',
    kFRJuly = 'jul ',
    kFRJune = 'jun ',
    kFRMarch = 'mar ',
    kFRMay = 'may ',
    kFRMonday = 'mon ',
    kFRNovember = 'nov ',
    kFROctober = 'oct ',
    kFRPICTPicture = 'PICT',
    kFRRGB16Color = 'tr16',
    kFRRGB96Color = 'tr96',
    kFRRGBColor = 'cRGB',
    kFRSaturday = 'sat ',
    kFRSeptember = 'sep ',
    kFRSunday = 'sun ',
    kFRTIFFPicture = 'TIFF',
    kFRThursday = 'thu ',
    kFRTuesday = 'tue ',
    kFRWednesday = 'wed ',
    kFRAlias = 'alis',
    kFRAnything = '****',
    kFRApplication = 'capp',
    kFRApplicationBundleID = 'bund',
    kFRApplicationSignature = 'sign',
    kFRApplicationURL = 'aprl',
    kFRAttachment = 'atts',
    kFRAttributeRun = 'catr',
    kFRBest = 'best',
    kFRBoolean = 'bool',
    kFRBoundingRectangle = 'qdrt',
    kFRBounds = 'pbnd',
    kFRCentimeters = 'cmtr',
    kFRCharacter = 'cha ',
    kFRClassInfo = 'gcli',
    kFRClass_ = 'pcls',
    kFRCloseable = 'hclb',
    kFRCollating = 'lwcl',
    kFRColor = 'colr',
    kFRColorTable = 'clrt',
    kFRCopies = 'lwcp',
    kFRCubicCentimeters = 'ccmt',
    kFRCubicFeet = 'cfet',
    kFRCubicInches = 'cuin',
    kFRCubicMeters = 'cmet',
    kFRCubicYards = 'cyrd',
    kFRDashStyle = 'tdas',
    kFRData = 'rdat',
    kFRDate = 'ldt ',
    kFRDecimalStruct = 'decm',
    kFRDegreesCelsius = 'degc',
    kFRDegreesFahrenheit = 'degf',
    kFRDegreesKelvin = 'degk',
    kFRDocument = 'docu',
    kFRDoubleInteger = 'comp',
    kFRElementInfo = 'elin',
    kFREncodedString = 'encs',
    kFREndingPage = 'lwlp',
    kFREnumerator = 'enum',
    kFRErrorHandling = 'lweh',
    kFREventInfo = 'evin',
    kFRExtendedFloat = 'exte',
    kFRFaxNumber = 'faxn',
    kFRFeet = 'feet',
    kFRFileName = 'atfn',
    kFRFileRef = 'fsrf',
    kFRFileSpecification = 'fss ',
    kFRFileURL = 'furl',
    kFRFixed = 'fixd',
    kFRFixedPoint = 'fpnt',
    kFRFixedRectangle = 'frct',
    kFRFloat128bit = 'ldbl',
    kFRFloat_ = 'doub',
    kFRFloating = 'isfl',
    kFRFont = 'font',
    kFRFrontmost = 'pisf',
    kFRGallons = 'galn',
    kFRGrams = 'gram',
    kFRGraphicText = 'cgtx',
    kFRId_ = 'ID  ',
    kFRInches = 'inch',
    kFRIndex = 'pidx',
    kFRInteger = 'long',
    kFRInternationalText = 'itxt',
    kFRInternationalWritingCode = 'intl',
    kFRItem = 'cobj',
    kFRKernelProcessID = 'kpid',
    kFRKilograms = 'kgrm',
    kFRKilometers = 'kmtr',
    kFRList = 'list',
    kFRLiters = 'litr',
    kFRLocationReference = 'insl',
    kFRLongFixed = 'lfxd',
    kFRLongFixedPoint = 'lfpt',
    kFRLongFixedRectangle = 'lfrc',
    kFRLongPoint = 'lpnt',
    kFRLongRectangle = 'lrct',
    kFRMachPort = 'port',
    kFRMachine = 'mach',
    kFRMachineLocation = 'mLoc',
    kFRMeters = 'metr',
    kFRMiles = 'mile',
    kFRMiniaturizable = 'ismn',
    kFRMiniaturized = 'pmnd',
    kFRMissingValue = 'msng',
    kFRModal = 'pmod',
    kFRModified = 'imod',
    kFRName = 'pnam',
    kFRNull = 'null',
    kFROunces = 'ozs ',
    kFRPagesAcross = 'lwla',
    kFRPagesDown = 'lwld',
    kFRParagraph = 'cpar',
    kFRParameterInfo = 'pmin',
    kFRPath = 'ppth',
    kFRPixelMapRecord = 'tpmm',
    kFRPoint = 'QDpt',
    kFRPounds = 'lbs ',
    kFRPrintSettings = 'pset',
    kFRProcessSerialNumber = 'psn ',
    kFRProperties = 'pALL',
    kFRProperty = 'prop',
    kFRPropertyInfo = 'pinf',
    kFRQuarts = 'qrts',
    kFRRecord = 'reco',
    kFRReference = 'obj ',
    kFRRequestedPrintTime = 'lwqt',
    kFRResizable = 'prsz',
    kFRRotation = 'trot',
    kFRScript = 'scpt',
    kFRShortFloat = 'sing',
    kFRShortInteger = 'shor',
    kFRSize = 'ptsz',
    kFRSquareFeet = 'sqft',
    kFRSquareKilometers = 'sqkm',
    kFRSquareMeters = 'sqrm',
    kFRSquareMiles = 'sqmi',
    kFRSquareYards = 'sqyd',
    kFRStartingPage = 'lwfp',
    kFRString = 'TEXT',
    kFRStyledClipboardText = 'styl',
    kFRStyledText = 'STXT',
    kFRSuiteInfo = 'suin',
    kFRTargetPrinter = 'trpr',
    kFRText = 'ctxt',
    kFRTextStyleInfo = 'tsty',
    kFRTitled = 'ptit',
    kFRTypeClass = 'type',
    kFRUnicodeText = 'utxt',
    kFRUnsignedInteger = 'magn',
    kFRUtf16Text = 'ut16',
    kFRUtf8Text = 'utf8',
    kFRVersion = 'vers',
    kFRVersion_ = 'vers',
    kFRVisible = 'pvis',
    kFRWindow = 'cwin',
    kFRWord = 'cwor',
    kFRWritingCode = 'psct',
    kFRYards = 'yard',
    kFRZoomable = 'iszm',
    kFRZoomed = 'pzum',
};

enum {
    eFRApplications = 'capp',
    eFRAttachment = 'atts',
    eFRAttributeRuns = 'catr',
    eFRCharacters = 'cha ',
    eFRColors = 'colr',
    eFRDocuments = 'docu',
    eFRItems = 'cobj',
    eFRParagraphs = 'cpar',
    eFRPrintSettings = 'pset',
    eFRText = 'ctxt',
    eFRWindows = 'cwin',
    eFRWords = 'cwor',
    pFRBounds = 'pbnd',
    pFRClass_ = 'pcls',
    pFRCloseable = 'hclb',
    pFRCollating = 'lwcl',
    pFRColor = 'colr',
    pFRCopies = 'lwcp',
    pFRDocument = 'docu',
    pFREndingPage = 'lwlp',
    pFRErrorHandling = 'lweh',
    pFRFaxNumber = 'faxn',
    pFRFileName = 'atfn',
    pFRFloating = 'isfl',
    pFRFont = 'font',
    pFRFrontmost = 'pisf',
    pFRId_ = 'ID  ',
    pFRIndex = 'pidx',
    pFRMiniaturizable = 'ismn',
    pFRMiniaturized = 'pmnd',
    pFRModal = 'pmod',
    pFRModified = 'imod',
    pFRName = 'pnam',
    pFRPagesAcross = 'lwla',
    pFRPagesDown = 'lwld',
    pFRPath = 'ppth',
    pFRProperties = 'pALL',
    pFRRequestedPrintTime = 'lwqt',
    pFRResizable = 'prsz',
    pFRSize = 'ptsz',
    pFRStartingPage = 'lwfp',
    pFRTargetPrinter = 'trpr',
    pFRTitled = 'ptit',
    pFRVersion_ = 'vers',
    pFRVisible = 'pvis',
    pFRZoomable = 'iszm',
    pFRZoomed = 'pzum',
};


/* Events */

enum {
    ecFRActivate = 'misc',
    eiFRActivate = 'actv',
};

enum {
    ecFRClose = 'core',
    eiFRClose = 'clos',
    epFRSaving = 'savo',
    epFRSavingIn = 'kfil',
};

enum {
    ecFRCount = 'core',
    eiFRCount = 'cnte',
    epFREach = 'kocl',
};

enum {
    ecFRDelete = 'core',
    eiFRDelete = 'delo',
};

enum {
    ecFRDuplicate = 'core',
    eiFRDuplicate = 'clon',
    epFRTo = 'insh',
    epFRWithProperties = 'prdt',
};

enum {
    ecFRExists = 'core',
    eiFRExists = 'doex',
};

enum {
    ecFRGet = 'core',
    eiFRGet = 'getd',
};

enum {
    ecFRLaunch = 'ascr',
    eiFRLaunch = 'noop',
};

enum {
    ecFRMake = 'core',
    eiFRMake = 'crel',
    epFRAt = 'insh',
    epFRNew_ = 'kocl',
    epFRWithData = 'data',
//  epFRWithProperties = 'prdt',
};

enum {
    ecFRMove = 'core',
    eiFRMove = 'move',
//  epFRTo = 'insh',
};

enum {
    ecFROpen = 'aevt',
    eiFROpen = 'odoc',
};

enum {
    ecFROpenLocation = 'GURL',
    eiFROpenLocation = 'GURL',
    epFRWindow = 'WIND',
};

enum {
    ecFRPrint = 'aevt',
    eiFRPrint = 'pdoc',
    epFRPrintDialog = 'pdlg',
//  epFRWithProperties = 'prdt',
};

enum {
    ecFRQuit = 'aevt',
    eiFRQuit = 'quit',
//  epFRSaving = 'savo',
};

enum {
    ecFRReopen = 'aevt',
    eiFRReopen = 'rapp',
};

enum {
    ecFRRun = 'aevt',
    eiFRRun = 'oapp',
};

enum {
    ecFRSave = 'core',
    eiFRSave = 'save',
    epFRAs = 'fltp',
    epFRIn = 'kfil',
};

enum {
    ecFRSet = 'core',
    eiFRSet = 'setd',
//  epFRTo = 'data',
};

