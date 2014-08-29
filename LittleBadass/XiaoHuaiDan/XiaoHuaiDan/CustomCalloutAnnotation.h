//
//  CustomCalloutAnnotation.h
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

- (id)initWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon;

@end
