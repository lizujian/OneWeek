//
//  MapAnnotation.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate,title,subtitle,urlstring,picstring;

- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoordinate
{
    if (self = [super init]) coordinate = aCoordinate;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 51.0, 41.0)];
    [imageView setImage:[UIImage imageNamed:@"cat_coordinates.png"]];
    [self addSubview:imageView];
    
    return self;
}

-(void) dealloc
{
    self.title = nil;
    self.subtitle = nil;
    self.urlstring = nil;
    self.picstring = nil;
    [super dealloc];
}
@end
