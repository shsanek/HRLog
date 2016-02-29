//
//  HRServerSoket.h
//  HRLog
//
//  Created by Alexander Shipin on 28/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRSocket.h"

@interface HRServerSocket : HRSocket

@property (nonatomic,strong,readonly) NSArray<HRSocket*>* sockets;

- (void) startServerWithPort:(NSInteger) port maxContent:(NSInteger) connetc;

@end
