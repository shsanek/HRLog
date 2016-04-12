//
//  NSDateFormatter+MMFormatter.h
//  MathMate2
//
//  Created by Alexander Shipin on 29/03/16.
//  Copyright © 2016 hr. All rights reserved.
//
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>

@interface NSDateFormatter (MMFormatter)

+ (instancetype) mmTimeFormatter;
+ (instancetype) mmDateFormatter;
+ (instancetype) mmMouthFormatter;

@end
#endif