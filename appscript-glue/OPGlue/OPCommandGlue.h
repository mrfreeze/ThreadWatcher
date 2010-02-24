/*
 * OPCommandGlue.h
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "OPReferenceRendererGlue.h"

@interface OPCommand : ASCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData;
@end


@interface OPCloseAllWindowsCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPCloseWindowCommand : OPCommand
- (OPCloseWindowCommand *)ID_:(id)value;
- (OPCloseWindowCommand *)Title:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPGetSourceCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPGetURLCommand : OPCommand
- (OPGetURLCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPGetWindowInfoCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPListWindowsCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPOpenURLCommand : OPCommand
- (OPOpenURLCommand *)Flags:(id)value;
- (OPOpenURLCommand *)FormData:(id)value;
- (OPOpenURLCommand *)MIMEType:(id)value;
- (OPOpenURLCommand *)ProgressApp:(id)value;
- (OPOpenURLCommand *)ResultApp:(id)value;
- (OPOpenURLCommand *)to:(id)value;
- (OPOpenURLCommand *)toWindow:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPRegisterURLEchoCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPShowFileCommand : OPCommand
- (OPShowFileCommand *)MIMEType:(id)value;
- (OPShowFileCommand *)ResultApp:(id)value;
- (OPShowFileCommand *)URL:(id)value;
- (OPShowFileCommand *)WindowID:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPUnRegisterURLEchoCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPActivateCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPCloseCommand : OPCommand
- (OPCloseCommand *)in:(id)value;
- (OPCloseCommand *)saving:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPCountCommand : OPCommand
- (OPCountCommand *)each:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPDataSizeCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPExistsCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPGetCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPLaunchCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPMakeCommand : OPCommand
- (OPMakeCommand *)at:(id)value;
- (OPMakeCommand *)new_:(id)value;
- (OPMakeCommand *)withData:(id)value;
- (OPMakeCommand *)withProperties:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPOpenCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPOpenLocationCommand : OPCommand
- (OPOpenLocationCommand *)window:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPPrintCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPQuitCommand : OPCommand
- (OPQuitCommand *)saving:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPReopenCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPRunCommand : OPCommand
- (NSString *)AS_commandName;
@end


@interface OPSaveCommand : OPCommand
- (OPSaveCommand *)as:(id)value;
- (OPSaveCommand *)in:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end


@interface OPSetCommand : OPCommand
- (OPSetCommand *)to:(id)value;
- (NSString *)AS_commandName;
- (NSString *)AS_parameterNameForCode:(DescType)code;
@end

