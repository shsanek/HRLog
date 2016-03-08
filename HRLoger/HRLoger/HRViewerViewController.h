//
//  ViewController.h
//  HRLogViewer
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HRKeyDefine.h"

@class HRLogbook;

HRIntefaceKey(kHRViewerViewControllerOpenNotification);

@interface HRViewerViewController : NSViewController

@property (nonatomic,strong) HRLogbook* loogbook;

@end

