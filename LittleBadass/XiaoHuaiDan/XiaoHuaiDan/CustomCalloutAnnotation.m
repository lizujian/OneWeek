//
//  CustomCalloutAnnotation.m
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import "CustomCalloutAnnotation.h"

@implementation CustomCalloutAnnotation

- (id)initWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon {
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}


@end
