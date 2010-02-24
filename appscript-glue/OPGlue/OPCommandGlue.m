/*
 * OPCommandGlue.m
 * /Applications/Opera.app
 * osaglue 0.5.1
 *
 */

#import "OPCommandGlue.h"

@implementation OPCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData {
    return [OPReferenceRenderer formatObject: obj appData: appData];
}

@end


@implementation OPCloseAllWindowsCommand
- (NSString *)AS_commandName {
    return @"CloseAllWindows";
}

@end


@implementation OPCloseWindowCommand
- (OPCloseWindowCommand *)ID_:(id)value {
    [AS_event setParameter: value forKeyword: 'WIND'];
    return self;

}

- (OPCloseWindowCommand *)Title:(id)value {
    [AS_event setParameter: value forKeyword: 'TITL'];
    return self;

}

- (NSString *)AS_commandName {
    return @"CloseWindow";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'WIND':
            return @"ID_";
        case 'TITL':
            return @"Title";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPGetSourceCommand
- (NSString *)AS_commandName {
    return @"GetSource";
}

@end


@implementation OPGetURLCommand
- (OPGetURLCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'dest'];
    return self;

}

- (NSString *)AS_commandName {
    return @"GetURL";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'dest':
            return @"to";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPGetWindowInfoCommand
- (NSString *)AS_commandName {
    return @"GetWindowInfo";
}

@end


@implementation OPListWindowsCommand
- (NSString *)AS_commandName {
    return @"ListWindows";
}

@end


@implementation OPOpenURLCommand
- (OPOpenURLCommand *)Flags:(id)value {
    [AS_event setParameter: value forKeyword: 'FLGS'];
    return self;

}

- (OPOpenURLCommand *)FormData:(id)value {
    [AS_event setParameter: value forKeyword: 'POST'];
    return self;

}

- (OPOpenURLCommand *)MIMEType:(id)value {
    [AS_event setParameter: value forKeyword: 'MIME'];
    return self;

}

- (OPOpenURLCommand *)ProgressApp:(id)value {
    [AS_event setParameter: value forKeyword: 'PROG'];
    return self;

}

- (OPOpenURLCommand *)ResultApp:(id)value {
    [AS_event setParameter: value forKeyword: 'RSLT'];
    return self;

}

- (OPOpenURLCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'INTO'];
    return self;

}

- (OPOpenURLCommand *)toWindow:(id)value {
    [AS_event setParameter: value forKeyword: 'WIND'];
    return self;

}

- (NSString *)AS_commandName {
    return @"OpenURL";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'FLGS':
            return @"Flags";
        case 'POST':
            return @"FormData";
        case 'MIME':
            return @"MIMEType";
        case 'PROG':
            return @"ProgressApp";
        case 'RSLT':
            return @"ResultApp";
        case 'INTO':
            return @"to";
        case 'WIND':
            return @"toWindow";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPRegisterURLEchoCommand
- (NSString *)AS_commandName {
    return @"RegisterURLEcho";
}

@end


@implementation OPShowFileCommand
- (OPShowFileCommand *)MIMEType:(id)value {
    [AS_event setParameter: value forKeyword: 'MIME'];
    return self;

}

- (OPShowFileCommand *)ResultApp:(id)value {
    [AS_event setParameter: value forKeyword: 'RSLT'];
    return self;

}

- (OPShowFileCommand *)URL:(id)value {
    [AS_event setParameter: value forKeyword: 'URL '];
    return self;

}

- (OPShowFileCommand *)WindowID:(id)value {
    [AS_event setParameter: value forKeyword: 'WIND'];
    return self;

}

- (NSString *)AS_commandName {
    return @"ShowFile";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'MIME':
            return @"MIMEType";
        case 'RSLT':
            return @"ResultApp";
        case 'URL ':
            return @"URL";
        case 'WIND':
            return @"WindowID";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPUnRegisterURLEchoCommand
- (NSString *)AS_commandName {
    return @"UnRegisterURLEcho";
}

@end


@implementation OPActivateCommand
- (NSString *)AS_commandName {
    return @"activate";
}

@end


@implementation OPCloseCommand
- (OPCloseCommand *)in:(id)value {
    [AS_event setParameter: value forKeyword: 'kfil'];
    return self;

}

- (OPCloseCommand *)saving:(id)value {
    [AS_event setParameter: value forKeyword: 'savo'];
    return self;

}

- (NSString *)AS_commandName {
    return @"close";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'kfil':
            return @"in";
        case 'savo':
            return @"saving";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPCountCommand
- (OPCountCommand *)each:(id)value {
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


@implementation OPDataSizeCommand
- (NSString *)AS_commandName {
    return @"dataSize";
}

@end


@implementation OPExistsCommand
- (NSString *)AS_commandName {
    return @"exists";
}

@end


@implementation OPGetCommand
- (NSString *)AS_commandName {
    return @"get";
}

@end


@implementation OPLaunchCommand
- (NSString *)AS_commandName {
    return @"launch";
}

@end


@implementation OPMakeCommand
- (OPMakeCommand *)at:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (OPMakeCommand *)new_:(id)value {
    [AS_event setParameter: value forKeyword: 'kocl'];
    return self;

}

- (OPMakeCommand *)withData:(id)value {
    [AS_event setParameter: value forKeyword: 'data'];
    return self;

}

- (OPMakeCommand *)withProperties:(id)value {
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


@implementation OPOpenCommand
- (NSString *)AS_commandName {
    return @"open";
}

@end


@implementation OPOpenLocationCommand
- (OPOpenLocationCommand *)window:(id)value {
    [AS_event setParameter: value forKeyword: 'WIND'];
    return self;

}

- (NSString *)AS_commandName {
    return @"openLocation";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'WIND':
            return @"window";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPPrintCommand
- (NSString *)AS_commandName {
    return @"print";
}

@end


@implementation OPQuitCommand
- (OPQuitCommand *)saving:(id)value {
    [AS_event setParameter: value forKeyword: 'savo'];
    return self;

}

- (NSString *)AS_commandName {
    return @"quit";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'savo':
            return @"saving";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation OPReopenCommand
- (NSString *)AS_commandName {
    return @"reopen";
}

@end


@implementation OPRunCommand
- (NSString *)AS_commandName {
    return @"run";
}

@end


@implementation OPSaveCommand
- (OPSaveCommand *)as:(id)value {
    [AS_event setParameter: value forKeyword: 'fltp'];
    return self;

}

- (OPSaveCommand *)in:(id)value {
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


@implementation OPSetCommand
- (OPSetCommand *)to:(id)value {
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

