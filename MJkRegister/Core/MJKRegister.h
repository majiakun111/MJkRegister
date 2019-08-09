//
//  MJKDataSegmentRegister.h
//  MJKDataSegmentRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@Public Function array export
#define MJK_FUNCTIONS_EXPORT(KEY)  \
    _MJK_FUNCTIONS_EXPORT(KEY, __COUNTER__)

//@Public Function export
#define MJK_FUNCTION_EXPORT(KEY)    \
    _MJK_FUNCTION_EXPORT(KEY, __COUNTER__)

//@Public Method array export
#define MJK_METHODS_EXPORT(KEY) \
    MJK_ARRAY_DEFINE(KEY, MJKRegisterTypeMethod, __func__)

//@Public Method export
#define MJK_METHOD_EXPORT(KEY)  \
    MJK_DEFINE(KEY, MJKRegisterTypeMethod, __func__)

//@Public String array export
#define MJK_STRINGS_EXPORT(KEY, A_STRING)   \
    MJK_ARRAY_DEFINE(KEY, MJKRegisterTypeString, _MJK_ASSERT_CSTRING(A_STRING))

//@Public String export
#define MJK_STRING_EXPORT(KEY, STRING)  \
    MJK_DEFINE(KEY, MJKRegisterTypeString, _MJK_ASSERT_CSTRING(STRING))

//@Public Class Array Export
#define MJK_CLASSES_EXPORT(KEY, CLASS)                      \
    _MJK_ASSERT_CLASS(CLASS)                                \
    MJK_ARRAY_DEFINE(KEY, MJKRegisterTypeClass, MJK_STRINGIFY(CLASS));

//@Public Class Export
#define MJK_CLASS_EXPORT(KEY, CLASS)                    \
    _MJK_ASSERT_CLASS(CLASS)                            \
    MJK_DEFINE(KEY, MJKRegisterTypeClass, MJK_STRINGIFY(CLASS));


@interface MJKRegister : NSObject

+ (instancetype)sharedInstance;

- (NSString *)stringForKey:(NSString *)key;
- (NSArray<NSString *> *)stringArrayForKey:(NSString *)key;

- (void)executeForKey:(NSString *)key;
- (void)executeArrayForKey:(NSString *)key;

- (Class)classForKey:(NSString *)key;
- (NSArray<Class> *)classArrayForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
