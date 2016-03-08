//
//  HRLogItem.m
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogItem.h"
#import "HRCodingSupprotDefine.h"

@interface HRLogItem()

@property (nonatomic,strong,readwrite) HRLogItem* parentItem;

@end

@implementation HRLogItem{
    NSMutableArray* _subitems;
}

+ (NSUInteger) nextIndex{
    static NSUInteger index;;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        index = 0;
    });
    index++;
    return index;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        _date = [NSDate date];
        _subitems = [NSMutableArray new];
        _identifier = [HRLogItem nextIndex];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    self = [self init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        HRLoadDecodeObjectIvar(_date);
        HRLoadDecodeObjectMutableArrayIvar(_subitems);
        HRLoadDecodeIntegerIvar(_identifier);
        HRLoadDecodeObjectIvar(_name);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    HRSaveEncodeObjectIvar(_date);
    HRSaveEncodeObjectIvar(_subitems);
    HRSaveEncodeIntegerIvar(_identifier);
    HRSaveEncodeObjectIvar(_name);
}


- (void)addSubitems:(HRLogItem *)item {
    NSAssert(!item.parentItem, @"HRLogItem item alredy have subitem");
    [_subitems addObject:item];
    item.parentItem = self;
}

- (NSString*) toHTMLLevel:(NSInteger)level{
    NSMutableString* text = [NSMutableString new];
    return text;
}

- (NSString *)textRepresentation {
    return @"";
}

- (void)representationIn3D:(id<HRLogRepresentation3DProtocol>)representation {
    for (HRLogItem* logItem in self.subitems) {
        [representation added3DRespresentation:logItem];
    }
}

@end
