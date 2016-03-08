//
//  HRLogItem.h
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRGeometry.h"

@class HRLogItem;

@protocol HRLogRepresentation3DProtocol <NSObject>

- (void) added3DRespresentation:(HRLogItem*) item;
- (void) addedSprite:(HRPoint*) point imageData:(NSData*) data;

@end

@interface HRLogItem : NSObject<NSCoding>

- (instancetype) initWithName:(NSString*) name;

@property (nonatomic,assign,readonly) NSUInteger identifier;
@property (nonatomic,strong,readonly) HRLogItem* parentItem;
@property (nonatomic,strong,readonly) NSDate* date;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong,readonly) NSArray<HRLogItem*>* subitems;

- (void) representationIn3D:(id<HRLogRepresentation3DProtocol>) representation;
- (void) addSubitems:(HRLogItem*) item;
- (NSString*) textRepresentation;

@end
