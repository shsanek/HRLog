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

@interface HRLogbookManager : NSObject

+ (HRLogbookManager*) sharedManager;

@property (nonatomic,strong,readonly) HRLogbook* logboook;

- (NSData*) dataFromCurrentlogbook;

@end
