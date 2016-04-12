//
//  HRSharedLogViewControllerFactory.h
//  MathMate2
//
//  Created by Alexander Shipin on 12/04/16.
//  Copyright © 2016 hr. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
@class UIViewController;
@class MFMailComposeViewController;

@interface HRSharedLogViewControllerFactory : NSObject

+ (UIViewController*) sharedController;
+ (MFMailComposeViewController*) mailComposeViewController;

@end
#endif