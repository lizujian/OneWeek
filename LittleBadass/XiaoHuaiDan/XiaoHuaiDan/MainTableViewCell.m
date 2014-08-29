//
//  MainTableViewCell.m
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-5.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_Img1 release];
    [_Img2 release];
    [_Img3 release];
    
    [_Name release];
    [_Online release];
    [_Title release];
    [_Content release];
    [_Star release];
    [_Icon release];
    [super dealloc];
}
@end
