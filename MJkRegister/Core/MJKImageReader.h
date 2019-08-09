//
//  MJKDataSegmentImageReader.h
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MJKImageReadingBlock)(const void * _Nullable * _Nullable addr);

NS_ASSUME_NONNULL_BEGIN

@interface MJKImageReader : NSObject

+ (void)readSectionWithName:(char *)name fromAllImageWithStep:(size_t)step usingBlock:(MJKImageReadingBlock)block;

@end

NS_ASSUME_NONNULL_END
