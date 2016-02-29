//
//  HRLogbookManagerItem.m
//  Pods
//
//  Created by Alexander Shipin on 28/02/16.
//
//

#import "HRLogbookManagerItem.h"
#import "HRCodingSupprotDefine.h"

@implementation HRLogbookManagerItem

- (instancetype)initWithLog:(HRLogItem *)item type:(HRLogbookManagerItemType)type{
    self = [super init];
    if (self) {
        _type = type;
        _logItem = item;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)  {
        HRLoadDecodeEnumIvar(_type);
        HRLoadDecodeObjectIvar(_logItem);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    HRSaveEncodeIntegerIvar(_type);
    HRSaveEncodeObjectIvar(_logItem);
}

@end
