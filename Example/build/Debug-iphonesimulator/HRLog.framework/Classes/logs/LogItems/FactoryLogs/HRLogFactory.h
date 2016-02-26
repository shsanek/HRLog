//
//  HRLogFactory.h
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogItem.h"
#import "HRLogItem.h"

@protocol  HRLogFactoryProtocol <NSObject>

- (HRLogItem*) hrLogItemFromObject;

@end

@interface HRLogFactory : NSObject

+ (HRLogItem*) logItemFromObject:(id) object;

@end
