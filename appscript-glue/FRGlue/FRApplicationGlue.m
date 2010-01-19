/*
 * FRApplicationGlue.m
 * /Applications/Firefox.app
 * osaglue 0.5.1
 *
 */

#import "FRApplicationGlue.h"

@implementation FRApplication

/* note: clients shouldn't need to call -initWithTargetType:data: themselves */

- (id)initWithTargetType:(ASTargetType)targetType_ data:(id)targetData_ {
    ASAppData *appData;

    appData = [[ASAppData alloc] initWithApplicationClass: [AEMApplication class]
                                            constantClass: [FRConstant class]
                                           referenceClass: [FRReference class]
                                               targetType: targetType_
                                               targetData: targetData_];
	[appData autorelease];
    self = [super initWithAppData: appData aemReference: AEMApp];

    if (!self) return self;
    return self;
}


/* initialisers */

+ (id)application {
    return [[[self alloc] init] autorelease];
}

+ (id)applicationWithName:(NSString *)name {
    return [[[self alloc] initWithName: name] autorelease];
}

+ (id)applicationWithBundleID:(NSString *)bundleID {
    return [[[self alloc] initWithBundleID: bundleID] autorelease];
}

+ (id)applicationWithURL:(NSURL *)url {
    return [[[self alloc] initWithURL: url] autorelease];
}

+ (id)applicationWithPID:(pid_t)pid {
    return [[[self alloc] initWithPID: pid] autorelease];
}

+ (id)applicationWithDescriptor:(NSAppleEventDescriptor *)desc {
    return [[[self alloc] initWithDescriptor: desc] autorelease];
}

- (id)init {
    return [self initWithTargetType: kASTargetCurrent data: nil];
}

- (id)initWithName:(NSString *)name {
    return [self initWithTargetType: kASTargetName data: name];
}

- (id)initWithBundleID:(NSString *)bundleID {
    return [self initWithTargetType: kASTargetBundleID data: bundleID];
}

- (id)initWithURL:(NSURL *)url {
    return [self initWithTargetType: kASTargetURL data: url];
}

- (id)initWithPID:(pid_t)pid {
    return [self initWithTargetType: kASTargetPID data: [NSNumber numberWithInteger: pid]];
}

- (id)initWithDescriptor:(NSAppleEventDescriptor *)desc {
    return [self initWithTargetType: kASTargetDescriptor data: desc];
}


/* misc */

- (FRReference *)AS_referenceWithObject:(id)object {
    if ([object isKindOfClass: [FRReference class]])
        return [[[FRReference alloc] initWithAppData: AS_appData
                aemReference: [object AS_aemReference]] autorelease];
    else if ([object isKindOfClass: [AEMQuery class]])
        return [[[FRReference alloc] initWithAppData: AS_appData
                aemReference: object] autorelease];
    else if (!object)
        return [[[FRReference alloc] initWithAppData: AS_appData
                aemReference: AEMApp] autorelease];
    else
        return [[[FRReference alloc] initWithAppData: AS_appData
                aemReference: AEMRoot(object)] autorelease];
}

@end

