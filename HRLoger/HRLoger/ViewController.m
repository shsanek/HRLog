//
//  ViewController.m
//  HRLoger
//
//  Created by Alexander Shipin on 21/02/2017.
//  Copyright © 2017 hr. All rights reserved.
//

#import "ViewController.h"
#import <HRLog.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HRLog(@"load view controller");
}

- (IBAction)pressedButton:(id)sender {
    HRLog(@"pressed button %d",rand());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
