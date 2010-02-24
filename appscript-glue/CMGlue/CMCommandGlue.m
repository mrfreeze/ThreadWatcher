/*
 * CMCommandGlue.m
 * /Applications/Camino.app
 * osaglue 0.5.1
 *
 */

#import "CMCommandGlue.h"

@implementation CMCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData {
    return [CMReferenceRenderer formatObject: obj appData: appData];
}

@end


@implementation CMDeprecatedOpenURLCommand
- (NSString *)AS_commandName {
    return @"DeprecatedOpenURL";
}

@end


@implementation CMActivateCommand
- (NSString *)AS_commandName {
    return @"activate";
}

@end


@implementation CMCloseCommand
- (NSString *)AS_commandName {
    return @"close";
}

@end


@implementation CMCountCommand
- (CMCountCommand *)each:(id)value {
    [AS_event setParameter: value forKeyword: 'kocl'];
    return self;

}

- (NSString *)AS_commandName {
    return @"count";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'kocl':
            return @"each";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation CMDeleteCommand
- (NSString *)AS_commandName {
    return @"delete";
}

@end


@implementation CMDuplicateCommand
- (CMDuplicateCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (CMDuplicateCommand *)withProperties:(id)value {
    [AS_event setParameter: value forKeyword: 'prdt'];
    return self;

}

- (NSString *)AS_commandName {
    return @"duplicate";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'insh':
            return @"to";
        case 'prdt':
            return @"withProperties";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation CMExistsCommand
- (NSString *)AS_commandName {
    return @"exists";
}

@end


@implementation CMGetCommand
- (NSString *)AS_commandName {
    return @"get";
}

@end


@implementation CMLaunchCommand
- (NSString *)AS_commandName {
    return @"launch";
}

@end


@implementation CMMakeCommand
- (CMMakeCommand *)at:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (CMMakeCommand *)new_:(id)value {
    [AS_event setParameter: value forKeyword: 'kocl'];
    return self;

}

- (CMMakeCommand *)withData:(id)value {
    [AS_event setParameter: value forKeyword: 'data'];
    return self;

}

- (CMMakeCommand *)withProperties:(id)value {
    [AS_event setParameter: value forKeyword: 'prdt'];
    return self;

}

- (NSString *)AS_commandName {
    return @"make";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'insh':
            return @"at";
        case 'kocl':
            return @"new_";
        case 'data':
            return @"withData";
        case 'prdt':
            return @"withProperties";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation CMMoveCommand
- (CMMoveCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (NSString *)AS_commandName {
    return @"move";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'insh':
            return @"to";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation CMOpenCommand
- (NSString *)AS_commandName {
    return @"open";
}

@end


@implementation CMOpenLocationCommand
- (NSString *)AS_commandName {
    return @"openLocation";
}

@end


@implementation CMPrintCommand
- (NSString *)AS_commandName {
    return @"print";
}

@end


@implementation CMQuitCommand
- (NSString *)AS_commandName {
    return @"quit";
}

@end


@implementation CMReopenCommand
- (NSString *)AS_commandName {
    return @"reopen";
}

@end


@implementation CMRunCommand
- (NSString *)AS_commandName {
    return @"run";
}

@end


@implementation CMSaveCommand
- (CMSaveCommand *)as:(id)value {
    [AS_event setParameter: value forKeyword: 'fltp'];
    return self;

}

- (CMSaveCommand *)in:(id)value {
    [AS_event setParameter: value forKeyword: 'kfil'];
    return self;

}

- (NSString *)AS_commandName {
    return @"save";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'fltp':
            return @"as";
        case 'kfil':
            return @"in";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation CMSetCommand
- (CMSetCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'data'];
    return self;

}

- (NSString *)AS_commandName {
    return @"set";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'data':
            return @"to";
    }
    return [super AS_parameterNameForCode: code];
}

@end

