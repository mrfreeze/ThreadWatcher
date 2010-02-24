/*
 * CMCommandGlue.h
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "CMReferenceRendererGlue.h"

@interface CMCommand : ASCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData;
@end


@interface CMDeprecatedOpenURLCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMActivateCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMCloseCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMCountCommand : CMCommand
- (CMCountCommand *)each:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface CMDeleteCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMDuplicateCommand : CMCommand
- (CMDuplicateCommand *)to:(id)value;
- (CMDuplicateCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface CMExistsCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMGetCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMLaunchCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMMakeCommand : CMCommand
- (CMMakeCommand *)at:(id)value;
- (CMMakeCommand *)new_:(id)value;
- (CMMakeCommand *)withData:(id)value;
- (CMMakeCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface CMMoveCommand : CMCommand
- (CMMoveCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface CMOpenCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMOpenLocationCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMPrintCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMQuitCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMReopenCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMRunCommand : CMCommand
- (NSString *)AS_commandName;
@end


@interface CMSaveCommand : CMCommand
- (CMSaveCommand *)as:(id)value;
- (CMSaveCommand *)in:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface CMSetCommand : CMCommand
- (CMSetCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end

