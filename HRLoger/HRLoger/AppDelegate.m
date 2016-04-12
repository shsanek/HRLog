//
//  AppDelegate.m
//  HRLogViewer
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "AppDelegate.h"
#import "HRViewerViewController.h"
#import <HRLogbookManagerFactory.h>

@interface AppDelegate ()<HRLogbookManagerFactoryDelegate>

@property (nonatomic,strong) NSMutableArray* logerWindows;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[HRLogbookManagerFactory sharedFactory] runServerWithDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openExistingDocument:)
                                                 name:kHRViewerViewControllerOpenNotification
                                               object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - notification
- (void)openExistingDocument:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
            NSData* data = [NSData dataWithContentsOfURL:theDoc];
            HRViewerViewController* viewController = [self newWindow];
            viewController.logbook = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }];
}

#pragma mark - HRLogbookManagerFactoryDelegate
- (void)logbookManagerFactory:(HRLogbookManagerFactory *)factory
            newLogbookManager:(HRLogbookManager *)logbookManager{
    HRViewerViewController* viewController = [self newWindow];
    viewController.logbookManger = logbookManager;
}

#pragma mark - new window
- (NSMutableArray *)logerWindows{
    if (!_logerWindows) {
        _logerWindows = [NSMutableArray new];
    }
    return _logerWindows;
}

- (HRViewerViewController*) newWindow{
    NSStoryboard* storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSWindowController* windoController = storyboard.instantiateInitialController;
    [self.logerWindows addObject:windoController];
    [windoController showWindow:self];
    return (id)windoController.window.contentViewController;
}

@end
