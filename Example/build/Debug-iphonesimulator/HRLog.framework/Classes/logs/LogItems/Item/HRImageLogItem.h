//
//  HRImageLogItem.h
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif
#import "HRFileLogItem.h"

@interface HRImageLogItem : HRFileLogItem

#if TARGET_OS_IPHONE
- (instancetype) initWithImage:(UIImage*) image information:(NSString*) information;
- (instancetype) initWithImage:(UIImage *)image withScale:(CGFloat) scale information:(NSString*) information;

@property (nonatomic,strong,readonly) UIImage* image;
#else
@property (nonatomic,strong,readonly) NSImage* image;
#endif

@end
