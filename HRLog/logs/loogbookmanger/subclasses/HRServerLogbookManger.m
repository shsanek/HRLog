//
//  HRServerLogbookManger.m
//  Pods
//
//  Created by Alexander Shipin on 12/04/16.
//
//

#import "HRServerLogbookManger.h"
#import "HRDeveloperLogerMangerKey.h"

@interface HRServerLogbookManger()

@end


@implementation HRServerLogbookManger

- (void) readNewData:(NSData*) data{
    NSDictionary* dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (dic[kHRLogerDeveloperLogKey]) {
        [self log:dic[kHRLogerDeveloperLogKey]];
    }
    if (dic[kHRLogerDeveloperEndLogKey]) {
        [self endLog];
    }
    if (dic[kHRLogerDeveloperBeginLogKey]) {
        [self beginLog:dic[kHRLogerDeveloperBeginLogKey]];
    }
}

@end
