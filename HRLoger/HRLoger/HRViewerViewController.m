//
//  ViewController.m
//  HRLogViewer
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRViewerViewController.h"
#import <HRLog/HRLogbookManager.h>

HRImplementationKey(kHRViewerViewControllerOpenNotification);

@interface HRViewerViewController ()<NSOutlineViewDataSource,NSOutlineViewDelegate,HRLogbookManagerDelegate>

@property (nonatomic,strong) IBOutlet NSOutlineView* outlineView;
@property (nonatomic,strong) IBOutlet NSTableColumn* dateColumn;
@property (nonatomic,strong) IBOutlet NSTableColumn* nameColumn;
@property (nonatomic,strong) IBOutlet NSTableColumn* descriptionColumn;


@end

@implementation HRViewerViewController{
    HRLogbook* _logbook;
}




- (void)viewDidLoad{
    [super viewDidLoad];
    self.outlineView.dataSource = self;
    self.outlineView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cangeFrameNotification:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:self.outlineView];

}

#pragma mark - set get

- (HRLogbook *)logbook {
    if (self.logbookManger) {
        return self.logbookManger.logboook;
    }
    return _logbook;
}

- (void)setLogbookManger:(HRLogbookManager *)logbookManger{
    _logbookManger = logbookManger;
    _logbookManger.delegate = self;
    [self.outlineView reloadData];
}

- (void)setLogbook:(HRLogbook *)logbook {
    _logbook = logbook;
    [self.outlineView reloadData];
}

#pragma mark - action
- (void) cangeFrameNotification:(NSNotification*) notification{
    [self.outlineView reloadData];
}


- (NSString*) stringFromDate:(NSDate*) date{
    return [date description];
}

#pragma mark - NSOutlineViewDelegate

- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(HRLogItem*)item{
    NSFont *font = [NSFont systemFontOfSize:13];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                forKey:NSFontAttributeName];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:item.textRepresentation attributes:attrsDictionary];

    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(self.descriptionColumn.width - 4, 10000)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        context:nil];
    return rect.size.height + 2;
}

#pragma mark - HRLogbookManagerDelegate
- (void) didAddedNewItemInLogbookManger:(HRLogbookManager*) manager{
    [self.outlineView reloadData];
}

#pragma mark - NSOutlineViewDataSource;
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(HRLogItem*)item{
    return !item ? self.logbook.logItems.count : item.subitems.count;
}
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(HRLogItem*)item{
    return !item ? self.logbook.logItems[index] : item.subitems[index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(HRLogItem*)item{
    return !item ? YES : (item.subitems.count != 0);
}

- (nullable id)outlineView:(NSOutlineView *)outlineView
 objectValueForTableColumn:(nullable NSTableColumn *)tableColumn
                    byItem:(HRLogItem*)item{
    if (tableColumn == self.dateColumn) {
        return [self stringFromDate:item.date];
    }
    if (tableColumn == self.nameColumn) {
        return item.name;
    }
    if (tableColumn == self.descriptionColumn){
        return item.textRepresentation;
    }
    return @"";
}

@end
