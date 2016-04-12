//
//  HRLogbookManagerFactory.h
//  Pods
//
//  Created by Alexander Shipin on 12/04/16.
//
//

#import <Foundation/Foundation.h>

@class HRLogbookManagerFactory;
@class HRLogbookManager;

@protocol HRLogbookManagerFactoryDelegate <NSObject>

- (void) logbookManagerFactory:(HRLogbookManagerFactory*) factory
             newLogbookManager:(HRLogbookManager*) logbookManager;

@end

@interface HRLogbookManagerFactory : NSObject

+ (instancetype) sharedFactory;

@property (nonatomic,weak,readonly) id<HRLogbookManagerFactoryDelegate> delegate;

- (void) runServerWithDelegate:(id<HRLogbookManagerFactoryDelegate>) delegate;


@end
