//
//  MJKDataSegmentFunctionExecutor.m
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "MJKFunctionExecutor.h"

typedef void (*MJKDataSegmentFunction)(void);


@interface MJKFunctionExecutor () {
    MJKDataSegmentFunction _function;
}

@end

@implementation MJKFunctionExecutor

- (instancetype)initWithCPointer:(const void *)pointer {
    self = [super init];
    if (self) {
        _function = pointer;
    }
    
    return self;
}

#pragma mark - MJKDataSegementExecutableProtocol

- (void)execute {
    NSAssert(_function, @"MJKDataSegmentFunction pointer can not be NULL");
    _function();
}

@end
