//
//  HRSharedLogViewControllerFactory.m
//  HRLog
//
//  Created by Alexander Shipin on 12/04/16.
//  Copyright © 2016 hr. All rights reserved.
//
#if TARGET_OS_IPHONE
#import "HRSharedLogViewControllerFactory.h"
#import <UIKit/UIKit.h>
#import <HRLog/HRLogbookManager.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@implementation HRSharedLogViewControllerFactory

+ (UIViewController*) sharedController{
    NSData* data = [[HRLogbookManager sharedManager] dataFromCurrentlogbook];
    NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"sharedlog.log"];
    [data writeToFile:path atomically:YES];
    NSURL* url = [NSURL fileURLWithPath:path];
    // NSLocalizedString(@"Calculated with Plus", @"body mail send work sheet")
    UIActivityViewController *activity = [[UIActivityViewController alloc]
                                          initWithActivityItems:@[url]
                                          applicationActivities:nil];
    
    [activity setValue:@"report" forKey:@"subject"];
    [activity setValue:@"" forKey:@""];
    return activity;
}

+ (MFMailComposeViewController*) mailComposeViewController{
    if (![MFMailComposeViewController canSendMail]){
        UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"Can not send messages"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles: nil];
        [view show];
    }
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setToRecipients:@[@"plus.smart.calculator@gmail.com"]];
    [picker setSubject:NSLocalizedString(@"Plus Feedback", @"subject mail recommend")];
    NSData* data = [[HRLogbookManager sharedManager] dataFromCurrentlogbook];
    [picker addAttachmentData:data mimeType:@"log" fileName:@"sharedlog"];
    return picker;
}

@end

#endif
