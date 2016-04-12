//
//  HRServerLogbookManger.h
//  Pods
//
//  Created by Alexander Shipin on 12/04/16.
//
//

#import "HRLogbookManager.h"

@class HRServerLogbookManger;



@interface HRServerLogbookManger : HRLogbookManager

- (void) readNewData:(NSData*) data;

@end
