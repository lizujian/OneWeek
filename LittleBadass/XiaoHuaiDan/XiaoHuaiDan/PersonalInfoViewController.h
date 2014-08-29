//
//  PersonalInfoViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-24.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"
#import "GetUserData.h"
#import "PersonalInfoView.h"

@interface PersonalInfoViewController : ViewController<UIScrollViewDelegate,PassValueDelegate>

@property (nonatomic,retain) UIScrollView *sv;
@property (nonatomic,retain) UIScrollView *svImg;
@property (nonatomic,retain) UIPageControl *pc;
@property (nonatomic,assign) int svImgCurrentPage;
@property (nonatomic,assign) bool scrollLeftOrRight;
@property (nonatomic,assign) int userId;
@property (nonatomic,retain) NSString *starName;
@property (nonatomic,assign) int starIndex;
@property (nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain) NSString *usrPortrait;
@property (nonatomic,retain) NSString *petPortrait;
@property (nonatomic,retain) NSString *contentTxt;
@property (nonatomic,retain) NSString *breed;
@property (nonatomic,retain) NSString *race;
@property (nonatomic,assign) int sexIndex;
@property (nonatomic,assign) BOOL isFromPost;
@property (nonatomic,assign) BOOL isFromMain;
@property (nonatomic,retain) NSString *whereFrom;

@property (nonatomic,retain) UILabel *pNameLbl;
@property (nonatomic,retain) UILabel *fNumLbl;

@property (nonatomic,retain) PersonalInfoView *per;

- (void)setValue:(NSMutableDictionary *)value;

@end
