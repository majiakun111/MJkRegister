//
//  MJKDataSegmentImageReader.h
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MJKImageReadingBlock)(const void **addr);

@interface MJKImageReader : NSObject

+ (void)readSectionWithName:(char *)name fromAllImageWithStep:(size_t)step usingBlock:(MJKImageReadingBlock)block;

@end

NS_ASSUME_NONNULL_END
