//
//  HRFileLogItem.h
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogItem.h"

@interface HRFileLogItem : HRLogItem

+ (void) clearStorage;

- (instancetype) initWithData:(NSData*) data name:(NSString*) name;

@property (nonatomic,strong,readonly) NSData* data;

@end
