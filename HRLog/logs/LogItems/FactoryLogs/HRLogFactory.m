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
    if ([object respondsToSelector:@selector(hrLogPropertyList)]) {
        HRTextLogItem* item = [[HRTextLogItem alloc] initWitfFormat:@"<%@>",NSStringFromClass( [object class])];
        NSArray* list = [object hrLogPropertyList];
        for (NSString* text in list) {
            HRLogItem* item2 = [self logItemFromObject:[object valueForKey:text]];
            item2.name = text;
            [item addSubitems:item2];
        }
    }
    return [[HRTextLogItem alloc] initWitfFormat:@"%@",[object description]];
}

@end
