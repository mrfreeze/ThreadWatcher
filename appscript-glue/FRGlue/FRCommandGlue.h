/*
 * FRCommandGlue.h
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "FRReferenceRendererGlue.h"

@interface FRCommand : ASCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData;
@end


@interface FRActivateCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRCloseCommand : FRCommand
- (FRCloseCommand *)saving:(id)value;
- (FRCloseCommand *)savingIn:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRCountCommand : FRCommand
- (FRCountCommand *)each:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRDeleteCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRDuplicateCommand : FRCommand
- (FRDuplicateCommand *)to:(id)value;
- (FRDuplicateCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRExistsCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRGetCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRLaunchCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRMakeCommand : FRCommand
- (FRMakeCommand *)at:(id)value;
- (FRMakeCommand *)new_:(id)value;
- (FRMakeCommand *)withData:(id)value;
- (FRMakeCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRMoveCommand : FRCommand
- (FRMoveCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FROpenCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FROpenLocationCommand : FRCommand
- (FROpenLocationCommand *)window:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRPrintCommand : FRCommand
- (FRPrintCommand *)printDialog:(id)value;
- (FRPrintCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRQuitCommand : FRCommand
- (FRQuitCommand *)saving:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRReopenCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRRunCommand : FRCommand
- (NSString *)AS_commandName;
@end


@interface FRSaveCommand : FRCommand
- (FRSaveCommand *)as:(id)value;
- (FRSaveCommand *)in:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface FRSetCommand : FRCommand
- (FRSetCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end

