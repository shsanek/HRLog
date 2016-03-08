//
//  HRCodingSupprotDefine.h
//  HRViewModel
//
//  Created by shipin alex on 29/05/15.
//  Copyright (c) 2015 HR. All rights reserved.
//

#ifndef HRViewModel_HRCodingSupprotDefine_h
#define HRViewModel_HRCodingSupprotDefine_h

#define HRLoadDecodeObjectIvar(name)   name = [aDecoder decodeObjectForKey:@ # name]

#define HRLoadDecodeObjectMutableArrayIvar(name)   {name = [[aDecoder decodeObjectForKey:@ # name] mutableCopy];\
name = name?name:[NSMutableArray new];}
#define HRLoadDecodeObjectMutableDictionaryIvar(name)   {name = [[aDecoder decodeObjectForKey:@ # name] mutableCopy];\
name = name?name:[NSMutableDictionary new];}

#define HRLoadDecodeIntegerIvar(name)   name = [[aDecoder decodeObjectForKey:@ # name] integerValue]
#define HRLoadDecodeEnumIvar(name)   name = [[aDecoder decodeObjectForKey:@ # name] intValue]
#define HRLoadDecodeFloatIvar(name)   name = [[aDecoder decodeObjectForKey:@ # name] doubleValue]

#define HRSaveEncodeObjectIvar(name)  [aCoder encodeObject: name forKey:@# name ]
#define HRSaveEncodeIntegerIvar(name)  [aCoder encodeObject:@( name )forKey:@# name ]
#define HRSaveEncodeFloatIvar(name)  [aCoder encodeObject:@((double)name) forKey:@# name ]

#endif
