//
//  MJKRegister.m
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "MJKRegister.h"
#import "MJKMacros.h"
#import "MJKClass.h"
#import "MJKExecutableProtocol.h"
#import "MJKMethodExecutor.h"
#import "MJKFunctionExecutor.h"
#import "MJKImageReader.h"

@interface MJKRegister ()

@property(nonatomic, strong) NSMutableDictionary *map;

@end

@implementation MJKRegister

+ (instancetype)sharedInstance {
    static MJKRegister *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MJKRegister alloc] init];
    });
    
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _map = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - PublicMethod

- (NSString *)stringForKey:(NSString *)key {
    NSString *str = [self objectForKey:key];
    NSAssert(!str || [str isKindOfClass:[NSString class]], @"Key %@ is use for String value only.", key);
    return str;
}

- (NSArray<NSString *> *)stringArrayForKey:(NSString *)key {
    NSArray<NSString *> *stringArray = [self arrayForKey:key];
    return stringArray;
}

- (Class)classForKey:(NSString *)key {
    MJKClass *cls = [self objectForKey:key];
    NSAssert(!cls || [cls isKindOfClass:[MJKClass class]], @"Key %@ is use for MJKClass value only.", key);
    return cls.targetClass;
}

- (NSArray<Class> *)classArrayForKey:(NSString *)key {
    NSArray *classArray = [self arrayForKey:key];
    NSMutableArray *targetClasses = [NSMutableArray array];
    for (MJKClass *cls in classArray) {
        NSAssert([cls isKindOfClass:[MJKClass class]], @"Key %@ is use for MJKClass value only.", key);
        [targetClasses addObject:cls.targetClass];
    }
    
    return targetClasses;
}

- (void)executeForKey:(NSString *)key {
    id<MJKExecutableProtocol> executable = [self objectForKey:key];
    NSAssert(!executable || [executable conformsToProtocol:@protocol(MJKExecutableProtocol)], @"Key %@ is use for id<MJKExecutableProtocol> value only.", key);
    [executable execute];
}

- (void)executeArrayForKey:(NSString *)key {
    for (id<MJKExecutableProtocol> executable in [self arrayForKey:key]) {
        NSAssert([executable conformsToProtocol:@protocol(MJKExecutableProtocol)], @"Key %@ is use for id<MJKExecutableProtocol> value only.", key);
        [executable execute];
    }
}

#pragma mark - PrivateMethod

- (id)objectForKey:(NSString *)key {
    NSParameterAssert(key);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lazyInitilizeAll];
    });
    
    return self.map[key];
}

- (NSArray *)arrayForKey:(NSString *)key {
    NSArray *array = [self objectForKey:key];
    NSAssert(!array || [array isKindOfClass:[NSArray class]], @"Key %@ is use for Array value only.", key);
    return array;
}

- (void)lazyInitilizeAll {
    [MJKImageReader readSectionWithName:MJK_SECTION_NAME fromAllImageWithStep:sizeof(MJKRegisterData) usingBlock:^(const void **addr) {
        MJKRegisterData data = *(MJKRegisterData *)addr;
        NSString *key = [NSString stringWithUTF8String:data.header.key];
        id value = [self parseValue:data.value type:data.header.type];
        if (data.header.isArray) {
            if (!self.map[key]) {
                self.map[key] = [[NSMutableArray alloc] init];
            }
            NSAssert([self.map[key] isKindOfClass:[NSMutableArray class]], @"Redefine key: %@, type: %lu, value: %@", key, (unsigned long)data.header.type, value);
            [self.map[key] addObject:value];
        } else {
            NSAssert(!self.map[key], @"Redefine key: %@, type: %lu, value: %@", key, (unsigned long)data.header.type, value);
            self.map[key] = value;
        }
    }];
}

- (id)parseValue:(const void *)value type:(MJKRegisterType)type {
    switch (type) {
        case MJKRegisterTypeString:     {
            return [NSString stringWithUTF8String:value];
        }
        case MJKRegisterTypeMethod: {
            return [[MJKMethodExecutor alloc] initWithCString:value];
        }
        case MJKRegisterTypeFunction: {
            return [[MJKFunctionExecutor alloc] initWithCPointer:value];
        }
        case MJKRegisterTypeClass: {
            return [[MJKClass alloc] initWithCString:value];
        }
        default:
            break;
    }
 
    return nil;
}


@end
