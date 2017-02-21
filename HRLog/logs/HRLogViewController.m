//
//  HRLogView.m
//  HRLoger
//
//  Created by Alexander Shipin on 21/02/2017.
//  Copyright © 2017 hr. All rights reserved.
//

#import "HRLogViewController.h"
#import "HRLoger.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface HRLogViewController()<HRLogSessionDelegate,UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextView* textView;
@property (nonatomic, strong) UIWindow* lastKeyVisableWindow;
@property (nonatomic, strong) UIWindow* currentWindow;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* appName;
@property (nonatomic, strong) NSMutableString* text;
@end

@implementation HRLogViewController

+ (instancetype) logViewController{
    static HRLogViewController* result;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [UIStoryboard storyboardWithName:@"HRLogViewController" bundle:nil].instantiateInitialViewController;
    });
    return result;
}

+ (void) addGestureShowInWindow:(UIWindow*) window{
    UITapGestureRecognizer* recor = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(showViewController:)];
    recor.numberOfTapsRequired = 2;
    recor.numberOfTouchesRequired = 3;
    
    recor.delegate = [HRLogViewController logViewController];
    [window addGestureRecognizer:recor];
    [HRLoger loger].currentSession.delegate = [HRLogViewController logViewController];
}



+ (void) setAppName:(NSString*) appName withEmail:(NSString*) email{
    [HRLogViewController logViewController].appName = appName;
    [HRLogViewController logViewController].email = email;
}

+ (void) showViewController:(id) sender{
    [HRLogViewController logViewController].lastKeyVisableWindow = [UIApplication sharedApplication].keyWindow;
    static UIWindow* window;
    if (!window){
        window = [UIWindow new];
        window.rootViewController = [self logViewController];
    }
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    window.windowLevel = topWindow.windowLevel + 1;
    [window makeKeyAndVisible];
    window.hidden = NO;
    [HRLogViewController logViewController].currentWindow = window;
    [[HRLogViewController logViewController].textView setNeedsLayout];
    [[HRLogViewController logViewController].textView layoutIfNeeded];
}

#pragma mark -
- (NSString *)appName {
    return _appName?_appName:@"MY APP";
}

#pragma mark 
- (IBAction)pressedButtonClose:(id)sender{
    self.currentWindow.hidden = YES;
    [self.lastKeyVisableWindow makeKeyAndVisible];
}

- (void) sendLogSession:(HRLogSession*) logSession{
    if (![MFMailComposeViewController canSendMail] || !logSession){
        return;
    }
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setSubject:[NSString stringWithFormat:@"LOG - %@",self.appName]];
    picker.mailComposeDelegate = self;
    NSString *emailBody = @"";
    [picker setMessageBody:emailBody isHTML:YES];
    if (self.email) {
        [picker setToRecipients:@[self.email]];
    }
    [picker addAttachmentData:logSession.log
                     mimeType:@"text/plain"
                     fileName:logSession.localPath];
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (IBAction)pressedButtonSender:(id)sender{
    [self sendLogSession:[HRLoger loger].currentSession];
}

- (IBAction)pressedButtonLastSender:(id)sender{
    [self sendLogSession:[HRLoger loger].lastSessions.lastObject];
}

#pragma mark -
- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.textView.textColor = [UIColor greenColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.text = self.text;
}

#pragma mark - HRLogSessionDelegate
- (void) logSession:(HRLogSession*) session appendSting:(NSString*) text{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.text){
            self.text = [NSMutableString new];
        }
        [self.text appendString:text];
        self.textView.text = self.text;
    });
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
