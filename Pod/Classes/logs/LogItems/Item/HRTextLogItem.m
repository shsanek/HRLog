//
//  HRTextLogItem.m
//  HRLog
//
//  Created by Alexander Shipin on 22/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRTextLogItem.h"
#import "HRCodingSupprotDefine.h"

@implementation HRTextLogItem

- (instancetype)initWitfFormat:(NSString *)format, ... {
    self = [super initWithName:@""];
    if (self) {
        va_list argumentList;
        va_start(argumentList, format);
        _text = [[NSMutableString alloc] initWithFormat:format
                                              arguments:argumentList];
        va_end(argumentList);
    }
    return self;
}


- (instancetype)initWitfName:(NSString *)name format:(NSString *)format, ...{
    self = [super initWithName:name];
    if (self) {
        va_list argumentList;
        va_start(argumentList, format);
        _text = [[NSMutableString alloc] initWithFormat:format
                                              arguments:argumentList];
        va_end(argumentList);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        HRLoadDecodeObjectIvar(_text);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    HRSaveEncodeObjectIvar(_text);
}

- (NSString *)textRepresentation{
    return self.text;
}

@end
