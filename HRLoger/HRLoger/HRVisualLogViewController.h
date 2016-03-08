//
//  HRVisualLogViewController.h
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HRLogItem.h"

@interface HRVisualLogViewController : NSViewController

@property (nonatomic,strong) HRLogItem* logItem;

@end
