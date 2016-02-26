//
//  HRLogFactory.m
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogFactory.h"
#import "HRTextLogItem.h"

@implementation HRLogFactory

+ (HRLogItem *)logItemFromObject:(id)object{
    if ([object respondsToSelector:@selector(hrLogItemFromObject)]) {
        return [object hrLogItemFromObject];
    }
    return [[HRTextLogItem alloc] initWitfFormat:@"%@",[object description]];
}

@end
