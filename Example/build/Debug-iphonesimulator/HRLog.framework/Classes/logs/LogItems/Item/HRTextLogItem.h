//
//  HRTextLogItem.h
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRLogItem.h"

@interface HRTextLogItem : HRLogItem


- (instancetype) initWitfFormat:(NSString*) format , ...;
- (instancetype) initWitfName:(NSString*) name format:(NSString*) format , ...;

@property (nonatomic,strong,readonly) NSString* text;

@end
