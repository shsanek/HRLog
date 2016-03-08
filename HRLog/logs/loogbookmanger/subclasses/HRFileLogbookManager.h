//
//  HRFileLogbookManager.h
//  Pods
//
//  Created by Alexander Shipin on 28/02/16.
//
//

#import "HRLogbookManager.h"
@interface HRFileLogbookManager : HRLogbookManager

+ (HRLogbook*) lastLoogbook;
+ (void) clearStorage;

@end
