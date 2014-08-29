//
//  CustomCalloutView.m
//  CustomCalloutViewDemo
//
//  Created by wusj on 13-7-12.
//  Copyright (c) 2013年 DoubleMan. All rights reserved.
//

#import "CustomCalloutView.h"
// 修改此值 可以改变泡泡下面三角的大小
#define Arror_height 10

#define Title_font 18
#define Subtitle_font 13

@implementation CustomCalloutView

@synthesize contentView = _contentView;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
//        self.frame = CGRectMake(0, 0, 159, 79);
//        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 2, 159, 79)];
//        [self addSubview:self.contentView];
        
        UIView *view = [self createContentView];
        [self addSubview:view];
    }
    
    return self;
}

// (230, 46)
- (UIView *)createContentView {
    UIImageView *viewImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 159, 79)];
    [viewImg setImage:[UIImage imageNamed:@"fish.png"]];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40.0, 40.0)];
    [headImage setBackgroundColor:[UIColor lightGrayColor]];
    headImage.layer.cornerRadius = headImage.bounds.size.width/2;
    [viewImg addSubview:headImage];
    
    UILabel *petName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 30, 20)];
    petName.text = @"Mini";
    petName.backgroundColor = [UIColor clearColor];
    petName.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    petName.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    [viewImg addSubview:petName];
    
    UILabel *var = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 30, 20)];
    var.text = @"泰迪";
//    var.backgroundColor = [UIColor blackColor];
    var.font = [UIFont systemFontOfSize:10];
    var.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [viewImg addSubview:var];
    
    return viewImg;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context {
    
    
    CGRect rrect = self.bounds;
    CGFloat radius = 8.0;
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    
    CGFloat maxx = CGRectGetMaxX(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect)-Arror_height;
    // 画CalloutView下面的小三角
    CGContextMoveToPoint(context, midx + Arror_height, maxy);
    CGContextAddLineToPoint(context, midx, maxy + Arror_height);
    CGContextAddLineToPoint(context, midx - Arror_height, maxy);
    // 
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
