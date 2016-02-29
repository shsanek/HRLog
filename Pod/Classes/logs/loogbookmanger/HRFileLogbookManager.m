//
//  HRFileLogbookManager.m
//  Pods
//
//  Created by Alexander Shipin on 28/02/16.
//
//

#import "HRFileLogbookManager.h"
#import "HRLogbookManagerItem.h"

@interface HRFileLogbookManager ()

@property (nonatomic,strong) NSString* path;
@property (nonatomic,assign) NSUInteger index;

@end

@implementation HRFileLogbookManager

+ (void)clearStorage {
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self dataPath]
                                               error:&error];
    if (error) {
        NSLog(@"HRImageLogItem  <%@>" ,error);
    }
}

+ (HRLogbook *)lastLoogbook {
    NSString* path = [self dataPath];
    HRLogbook* logbook = [[HRLogbook alloc] init];
    NSUInteger index = 0;
    while (true) {
        @autoreleasepool {
            index++;
            NSString* path1 = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.log",(unsigned long)index]];
            NSData* data =[[NSData alloc] initWithContentsOfFile:path1];
            if (!data) {
                break;
            }
            HRLogbookManagerItem* item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (item.type == HRLogbookManagerItemTypeLog) {
                [logbook addLogItem:item.logItem];
            } else if (item.type == HRLogbookManagerItemTypeBegin) {
                [logbook addedNextLevelLogItem:item.logItem];
            } else {
                [logbook endLevel];
            }
        }
    }
    return logbook;
}

+ (NSString*) dataPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/HR_LOG"];
    return dataPath;
}

- (instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void) load {
    [self loadPath];
}

- (void) saveData:(NSData*) data inPath:(NSString*) path{
    [data writeToFile:path atomically:YES];
}

- (void) loadPath{
    NSError *error;
    NSString *dataPath = [HRFileLogbookManager dataPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath] )
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    if (error) {
        NSLog(@"HRFileLogbookManager:addFolder  <%@>" ,error);
    }
    self.path = dataPath;
}

- (NSString*) nextPath{
    self.index++;
    NSString* string = [self.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.log",(unsigned long)self.index]];
    return string;
}

- (void) log:(HRLogItem*) log{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        HRLogbookManagerItem* item = [[HRLogbookManagerItem alloc] initWithLog:log type:(HRLogbookManagerItemTypeLog)];
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:item];
        [self saveData:data inPath:[self nextPath]];
    });
}

- (void) beginLog:(HRLogItem*) log{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        HRLogbookManagerItem* item = [[HRLogbookManagerItem alloc] initWithLog:log type:(HRLogbookManagerItemTypeBegin)];
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:item];
        [self saveData:data inPath:[self nextPath]];
    });
}

- (void) endLog{
    dispatch_async([HRLogbookManager backgroundQueue], ^{
        HRLogbookManagerItem* item = [[HRLogbookManagerItem alloc] initWithLog:nil type:(HRLogbookManagerItemTypeEnd)];
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:item];
        [self saveData:data inPath:[self nextPath]];
    });
}

@end
