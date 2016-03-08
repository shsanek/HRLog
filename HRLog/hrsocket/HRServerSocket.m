//
//  HRServerSoket.m
//  HRLog
//
//  Created by Alexander Shipin on 28/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRServerSocket.h"
#import <sys/socket.h>
#import <sys/types.h>
#include <netinet/in.h>

@interface HRServerSocket ()<HRSocketDelegate>

@property (nonatomic,strong,readonly) NSMutableArray<HRQueue*>* freeQueue;
@property (nonatomic,strong,readonly) NSMutableDictionary<NSNumber*,HRQueue*>* lockQueue;
@property (nonatomic,strong,readonly) NSMutableArray<HRSocket*>* clientSockets;
@property (nonatomic,assign) BOOL isValid;

@end

@implementation HRServerSocket

+ (NSString*) nextIndex{
    static NSUInteger index;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        index = 0;
    });
    index++;
    NSString* string = [NSString stringWithFormat:@"HRSocketServerBackgroundQueueNumber%lu",(unsigned long)index];
    return string;
}

- (NSArray<HRSocket *> *)sockets{
    return self.clientSockets;
}

- (void) addedSocket:(int) socketNumber{
    __block HRSocket* socket = nil;
    __block HRQueue* queue = nil;
    __weak typeof(self) weakSelf = self;
    if (weakSelf.freeQueue.count) {
        queue = weakSelf.freeQueue.lastObject;
        [weakSelf.freeQueue removeLastObject];
    } else{
        queue = [[HRQueue alloc] initWithQueue:dispatch_queue_create([HRServerSocket nextIndex].UTF8String, NULL)];
    }
    [weakSelf.lockQueue setObject:queue forKey:@(socketNumber)];
    socket = [[HRSocket alloc] initWithSocket:socketNumber queue:queue];
    [weakSelf.clientSockets addObject:socket];
    
    socket.delegate = self;
    [self.delegate contentSocket:socket];
    [self loopInQueue:queue socket:socket];
}

- (void) loopInQueue:(HRQueue*) queue socket:(HRSocket*) socket{
    __block BOOL isData;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [socket recivSoketCompletionBlock:^(NSData *data) {
        isData = !!data;
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (isData) {
        [self endSocket:socket];
    } else {
        [self loopInQueue:queue socket:socket];
    }
}

- (void) endSocket:(HRSocket*) socket{
    [self.delegate discontentSocket:socket];
    [self.queue sync:^{
        HRQueue* queue = self.lockQueue[@(socket.socket)];
        [self.lockQueue removeObjectForKey:@(socket.socket)];
        [self.freeQueue addObject:queue];
        [self.clientSockets removeObject:socket];
    }];
}

- (void) loopListen{
    [self.queue async:^{
        int sock = accept(self.socket, NULL, NULL);
        if(sock < 0){
            NSLog(@"warning:socket identifier < 0");
        }
        [self addedSocket:sock];
    }];
}

- (void) startListenNumberOfContent:(NSInteger) numberOfContent{
    if (self.socket < 0 || !self.isValid) {
        NSLog(@"error socket");
        return;
    }
    listen(self.socket, (int)numberOfContent);
    [self loopListen];
}

- (void)sendData:(NSData *)data completionBloack:(void (^)(BOOL))completionBloack{
    if (self.socket < 0 || !self.isValid) {
        NSLog(@"error socket");
        if (completionBloack){
            completionBloack(NO);
        }
        return;
    }
    [self.queue async:^{
        __block BOOL isData = YES;
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        int k = 0;
        for (HRSocket* soc in self.sockets) {
            [soc sendData:data completionBloack:^(BOOL isFinish) {
                isData = isData && isFinish;
                dispatch_semaphore_signal(semaphore);
            }];
            k ++;
        }
        for (int i = 0; i < k; i++){
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        if (completionBloack) {
            completionBloack(isData);
        }
    }];
}

- (void)startServerWithPort:(NSInteger)port maxContent:(NSInteger) numberOfContent{
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    if (bind(self.socket, (struct sockaddr *)&addr, sizeof(addr)) < 0  ){
        NSLog(@"server error");
        self.isValid = NO;
    } else {
        self.isValid = YES;
    }
    [self startListenNumberOfContent:numberOfContent];
}


#pragma mark - HRSocketDelegate
- (void)contentSocket:(HRSocket *)socket {
    [self.delegate contentSocket:socket];
}

- (void) socket:(HRSocket*) socket didRecivData:(NSData*) data{
    [self.delegate socket:socket didRecivData:data];
}

- (void) discontentSocket:(HRSocket*) socket{
    [self.delegate discontentSocket:socket];
}


@end
