//
//  PersonalInfoView.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//
//帖子主人的信息
#import <UIKit/UIKit.h>
#import "GetUserData.h"

@interface PersonalInfoView : UIView<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *sv;
@property (nonatomic,retain) UIScrollView *svImg;
@property (nonatomic,retain) UIPageControl *pc;
@property (nonatomic,assign) int svImgCurrentPage;
@property (nonatomic,assign) bool scrollLeftOrRight;
@property (nonatomic,assign) int userId;
@property (nonatomic,retain) NSString *starName;
@property (nonatomic,assign) int starIndex;
@property (nonatomic,retain) NSMutableDictionary *dic;

@property (nonatomic,retain) UILabel *pNameLbl;
@property (nonatomic,retain) UILabel *fNumLbl;

@end
