//
//  HRLogApplication.m
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRLogApplication.h"
#import "HRViewerViewController.h"

@implementation HRLogApplication

- (IBAction)pressedButtonOpen:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHRViewerViewControllerOpenNotification object:self];
}

@end
