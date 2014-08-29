//
//  CustomCalloutView.h
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CustomCalloutView : MKAnnotationView {
    UIView *_contentView;
}

@property (nonatomic, retain) UIView *contentView;

@end
