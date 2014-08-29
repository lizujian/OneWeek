//
//  CustomPinAnnotation.h
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CustomCalloutAnnotation.h"

@interface CustomPinAnnotation : MKPlacemark<MKAnnotation> {
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (nonatomic,retain) CustomCalloutAnnotation *calloutAnnotation;

@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

- (id)initWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon;

@end
