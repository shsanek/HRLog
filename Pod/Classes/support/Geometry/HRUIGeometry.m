//
//  HRUIGeometry.m
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRUIGeometry.h"

HRPoint HRMakePointWithCGPoint(CGPoint point){
    return HRMakePoint(point.x,
                       point.y);
}

HRSize HRMakeSizeWithCGSize(CGSize size){
    return HRMakeSize(size.width,
                      size.height);
}

HRRect HRMakeRectWithCGRect(CGRect rect){
    return HRMakeRect(rect.origin.x,
                      rect.origin.y,
                      rect.size.width,
                      rect.size.height);
}
