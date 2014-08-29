//
//  DottedLine.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-25.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "DottedLine.h"

@implementation DottedLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor);
    float lengths[] = {2,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0.0);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextClosePath(context);
    
    
}

@end
