//
//  HRLoger.h
//  HRLoger
//
//  Created by Alexander Shipin on 21/02/2017.
//  Copyright © 2017 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRLog.h"

@class HRLogSession;
@protocol  HRLogSessionDelegate <NSObject>

@optional
- (void) logSession:(HRLogSession*) session appendSting:(NSString*) text;

@end

@interface HRLogSession : NSObject<NSCoding>

@property (nonatomic, weak) id<HRLogSessionDelegate> delegate;
@property (nonatomic, strong, readonly) NSDate* date;
@property (nonatomic, strong, readonly) NSString* path;
@property (nonatomic, weak, readonly) NSData* log;
@property (nonatomic, strong, readonly) NSString* localPath;

@end

@interface HRLoger : NSObject


+ (instancetype) loger;
- (void) startSesstion;////CALL FOR START SESSION IN applicationDidFinishLaunching

@property (nonatomic, assign) BOOL notAddDateInLog;
@property (nonatomic, strong) NSString* startSymbol;
@property (nonatomic, assign) NSInteger numberOfSessionForSave;//default 10
@property (nonatomic, assign) BOOL printInNSLog;//default YES
@property (nonatomic, assign) BOOL addNewRow;//default YES;
@property (nonatomic, strong, readonly) NSArray<HRLogSession*>* lastSessions;
@property (nonatomic, strong, readonly) HRLogSession* currentSession;

@end
