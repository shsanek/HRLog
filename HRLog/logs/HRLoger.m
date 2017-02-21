//
//  HRLoger.m
//  HRLoger
//
//  Created by Alexander Shipin on 21/02/2017.
//  Copyright © 2017 Alexander Shipin. All rights reserved.
//

#import "HRLoger.h"

@interface HRLoger ()

- (void) addText:(NSString*) text;
- (NSString*) path;

@end


void HRLog(NSString* format,...){
    va_list argumentList;
    va_start(argumentList, format);
    NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                   arguments:argumentList];
    va_end(argumentList);
    [[HRLoger loger] addText:text];
}

void HRErrorLog(NSError * error,NSString* format,...){
    if (error) {
        va_list argumentList;
        va_start(argumentList, format);
        NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                       arguments:argumentList];
        va_end(argumentList);
        [[HRLoger loger] addText:text];
    }
}

void HRSenderErrorLog(id sender,NSError * error,NSString* format,...){
    if (error) {
        va_list argumentList;
        va_start(argumentList, format);
        NSString* text = [[NSMutableString alloc] initWithFormat:format
                                                       arguments:argumentList];
        va_end(argumentList);
        if (sender) {
            text = [NSString stringWithFormat:@"<ERROR IN %@>:<%@>",NSStringFromClass(sender),text];
        }
        [[HRLoger loger] addText:text];
    }
}

@interface HRLogSession ()

@property (nonatomic, strong, readwrite) NSString* localPath;
@property (nonatomic, strong) NSFileHandle* fileHandle;

@end

@implementation HRLogSession

- (dispatch_queue_t) workQueue{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("HRLogSession.workQueue", NULL);
    });
    return queue;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _date = [NSDate date];
        _localPath = [[[_date description] stringByReplacingOccurrencesOfString:@":" withString:@"|"] stringByAppendingString:@".log"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_date forKey:@"_date"];
    [aCoder encodeObject:_localPath forKey:@"_localPath"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _localPath = [aDecoder decodeObjectForKey:@"_localPath"];
        _date = [aDecoder decodeObjectForKey:@"_date"];
    }
    return self;
}

- (NSData *)log {
    __block NSData* result = [NSData new];
    __weak typeof(self) weakSelf = self;
    dispatch_sync([self workQueue],^{
        result = [NSData dataWithContentsOfFile:weakSelf.path];
    });
    return result;
}

- (NSString *)path {
    return [[[HRLoger loger] path] stringByAppendingPathComponent:_localPath];
}

- (NSFileHandle *)fileHandle {
    if (!_fileHandle) {
        [[NSFileManager defaultManager] createFileAtPath:self.path contents:nil attributes:nil];
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.path];
    }
    return _fileHandle;
}
- (void) addedInFile:(NSString*) text{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async([self workQueue], ^{
        [weakSelf.fileHandle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
        [weakSelf.fileHandle synchronizeFile];
    });
    
    if ([weakSelf.delegate respondsToSelector:@selector(logSession:appendSting:)]) {
        [weakSelf.delegate logSession:weakSelf appendSting:text];
    }
}

@end

@implementation HRLoger

+ (instancetype) loger{
    static HRLoger* loger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loger = [HRLoger new];
        
    });
    return loger;
}

- (NSString *)startSymbol {
    if (!_startSymbol) {
        return @"";
    }
    return _startSymbol;
}

- (NSString *)path {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = paths.firstObject; // Get documents folder
    NSString* dataPath = [documentsDirectory stringByAppendingPathComponent:@"/HR_LOG"];
    return dataPath;
}

-(void) addFolder {
    NSError* error = nil;
    NSString* dataPath = self.path;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath] )
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
}

- (void) load {
    NSString* file = [self.path stringByAppendingPathComponent:@"logs"];
    NSData* data = [NSData dataWithContentsOfFile:file];
    NSMutableArray<HRLogSession*>* list = [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
    if (!list) {
        list = [NSMutableArray new];
    }
    while (list.count > self.numberOfSessionForSave) {
        NSError* error;
        [[NSFileManager defaultManager] removeItemAtPath:list.firstObject.path
                                                   error:&error];
        [list removeObjectAtIndex:0];
    }
    _lastSessions = [list copy];
    [list addObject:_currentSession];
    [[NSKeyedArchiver archivedDataWithRootObject:list] writeToFile:file atomically:YES];
}

- (instancetype)init {
    self = [super init];
    if (self){
        [self addFolder];
        _numberOfSessionForSave = 10;
        _printInNSLog = YES;
        _addNewRow = YES;
    }
    return self;
}

- (void)startSesstion {
    _currentSession = [HRLogSession new];
    [self load];
}

- (void) addText:(NSString*) text{
    if (self.printInNSLog) {
        NSLog(@"%@",text);
    }
    if (!self.notAddDateInLog) {
        text = [[[NSDate date] description] stringByAppendingString:text];
    }
    if (self.addNewRow) {
        text = [text stringByAppendingString:@"\n"];
    }
    text = [self.startSymbol stringByAppendingString:text];
    [self.currentSession addedInFile:text];
    
}

@end
