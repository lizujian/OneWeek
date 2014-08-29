//
//  MainTableViewCell.h
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-5.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"
@interface MainTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet CustomImageView *Star;
@property (retain, nonatomic) IBOutlet UIImageView *Img1;
@property (retain, nonatomic) IBOutlet UIImageView *Img2;
@property (retain, nonatomic) IBOutlet UIImageView *Img3;
@property (retain, nonatomic) IBOutlet CustomImageView *Icon;
@property (retain, nonatomic) IBOutlet UILabel *Name;
@property (retain, nonatomic) IBOutlet UILabel *Online;
@property (retain, nonatomic) IBOutlet UILabel *Title;

@property (retain, nonatomic) IBOutlet UILabel *Content;
@end
