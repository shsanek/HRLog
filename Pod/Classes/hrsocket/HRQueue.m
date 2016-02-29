//
//  HRQueue.m
//  HRLog
//
//  Created by Alexander Shipin on 28/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRQueue.h"

@implementation HRQueue

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        _queue = queue;
    }
    return self;
}

- (void)sync:(void (^)())block{
    dispatch_sync(self.queue, block);
}

- (void)async:(void (^)())block {
    dispatch_async(self.queue, block);
}

//- (void)setQueue:(dispatch_queue_t)queue{
//    if (_queue) {
//        dispatch_release(_queue);
//    }
//    dispatch_retain(queue);
//    _queue = queue;
//}

@end