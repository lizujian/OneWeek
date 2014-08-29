//
//  ALLAlert.m
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-13.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ALLAlert.h"

@implementation ALLAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)createAlertViewWithMessage:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
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
