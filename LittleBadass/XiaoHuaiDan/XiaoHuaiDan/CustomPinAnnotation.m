//
//  CustomPinAnnotation.m
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import "CustomPinAnnotation.h"

@implementation CustomPinAnnotation

@synthesize coordinate = _coordinate;
@synthesize calloutAnnotation;

- (id)initWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon {
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
    }
    
    return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate addressDictionary:(NSDictionary *)addressDictionary {
	
	if ((self = [super initWithCoordinate:coordinate addressDictionary:addressDictionary])) {
		self.coordinate = coordinate;
	}
	return self;
}


- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

-(void)dealloc
{
    [calloutAnnotation release];
    [super dealloc];
}

@end
