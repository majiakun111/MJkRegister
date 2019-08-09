//
//  MJKDataSegmentImageReader.m
//  MJKRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "MJKImageReader.h"
#import "MJKMacros.h"
#import <dlfcn.h>
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>

#ifdef __LP64__

typedef uint64_t uint_type;
typedef struct section_64 section_type;
#define getsectbynamefromheader_type getsectbynamefromheader_64

#else

typedef uint32_t uint_type;
typedef struct section section_type;
#define getsectbynamefromheader_type getsectbynamefromheader

#endif

@implementation MJKImageReader

+ (void)readSectionWithName:(char *)sectionName fromAllImageWithStep:(size_t)step usingBlock:(MJKImageReadingBlock)block {
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0; i < count; i++) {
        const struct mach_header* image_header = _dyld_get_image_header(i);
        Dl_info info;
        if (dladdr(image_header, &info) == 0) {
            continue;
        }
      
        [self readSectionWithName:sectionName segmentName:MJK_SEGMENT_NAME fromImageInfo:info andStep:step usingBlock:block];
    }
}

#pragma mark - PrivateMethod

+ (void)readSectionWithName:(char *)sectionName segmentName:(char *)segmentName fromImageInfo:(Dl_info)info andStep:(size_t)step usingBlock:(MJKImageReadingBlock)block {
    const void *mach_header = info.dli_fbase;
    const section_type *section = getsectbynamefromheader_type((void *)mach_header, segmentName, sectionName);
    if (section == NULL) return;
    
    for (uint_type offset = section->offset; offset < section->offset + section->size; offset += step) {
        block((const void **)(mach_header + offset));
    }
}

@end
