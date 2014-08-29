//
//  PersonalCenterView.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/28.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostPetData.h"
@interface PersonalCenterView : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,RefreshUserCentrerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *background;
}

@property (nonatomic,retain) NSMutableDictionary *userInfoDic;
@property (nonatomic,retain) UIScrollView *sv;
//@property (nonatomic,retain) UIScrollView *svImg;
@property (nonatomic,retain) NSMutableArray *petsArr;
@property (nonatomic,retain)UIImage * backGroundImg;
@property (nonatomic,assign)BOOL bgChanged;//判断背景图片是否被替换
@end
