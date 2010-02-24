/*
 * OPConstantGlue.h
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"

@interface OPConstant : ASConstant
+ (id)constantWithCode:(OSType)code_;

/* Enumerators */

+ (OPConstant *)applicationResponses;
+ (OPConstant *)ask;
+ (OPConstant *)case_;
+ (OPConstant *)diacriticals;
+ (OPConstant *)expansion;
+ (OPConstant *)hyphens;
+ (OPConstant *)no;
+ (OPConstant *)numericStrings;
+ (OPConstant *)punctuation;
+ (OPConstant *)whitespace;
+ (OPConstant *)yes;

/* Types and properties */

+ (OPConstant *)April;
+ (OPConstant *)August;
+ (OPConstant *)December;
+ (OPConstant *)EPSPicture;
+ (OPConstant *)February;
+ (OPConstant *)Friday;
+ (OPConstant *)GIFPicture;
+ (OPConstant *)JPEGPicture;
+ (OPConstant *)January;
+ (OPConstant *)July;
+ (OPConstant *)June;
+ (OPConstant *)March;
+ (OPConstant *)May;
+ (OPConstant *)Monday;
+ (OPConstant *)November;
+ (OPConstant *)October;
+ (OPConstant *)PICTPicture;
+ (OPConstant *)RGB16Color;
+ (OPConstant *)RGB96Color;
+ (OPConstant *)RGBColor;
+ (OPConstant *)Saturday;
+ (OPConstant *)September;
+ (OPConstant *)Sunday;
+ (OPConstant *)TIFFPicture;
+ (OPConstant *)Thursday;
+ (OPConstant *)Tuesday;
+ (OPConstant *)Wednesday;
+ (OPConstant *)alias;
+ (OPConstant *)anything;
+ (OPConstant *)application;
+ (OPConstant *)applicationBundleID;
+ (OPConstant *)applicationSignature;
+ (OPConstant *)applicationURL;
+ (OPConstant *)best;
+ (OPConstant *)boolean;
+ (OPConstant *)boundingRectangle;
+ (OPConstant *)bounds;
+ (OPConstant *)centimeters;
+ (OPConstant *)classInfo;
+ (OPConstant *)class_;
+ (OPConstant *)closeable;
+ (OPConstant *)colorTable;
+ (OPConstant *)cubicCentimeters;
+ (OPConstant *)cubicFeet;
+ (OPConstant *)cubicInches;
+ (OPConstant *)cubicMeters;
+ (OPConstant *)cubicYards;
+ (OPConstant *)dashStyle;
+ (OPConstant *)data;
+ (OPConstant *)date;
+ (OPConstant *)decimalStruct;
+ (OPConstant *)degreesCelsius;
+ (OPConstant *)degreesFahrenheit;
+ (OPConstant *)degreesKelvin;
+ (OPConstant *)document;
+ (OPConstant *)doubleInteger;
+ (OPConstant *)elementInfo;
+ (OPConstant *)encodedString;
+ (OPConstant *)enumerator;
+ (OPConstant *)eventInfo;
+ (OPConstant *)extendedFloat;
+ (OPConstant *)feet;
+ (OPConstant *)fileRef;
+ (OPConstant *)fileSpecification;
+ (OPConstant *)fileURL;
+ (OPConstant *)fixed;
+ (OPConstant *)fixedPoint;
+ (OPConstant *)fixedRectangle;
+ (OPConstant *)float128bit;
+ (OPConstant *)float_;
+ (OPConstant *)floating;
+ (OPConstant *)gallons;
+ (OPConstant *)grams;
+ (OPConstant *)graphicText;
+ (OPConstant *)id_;
+ (OPConstant *)inches;
+ (OPConstant *)index;
+ (OPConstant *)integer;
+ (OPConstant *)internationalText;
+ (OPConstant *)internationalWritingCode;
+ (OPConstant *)item;
+ (OPConstant *)kernelProcessID;
+ (OPConstant *)kilograms;
+ (OPConstant *)kilometers;
+ (OPConstant *)list;
+ (OPConstant *)liters;
+ (OPConstant *)loading;
+ (OPConstant *)locationReference;
+ (OPConstant *)longFixed;
+ (OPConstant *)longFixedPoint;
+ (OPConstant *)longFixedRectangle;
+ (OPConstant *)longPoint;
+ (OPConstant *)longRectangle;
+ (OPConstant *)machPort;
+ (OPConstant *)machine;
+ (OPConstant *)machineLocation;
+ (OPConstant *)meters;
+ (OPConstant *)miles;
+ (OPConstant *)miniaturizable;
+ (OPConstant *)miniaturized;
+ (OPConstant *)missingValue;
+ (OPConstant *)modal;
+ (OPConstant *)modified;
+ (OPConstant *)name;
+ (OPConstant *)null;
+ (OPConstant *)ounces;
+ (OPConstant *)parameterInfo;
+ (OPConstant *)pixelMapRecord;
+ (OPConstant *)point;
+ (OPConstant *)pounds;
+ (OPConstant *)processSerialNumber;
+ (OPConstant *)properties;
+ (OPConstant *)property;
+ (OPConstant *)propertyInfo;
+ (OPConstant *)quarts;
+ (OPConstant *)record;
+ (OPConstant *)reference;
+ (OPConstant *)resizable;
+ (OPConstant *)rotation;
+ (OPConstant *)script;
+ (OPConstant *)shortFloat;
+ (OPConstant *)shortInteger;
+ (OPConstant *)squareFeet;
+ (OPConstant *)squareKilometers;
+ (OPConstant *)squareMeters;
+ (OPConstant *)squareMiles;
+ (OPConstant *)squareYards;
+ (OPConstant *)string;
+ (OPConstant *)styledClipboardText;
+ (OPConstant *)styledText;
+ (OPConstant *)suiteInfo;
+ (OPConstant *)textStyleInfo;
+ (OPConstant *)titled;
+ (OPConstant *)typeClass;
+ (OPConstant *)unicodeText;
+ (OPConstant *)unsignedInteger;
+ (OPConstant *)url;
+ (OPConstant *)utf16Text;
+ (OPConstant *)utf8Text;
+ (OPConstant *)version;
+ (OPConstant *)visible;
+ (OPConstant *)window;
+ (OPConstant *)writingCode;
+ (OPConstant *)yards;
+ (OPConstant *)zoomable;
+ (OPConstant *)zoomed;
@end

