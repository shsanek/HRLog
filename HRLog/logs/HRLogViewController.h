//
//  HRLogView.h
//  HRLoger
//
//  Created by Alexander Shipin on 21/02/2017.
//  Copyright © 2017 hr. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HRLogViewController : UIViewController

+ (void) setAppName:(NSString*) appName withEmail:(NSString*) email;
+ (void) addGestureShowInWindow:(UIWindow*) window;

@end
