//
//  HRLogbookManagerItem.h
//  Pods
//
//  Created by Alexander Shipin on 28/02/16.
//
//

#import <Foundation/Foundation.h>
#import "HRLogItem.h"

typedef  enum {
    HRLogbookManagerItemTypeLog = 0,
    HRLogbookManagerItemTypeBegin,
    HRLogbookManagerItemTypeEnd
}HRLogbookManagerItemType;

@interface HRLogbookManagerItem : NSObject<NSCoding>

- (instancetype) initWithLog:(HRLogItem*) item type:(HRLogbookManagerItemType) type;

@property (nonatomic,strong) HRLogItem* logItem;
@property (nonatomic,assign) HRLogbookManagerItemType type;

@end
