//
//  NSDateFormatter+MMFormatter.m
//  HRLog
//
//  Created by Alexander Shipin on 29/03/16.
//  Copyright © 2016 hr. All rights reserved.
//
#if TARGET_OS_IPHONE
#import "NSDateFormatter+MMFormatter.h"

@implementation NSDateFormatter (MMFormatter)

+ (instancetype) mmMouthFormatter{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM"];
    });
    return formatter;
}

+ (instancetype) mmTimeFormatter{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
    });
    return formatter;
}

+ (instancetype) mmDateFormatter{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM yy"];
    });
    return formatter;
}

@end

#endif
