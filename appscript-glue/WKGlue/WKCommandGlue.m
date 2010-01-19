/*
 * WKCommandGlue.m
 * /Applications/WebKit.app
 * osaglue 0.5.1
 *
 */

#import "WKCommandGlue.h"

@implementation WKCommand
- (NSString *)AS_formatObject:(id)obj appData:(id)appData {
    return [WKReferenceRenderer formatObject: obj appData: appData];
}

@end


@implementation WKActivateCommand
- (NSString *)AS_commandName {
    return @"activate";
}

@end


@implementation WKCloseCommand
- (WKCloseCommand *)saving:(id)value {
    [AS_event setParameter: value forKeyword: 'savo'];
    return self;

}

- (WKCloseCommand *)savingIn:(id)value {
    [AS_event setParameter: value forKeyword: 'kfil'];
    return self;

}

- (NSString *)AS_commandName {
    return @"close";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'savo':
            return @"saving";
        case 'kfil':
            return @"savingIn";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation WKCountCommand
- (WKCountCommand *)each:(id)value {
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


@implementation WKDeleteCommand
- (NSString *)AS_commandName {
    return @"delete";
}

@end


@implementation WKDoJavaScriptCommand
- (WKDoJavaScriptCommand *)in:(id)value {
    [AS_event setParameter: value forKeyword: 'dcnm'];
    return self;

}

- (NSString *)AS_commandName {
    return @"doJavaScript";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'dcnm':
            return @"in";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation WKDuplicateCommand
- (WKDuplicateCommand *)to:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (WKDuplicateCommand *)withProperties:(id)value {
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


@implementation WKEmailContentsCommand
- (WKEmailContentsCommand *)of:(id)value {
    [AS_event setParameter: value forKeyword: 'dcnm'];
    return self;

}

- (NSString *)AS_commandName {
    return @"emailContents";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'dcnm':
            return @"of";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation WKExistsCommand
- (NSString *)AS_commandName {
    return @"exists";
}

@end


@implementation WKGetCommand
- (NSString *)AS_commandName {
    return @"get";
}

@end


@implementation WKLaunchCommand
- (NSString *)AS_commandName {
    return @"launch";
}

@end


@implementation WKMakeCommand
- (WKMakeCommand *)at:(id)value {
    [AS_event setParameter: value forKeyword: 'insh'];
    return self;

}

- (WKMakeCommand *)new_:(id)value {
    [AS_event setParameter: value forKeyword: 'kocl'];
    return self;

}

- (WKMakeCommand *)withData:(id)value {
    [AS_event setParameter: value forKeyword: 'data'];
    return self;

}

- (WKMakeCommand *)withProperties:(id)value {
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


@implementation WKMoveCommand
- (WKMoveCommand *)to:(id)value {
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


@implementation WKOpenCommand
- (NSString *)AS_commandName {
    return @"open";
}

@end


@implementation WKOpenLocationCommand
- (WKOpenLocationCommand *)window:(id)value {
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


@implementation WKPrintCommand
- (WKPrintCommand *)printDialog:(id)value {
    [AS_event setParameter: value forKeyword: 'pdlg'];
    return self;

}

- (WKPrintCommand *)withProperties:(id)value {
    [AS_event setParameter: value forKeyword: 'prdt'];
    return self;

}

- (NSString *)AS_commandName {
    return @"print";
}

- (NSString *)AS_parameterNameForCode:(DescType)code {
    switch (code) {
        case 'pdlg':
            return @"printDialog";
        case 'prdt':
            return @"withProperties";
    }
    return [super AS_parameterNameForCode: code];
}

@end


@implementation WKQuitCommand
- (WKQuitCommand *)saving:(id)value {
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


@implementation WKReopenCommand
- (NSString *)AS_commandName {
    return @"reopen";
}

@end


@implementation WKRunCommand
- (NSString *)AS_commandName {
    return @"run";
}

@end


@implementation WKSaveCommand
- (WKSaveCommand *)as:(id)value {
    [AS_event setParameter: value forKeyword: 'fltp'];
    return self;

}

- (WKSaveCommand *)in:(id)value {
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


@implementation WKSetCommand
- (WKSetCommand *)to:(id)value {
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


@implementation WKShowBookmarksCommand
- (NSString *)AS_commandName {
    return @"showBookmarks";
}

@end

