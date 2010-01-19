/*
 * WKCommandGlue.h
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "WKReferenceRendererGlue.h"

@interface WKCommand : ASCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData;
@end


@interface WKActivateCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKCloseCommand : WKCommand
- (WKCloseCommand *)saving:(id)value;
- (WKCloseCommand *)savingIn:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKCountCommand : WKCommand
- (WKCountCommand *)each:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKDeleteCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKDoJavaScriptCommand : WKCommand
- (WKDoJavaScriptCommand *)in:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKDuplicateCommand : WKCommand
- (WKDuplicateCommand *)to:(id)value;
- (WKDuplicateCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKEmailContentsCommand : WKCommand
- (WKEmailContentsCommand *)of:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKExistsCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKGetCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKLaunchCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKMakeCommand : WKCommand
- (WKMakeCommand *)at:(id)value;
- (WKMakeCommand *)new_:(id)value;
- (WKMakeCommand *)withData:(id)value;
- (WKMakeCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKMoveCommand : WKCommand
- (WKMoveCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKOpenCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKOpenLocationCommand : WKCommand
- (WKOpenLocationCommand *)window:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKPrintCommand : WKCommand
- (WKPrintCommand *)printDialog:(id)value;
- (WKPrintCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKQuitCommand : WKCommand
- (WKQuitCommand *)saving:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKReopenCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKRunCommand : WKCommand
- (NSString *)AS_commandName;
@end


@interface WKSaveCommand : WKCommand
- (WKSaveCommand *)as:(id)value;
- (WKSaveCommand *)in:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKSetCommand : WKCommand
- (WKSetCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface WKShowBookmarksCommand : WKCommand
- (NSString *)AS_commandName;
@end

