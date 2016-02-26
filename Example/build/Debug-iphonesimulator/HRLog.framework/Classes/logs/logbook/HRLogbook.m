//
//  HRLogbook.m
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogbook.h"
#import "HRCodingSupprotDefine.h"

@interface HRLogbook ()

@property (nonatomic,strong) HRLogItem* topItem;

@end

@implementation HRLogbook{
    NSMutableArray<HRLogItem*>* _logItems;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _logItems = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        HRLoadDecodeObjectMutableArrayIvar(_logItems);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    HRSaveEncodeObjectIvar(_logItems);
}

- (NSArray<HRLogItem *> *)logItems {
    return _logItems;
}

- (void)addLogItem:(HRLogItem *)logItem{
    if (self.topItem) {
        [self.topItem addSubitems:logItem];
    } else {
        [_logItems addObject:logItem];
    }
}

- (void)addedNextLevelLogItem:(HRLogItem *)item{
    [self addLogItem:item];
    self.topItem = item;
}

- (void)endLevel {
    self.topItem = self.topItem.parentItem;
}

@end
