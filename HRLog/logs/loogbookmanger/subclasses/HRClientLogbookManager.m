//
//  HRClientLogbookManager.m
//  Pods
//
//  Created by Alexander Shipin on 28/02/16.
//
//

#import "HRClientLogbookManager.h"
#import <HRSocket/HRClientSocket.h>
#import "HRDeveloperLogerMangerKey.h"

@interface HRClientLogbookManager()

@property (nonatomic,strong) HRClientSocket* clientSocket;

@end

@implementation HRClientLogbookManager

- (HRClientSocket *)clientSocket {
    if (!_clientSocket) {
        HRQueue * outQ = [[HRQueue alloc] initWithQueue:dispatch_queue_create("HRClientLogbookManager.serverout", NULL)];
        HRQueue * inQ = [[HRQueue alloc] initWithQueue:dispatch_queue_create("HRClientLogbookManager.serverin", NULL)];
        HRClientSocket* clientSocket = [[HRClientSocket alloc]initWithReadQueue:outQ
                                                                     writeQueue:inQ];
        NSString* ip = [[NSBundle mainBundle] objectForInfoDictionaryKey:kHRLogerDeveloperServerIPKey];
        if (ip.length == 0) {
            ip = nil;
        }
#if TARGET_IPHONE_SIMULATOR
        ip = nil;
#endif
        [clientSocket connectIP:ip port:kHRLogerDeveloperServerPort];
        _clientSocket = clientSocket;
    }
    return _clientSocket;
}

- (void) log:(HRLogItem*) log{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:@{kHRLogerDeveloperLogKey:log}];
    [self.clientSocket sendData:data completionBloack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"error sent log data");
        }
    }];
}

- (void) beginLog:(HRLogItem*) log{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:@{kHRLogerDeveloperBeginLogKey:log}];
    [self.clientSocket sendData:data completionBloack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"error sent log data");
        }
    }];
}

- (void) endLog{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:@{kHRLogerDeveloperEndLogKey:@""}];
    [self.clientSocket sendData:data completionBloack:^(BOOL isFinish) {
        if (isFinish) {
            NSLog(@"error sent log data");
        }
    }];
}

@end
