//
//  MJKDataSegmentMethodExecutor.m
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "MJKMethodExecutor.h"
#import <objc/runtime.h>

@interface MJKMethodExecutor ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation MJKMethodExecutor

- (instancetype)initWithCString:(const char *)cString {
    NSParameterAssert(cString);
    if (self = [super init]) {
        NSString *imp = [NSString stringWithUTF8String:cString]; //+[Test test]
        NSAssert(![imp hasPrefix:@"-"], @"DataSegmentRegister do not support instance method now.");

        imp = [imp stringByReplacingOccurrencesOfString:@"+" withString:@""];
        imp = [imp stringByReplacingOccurrencesOfString:@"[" withString:@""];
        imp = [imp stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSArray<NSString *> *arrary = [imp componentsSeparatedByString:@" "];
        NSString *className = [arrary firstObject];
        NSString *selectorName = [arrary lastObject];

        _target = NSClassFromString(className);
        
        NSAssert(![selectorName containsString:@":"], @"DataSegmentRegister do not support method with parameter now.");
        _selector = NSSelectorFromString(selectorName);
    }
    
    return self;
}

#pragma mark - MJKDataSegementExecutableProtocol

- (void)execute {    
    NSMethodSignature *methodSignature = [self.target methodSignatureForSelector:self.selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = self.target;
    invocation.selector = self.selector;
    [invocation invoke];
}

@end
