//
//  HRLog.h
//  Pods
//
//  Created by Alexander Shipin on 21/02/2017.
//
//

#ifndef HRLog_h
#define HRLog_h

#define HRPositionString [NSString stringWithFormat:@"<FILE '%s', ROW %d>",__FILE__,__LINE__]
#define HRCheckErrorLog(error) if (error) {\
HRLog(@"<ERROR IN %@:\n%@",HRPositionString,error);\
\
};


void HRLog(NSString* format,...);
void HRErrorLog(NSError * error,NSString* format,...);
void HRSenderErrorLog(id sender,NSError * error,NSString* format,...);

#endif /* HRLog_h */
