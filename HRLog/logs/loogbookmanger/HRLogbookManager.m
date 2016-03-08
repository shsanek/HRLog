
//
//  HRLogbookManager.m
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogbookManager.h"

void HRLog(NSString* format,...) {
    va_list argumentList;
    va_start(argumentList, format);
    NSString* text = [[NSMutableString alloc] initWithFormat:format
                                          arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",text);
    [[HRLogbookManager sharedManager] log:[[HRTextLogItem alloc] initWitfFormat:@"%@",text]];
}
void HRNameLog(NSString* name,NSString* format,...) {
    va_list argumentList;
    va_start(argumentList, format);
    NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                   arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",text);
    [[HRLogbookManager sharedManager] log:[[HRTextLogItem alloc] initWitfName:name
                                                                       format:@"%@",text]];
}
void HRBeginLog(NSString* format,...){
    va_list argumentList;
    va_start(argumentList, format);
    NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                   arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",text);
    [[HRLogbookManager sharedManager] beginLog:[[HRTextLogItem alloc] initWitfFormat:@"%@",text]];
}
void HRBeginNameLog(NSString* name,NSString* format,...){
    va_list argumentList;
    va_start(argumentList, format);
    NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                   arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",text);
    [[HRLogbookManager sharedManager] beginLog:[[HRTextLogItem alloc] initWitfName:name
                                                                            format:@"%@",text]];
}

void HREndLog(){
    [[HRLogbookManager sharedManager] endLog];
}




@implementation HRLogbookManager

+ (HRLogbookManager *)sharedManager {
    static HRLogbookManager * manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manger = [HRLogbookManager new];
    });
    return manger;
}

+ (dispatch_queue_t) backgroundQueue{
    static dispatch_queue_t queuq;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queuq = dispatch_queue_create("hrLogBookCreate", NULL);
    });
    return queuq;
}

- (void) load{
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _logboook = [HRLogbook new];
    }
    return self;
}

- (NSData *)dataFromCurrentlogbook {
    return [NSKeyedArchiver archivedDataWithRootObject:self.logboook];
}


- (void) log:(HRLogItem*) log{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [self.logboook addLogItem:log];
    });
}

- (void) beginLog:(HRLogItem*) log{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [self.logboook addedNextLevelLogItem:log];
    });
}

- (void) endLog{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [self.logboook endLevel];
    });
}


@end
