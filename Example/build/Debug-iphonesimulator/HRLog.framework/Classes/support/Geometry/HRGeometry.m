//
//  HRGeometry.c
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#import "HRGeometry.h"

HRPoint HRMakePoint(float x,float y){
    HRPoint point = {x,y};
    return  point;
}
HRSize HRMakeSize(float width,float height){
    HRSize size = {width,height};
    return size;
}

HRRect HRMakeRect(float x,float y,float width,float height){
    HRPoint point = {x,y};
    HRSize size = {width,height};
    HRRect rect = {point,size};
    return rect;
}