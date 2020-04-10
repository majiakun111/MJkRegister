//
//  MJKMacros.h
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef MJKMacros_h
#define MJKMacros_h

#pragma mark - Basic

#define _MJK_CONCAT(A, B)   A ## B
#define MJK_CONCAT(A, B)    _MJK_CONCAT(A, B)
#define _MJK_STRINGIFY(A)   # A
#define MJK_STRINGIFY(A)    _MJK_STRINGIFY(A)

#pragma mark - Macros define

#define MJK_USED    __attribute__((used))
#define MJK_UNUSED  __attribute__((unused))

#define MJK_SEGMENT_NAME    "__DATA"
#define MJK_SEPARATOR           ","

#define MJK_SECTION_NAME    "__mjk_register__"

#define MJK_SEGMENT_SECTION     MJK_SEGMENT_NAME MJK_SEPARATOR MJK_SECTION_NAME

// @Private Identifier generator
#define MJK_IDENTIFIER(SEED)        MJK_CONCAT(__mjk_register__, SEED)
#define MJK_UNIQUE_IDENTIFIER       MJK_IDENTIFIER(__COUNTER__)

// @Private Data writer with version marker if needed
#define _MJK_DATA_DEFINE(HEADER, VALUE)   \
    __attribute__((used, section(MJK_SEGMENT_SECTION))) static const MJKRegisterData MJK_UNIQUE_IDENTIFIER = (MJKRegisterData){HEADER, VALUE} //定义 MJKRegisterData MJK_UNIQUE_IDENTIFIER放到MJK_SEGMENT_SECTION中

// @Private Encoding types
#define MJK_HEADER_ENCODE(KEY, TYPE, IS_ARRAY) (MJKRegisterDataHeader){_MJK_ASSERT_CSTRING(KEY), TYPE, IS_ARRAY}

// @Private Encode data
#define _MJK_DEFINE(KEY, TYPE, IS_ARRAY, VALUE) \
    _MJK_DATA_DEFINE(MJK_HEADER_ENCODE(KEY, TYPE, IS_ARRAY), VALUE) \

// @Private Define
#define MJK_DEFINE(KEY, TYPE, VALUE)            _MJK_DEFINE(KEY, TYPE, MJKRegisterArrayTypeIsNotArray, VALUE)
#define MJK_ARRAY_DEFINE(KEY, TYPE, VALUE)      _MJK_DEFINE(KEY, TYPE, MJKRegisterArrayTypeIsArray, VALUE)

// @Private Function export meta macro
#define __MJK_FUNCTION_EXPORT(DEFINE_METHOD, KEY, SEED)                    \
    MJK_USED static void MJK_IDENTIFIER(SEED)(void);                       \
    DEFINE_METHOD(KEY, MJKRegisterTypeFunction, MJK_IDENTIFIER(SEED));     \
    MJK_USED static void MJK_IDENTIFIER(SEED)

// @Private Function export
#define _MJK_FUNCTION_EXPORT(KEY, SEED)         __MJK_FUNCTION_EXPORT(MJK_DEFINE, KEY, SEED)

// @Private Function array export
#define _MJK_FUNCTIONS_EXPORT(KEY, SEED)        __MJK_FUNCTION_EXPORT(MJK_ARRAY_DEFINE, KEY, SEED)

// @Private C string assertion
#define _MJK_ASSERT_CSTRING(STRING) "" STRING

// @Private Class assertion
#define _MJK_ASSERT_CLASS(CLASS)                        \
    MJK_UNUSED static void MJK_UNIQUE_IDENTIFIER() {    \
        [CLASS alloc];                                  \
    }

#pragma mark - Data structure

typedef NS_ENUM(NSInteger, MJKRegisterType) {
    MJKRegisterTypeString = 0,
    MJKRegisterTypeMethod = 1,
    MJKRegisterTypeFunction = 2,
    MJKRegisterTypeClass = 3,
};

typedef NS_ENUM(NSInteger, MJKRegisterArrayType) {
    MJKRegisterArrayTypeIsNotArray = 0,
    MJKRegisterArrayTypeIsArray = 1,
};

typedef struct MJKRegisterDataHeader {
    const void *key;
    const MJKRegisterType type;
    const BOOL isArray;
} MJKRegisterDataHeader;

typedef struct MJKRegisterData {
    const MJKRegisterDataHeader header;
    const void *value;
} MJKRegisterData;

#endif /* MJKMacros_h */
