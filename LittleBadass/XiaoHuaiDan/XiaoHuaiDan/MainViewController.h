//
//  MainViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-5-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewCell.h"
#import "MainPageCell.h"
#import "PostViewController.h"
#import "MainPageView.h"
#import "PersonalCenterView.h"
#import "MapView.h"


#define VIEW_FRAME_HEIGHT    self.view.frame.size.height
#define VIEW_FRAME_WIDTH     self.view.frame.size.width

@interface MainViewController : ViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,retain) UIImageView *imgview;
@property (nonatomic,retain) UIImageView *footView;
@property (nonatomic,retain) MainPageView *main;
@property (nonatomic,retain) PersonalCenterView *per;
@property (nonatomic,retain) UIButton *mainpageBtn;
@property (nonatomic,retain) UIButton *lbsBtn;
@property (nonatomic,retain) UIButton *userBtn;
@property (nonatomic,retain) MapView *map;
-(void)showPersonalCenter:(UIButton *)btn;
@end
