//
//  MainPageCell.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-5-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic,retain) UIView *sideView;
@property (nonatomic,retain) UIImageView *sectionImgView;
@property (nonatomic,retain) UIImageView *conView;
@property (nonatomic,retain) UITextField *titleText;
@property (nonatomic,retain) UITextView *contentText;
@property (nonatomic,retain) UIImageView *userImgView;
@property (nonatomic,retain) UITextField *userNameText;
@property (nonatomic,retain) UITextField *numText;

@end
