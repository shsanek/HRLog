//
//  HRLogbookManagerFactory.m
//  Pods
//
//  Created by Alexander Shipin on 12/04/16.
//
//

#import "HRLogbookManagerFactory.h"
#import "HRDeveloperLogerMangerKey.h"
#import <HRSocket/HRServerSocket.h>
#import "HRServerLogbookManger.h"

@interface HRLogbookManagerFactory ()<HRSocketDelegate>

@property (nonatomic,strong) HRServerSocket* serverSocket;
@property (nonatomic,strong) NSMutableDictionary<NSNumber*,HRServerLogbookManger*>* logbookMangers;

@end

@implementation HRLogbookManagerFactory

+ (instancetype)sharedFactory {
    static HRLogbookManagerFactory* manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [HRLogbookManagerFactory new];
    });
    return manger;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _logbookMangers = [NSMutableDictionary new];
    }
    return self;
}

- (void) runServerWithDelegate:(id<HRLogbookManagerFactoryDelegate>) delegate{
    [self.serverSocket close];
    _logbookMangers = [NSMutableDictionary new];
    HRQueue * outQ = [[HRQueue alloc] initWithQueue:dispatch_queue_create("HRClientLogbookManager.serverout", NULL)];
    HRQueue * inQ = [[HRQueue alloc] initWithQueue:dispatch_queue_create("HRClientLogbookManager.serverin", NULL)];
    HRServerSocket* serverSocket = [[HRServerSocket alloc] initWithReadQueue:outQ
                                                                  writeQueue:inQ];
    serverSocket.delegate = self;
    [serverSocket startServerWithPort:kHRLogerDeveloperServerPort maxContent:10];
    _serverSocket = serverSocket;
    _delegate = delegate;
}

- (void)stopServer {
    [self.serverSocket close];
}

#pragma mark - HRSocketDelegate

- (void) contentSocket:(HRSocket*) socket{
    HRServerLogbookManger* serverLogbookManeger = [[HRServerLogbookManger alloc] init];
    [self.logbookMangers setObject:serverLogbookManeger
                            forKey:@(socket.socket)];
    [self.delegate logbookManagerFactory:self
                       newLogbookManager:serverLogbookManeger];
}

- (void) socket:(HRSocket*) socket didRecivData:(NSData*) data{
    [self.logbookMangers[@(socket.socket)] readNewData:data];
}

- (void) discontentSocket:(HRSocket*) socket{
    [self.logbookMangers removeObjectForKey:@(socket.socket)];
}

@end
