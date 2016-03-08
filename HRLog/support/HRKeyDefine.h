//
//  HRKeyDefine.h
//  HRViewModel
//
//  Created by shipin alex on 29/05/15.
//  Copyright (c) 2015 HR. All rights reserved.
//

#ifndef HRViewModel_HRKeyDefine_h
#define HRViewModel_HRKeyDefine_h

#define HRIntefaceKey(key) extern NSString* const key

#define HRImplementationKey(key)  NSString* const key = @#key
#define HRImplementationKeyWithValue(key,value)  NSString* const key = value

#define HRIsEqualToClass(wating,curent) ([wating class] == [curent class] || [[curent class] isSubclassOfClass:[wating class]])

#endif
