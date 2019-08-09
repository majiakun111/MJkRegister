//
//  MJKDataSegmentClassExecutor.m
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "MJKClass.h"
#import <objc/runtime.h>

@interface MJKClass ()

@property (nonatomic, weak) Class targetClass;

@end

@implementation MJKClass

- (instancetype)initWithCString:(const char *)cString {
    if (self = [super init]) {
        self.targetClass = objc_getClass(cString);
        NSAssert(self.targetClass, @"Class %s does not exsit", cString);
    }
    
    return self;
}


@end
