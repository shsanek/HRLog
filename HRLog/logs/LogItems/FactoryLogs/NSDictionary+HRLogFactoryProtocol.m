//
//  NSDictionary+HRLogFactoryProtocol.m
//  Pods
//
//  Created by Alexander Shipin on 13/04/16.
//
//

#import "NSDictionary+HRLogFactoryProtocol.h"
#import "HRTextLogItem.h"

@implementation NSDictionary (HRLogFactoryProtocol)

- (HRLogItem*) hrLogItemFromObject {
    HRLogItem* logItem = [[HRTextLogItem alloc] initWitfFormat:@"<%@>",NSStringFromClass([self class])];
    for (id item in self.allKeys) {
        HRLogItem* log = [HRLogFactory logItemFromObject:self[item]];
        log.name = [NSString stringWithFormat:@"%@",item];
        [logItem addSubitems:log];
    }
    return logItem;
}


@end
