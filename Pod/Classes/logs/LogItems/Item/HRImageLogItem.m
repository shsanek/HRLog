//
//  HRImageLogItem.m
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRImageLogItem.h"


@implementation HRImageLogItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

#if TARGET_OS_IPHONE
- (instancetype)initWithImage:(UIImage *)image information:(NSString *)information{
    return [self initWithImage:image withScale:100. information:information];
}

- (instancetype)initWithImage:(UIImage *)image withScale:(CGFloat)scale information:(NSString *)information {
    NSData* data = UIImageJPEGRepresentation(image, scale);
    self = [super initWithData:data name:information];
    if (self) {
    }
    return self;
}

- (UIImage *)image {
    return [UIImage imageWithData:self.data];
}
#else
- (NSImage *)image {
    return [[NSImage alloc] initWithData:self.data];
}
#endif

@end
