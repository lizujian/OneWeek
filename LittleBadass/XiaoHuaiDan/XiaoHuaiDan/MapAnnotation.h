//
//  MapAnnotation.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : MKAnnotationView
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *urlstring;
    NSString *picstring;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *urlstring;
@property (nonatomic, retain) NSString *picstring;

@end
