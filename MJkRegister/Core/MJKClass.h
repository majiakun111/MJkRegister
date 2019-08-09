//
//  MJKDataSegmentClassExecutor.h
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJKClass : NSObject

@property (nonatomic, weak, readonly) Class targetClass;

- (instancetype)initWithCString:(const char *)cString NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
