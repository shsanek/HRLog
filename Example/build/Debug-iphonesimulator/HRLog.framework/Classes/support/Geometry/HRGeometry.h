//
//  HRGeometry.h
//  HRLog
//
//  Created by Alexander Shipin on 24/02/16.
//  Copyright © 2016 Alexander Shipin. All rights reserved.
//

#include <stdio.h>

typedef struct {
    float x;
    float y;
}HRPoint;

typedef struct {
    float width;
    float height;
}HRSize;

typedef struct {
    HRPoint origin;
    HRSize size;
}HRRect;


HRPoint HRMakePoint(float x,float y);
HRSize HRMakeSize(float width,float height);
HRRect HRMakeRect(float x,float y,float width,float height);

