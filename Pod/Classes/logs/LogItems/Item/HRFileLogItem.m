//
//  HRFileLogItem.m
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRFileLogItem.h"
#import "HRCodingSupprotDefine.h"

NSString* const kHRImageLogItemStoragePath = @"/hrlog/storage";

@interface HRFileLogItem ()

@property (nonatomic,strong) NSString* filePath;

@end

@implementation HRFileLogItem

+ (void)clearStorage {
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:kHRImageLogItemStoragePath
                                               error:&error];
    if (error) {
        NSLog(@"HRImageLogItem  <%@>" ,error);
    }
}

- (instancetype) initWithData:(NSData *)data name:(NSString *)name {
    self = [super initWithName:name];
    if (self) {
        _filePath = [HRFileLogItem pathForName:[HRFileLogItem nextName]];
        [self saveData:data inPath:_filePath];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSData* data = nil;
        _filePath = [HRFileLogItem pathForName:[HRFileLogItem nextName]];
        HRLoadDecodeObjectIvar(data);
        [self saveData:data inPath:_filePath];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    NSData* data = self.data;
    HRSaveEncodeObjectIvar(data);
}

- (NSData *)data {
    return [self dataFromPath:self.filePath];
}


#pragma mark - private

- (void) saveData:(NSData*) data inPath:(NSString*) path{
    [data writeToFile:path atomically:YES];
}

- (NSData*) dataFromPath:(NSString*) path {
    return [[NSData alloc] initWithContentsOfFile:path];
}

+ (NSString*) nextName{
    static NSInteger numberOfImage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberOfImage = 0;
    });
    numberOfImage++;
    return [NSString stringWithFormat:@"image%ld",(long)numberOfImage];
}

+ (NSString*) pathForName:(NSString*) name{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:kHRImageLogItemStoragePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath] )
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    if (error) {
        NSLog(@"HRImageLogItem  <%@>" ,error);
    }
    return [dataPath stringByAppendingPathExtension:name];
}

@end
