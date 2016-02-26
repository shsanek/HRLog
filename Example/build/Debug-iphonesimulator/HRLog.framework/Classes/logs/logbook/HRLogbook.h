//
//  HRLogbook.h
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRLogItem.h"

@interface HRLogbook : NSObject<NSCoding>

@property (nonatomic,strong,readonly) NSArray<HRLogItem*>* logItems;

- (void) addLogItem:(HRLogItem*) logItem;
- (void) addedNextLevelLogItem:(HRLogItem*) item;
- (void) endLevel;

@end
