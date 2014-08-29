//
//  CustomAnnotationView.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-2.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //大头针的图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 51.0, 41.0)];
        [imageView setImage:[UIImage imageNamed:@"cat_coordinates.png"]];
        [self addSubview:imageView];
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 30.0, 30.0)];
        [headImage setBackgroundColor:[UIColor lightGrayColor]];
        headImage.layer.cornerRadius = headImage.bounds.size.width/2;
        [imageView addSubview:headImage];
    }
    
    return self;
}



- (void)dealloc
{
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
