//
//  HRAssertDefine.h
//  HRViewModel
//
//  Created by shipin alex on 29/05/15.
//  Copyright (c) 2015 HR. All rights reserved.
//

#ifndef HRViewModel_HRDefineHeard_h
#define HRViewModel_HRDefineHeard_h

#define HRClassAssert(wating,curent) NSAssert([wating class] == [curent class] || [[curent class] isSubclassOfClass:[wating class]] , @"%@ not subclass %@",@#curent,@#wating)
#define HRProtocolAssert(wating,curent)  NSAssert([[curent class] conformsToProtocol:@protocol(wating)],@"not support wating protocol ");

#endif
