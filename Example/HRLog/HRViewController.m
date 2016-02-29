//
//  HRViewController.m
//  HRLog
//
//  Created by Alexander Shipin on 02/26/2016.
//  Copyright (c) 2016 Alexander Shipin. All rights reserved.
//

#import "HRViewController.h"
#import "HRClientSocket.h"

@interface HRViewController ()

@end

@implementation HRViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    HRQueue* queue = [[HRQueue alloc] initWithQueue:dispatch_queue_create("bac", NULL)];
    HRClientSocket* client = [[HRClientSocket alloc] initWithQueue:queue];
    [client connectIP:nil port:3426];
    [client sendData:[NSKeyedArchiver archivedDataWithRootObject:@"broded"]
    completionBloack:^(BOOL isFinish) {
        
    }];
}

@end
