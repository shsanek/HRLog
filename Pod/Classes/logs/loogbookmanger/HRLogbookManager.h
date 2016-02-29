//
//  HRLogbookManager.h
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRLogbook.h"
#import "HRTextLogItem.h"

void HRLog(NSString* format,...);
void HRNameLog(NSString* name,NSString* format,...);
void HRBeginLog(NSString* format,...);
void HRBeginNameLog(NSString* name,NSString* format,...);
void HREndLog();



@protocol HRLogbookManageDelegate <NSObject>

- (void) log:(HRLogItem*) log;
- (void) beginLog:(HRLogItem*) log;
- (void) endLog;

@end

@interface HRLogbookManager : NSObject<HRLogbookManageDelegate>

+ (HRLogbookManager*) sharedManager;
+ (dispatch_queue_t) backgroundQueue;

@property (nonatomic,strong,readonly) HRLogbook* logboook;

- (void) load;

- (NSData*) dataFromCurrentlogbook;

@end
