//
//  NSArray+HRLogFactoryProtocol.m
//  Pods
//
//  Created by Alexander Shipin on 13/04/16.
//
//

#import "NSArray+HRLogFactoryProtocol.h"
#import "HRTextLogItem.h"

@implementation NSArray (HRLogFactoryProtocol)

- (HRLogItem*) hrLogItemFromObject {
    HRLogItem* logItem = [[HRTextLogItem alloc] initWitfFormat:@"<%@>",NSStringFromClass([self class])];
    int i = 0;
    for (id item in self) {
        HRLogItem* log = [HRLogFactory logItemFromObject:item];
        log.name = [NSString stringWithFormat:@"%d",i];
        [logItem addSubitems:log];
        i++;
    }
    return logItem;
}

@end
