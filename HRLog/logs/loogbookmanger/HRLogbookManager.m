
//
//  HRLogbookManager.m
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogbookManager.h"
#import "HRClientLogbookManager.h"
#import "HRLogFactory.h"

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

void HRObjectLog(id object){
    NSLog(@"%@",[object dictionary]);
    HRLogItem* item = [HRLogFactory logItemFromObject:object];
    [[HRLogbookManager sharedManager] log:item];
}

void HRNameObjectLog(NSString* name,id object){
    NSLog(@"%@",[object dictionary]);
    HRLogItem* item = [HRLogFactory logItemFromObject:object];
    item.name = name;
    [[HRLogbookManager sharedManager] log:item];
}

void HRAddLog(HRLogItem* logItem){
    [[HRLogbookManager sharedManager] log:logItem];
}



@implementation HRLogbookManager

+ (HRLogbookManager *)sharedManager {
    static HRLogbookManager * manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef DEBUG
        manger = [HRClientLogbookManager new];
#else
        manger = [HRLogbookManager new];
#endif
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
    __weak typeof (self) weakSelf = self;
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [weakSelf.logboook addLogItem:log];
        [weakSelf.delegate didAddedNewItemInLogbookManger:weakSelf];
    });
}

- (void) beginLog:(HRLogItem*) log{
    __weak typeof (self) weakSelf = self;
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [weakSelf.logboook addedNextLevelLogItem:log];
        [weakSelf.delegate didAddedNewItemInLogbookManger:weakSelf];
    });
}

- (void) endLog{
    __weak typeof (self) weakSelf = self;
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        [weakSelf.logboook endLevel];
        [weakSelf.delegate didAddedNewItemInLogbookManger:weakSelf];
    });
}


@end
