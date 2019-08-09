//
//  MJKDataSegmentMethodExecutor.h
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJKExecutableProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJKMethodExecutor : NSObject<MJKExecutableProtocol>

- (instancetype)initWithCString:(const char *)cString NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - MJKDataSegementExecutableProtocol

- (void)execute;

@end

NS_ASSUME_NONNULL_END
