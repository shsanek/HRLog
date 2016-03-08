//
//  HRSocket.h
//  HRLog
//
//  Created by Alexander Shipin on 28/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRQueue.h"

@class HRSocket;

@protocol HRSocketDelegate <NSObject>

- (void) contentSocket:(HRSocket*) socket;
- (void) socket:(HRSocket*) socket didRecivData:(NSData*) data;
- (void) discontentSocket:(HRSocket*) socket;

@end

@interface HRSocket : NSObject

@property (nonatomic,weak) id<HRSocketDelegate> delegate;
@property (nonatomic,assign,readonly) int socket;
@property (nonatomic,strong,readonly) HRQueue* queue;

- (instancetype) initWithSocket:(int) socket queue:(HRQueue*) queue;
- (instancetype) initWithQueue:(HRQueue*) queue;

- (void) sendData:(NSData*) data completionBloack:(void (^)(BOOL isFinish)) completionBloack;
- (void) recivSoketCompletionBlock:(void (^)(NSData* data)) completionBlock;

@end



