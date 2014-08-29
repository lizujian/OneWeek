//
//  MainPageView.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/28.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageCell.h"
#import "ViewController.h"
#import "FirstTableViewCell.h"
#import "EGORefreshTableHeaderView.h"
@interface MainPageView : UIView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UIImageView * backImg;
    NSMutableArray * dataArray;
    UITableView * myTableView;
    
    int num1;//爆照星
    int num2;//喵喵星
    int num3;//吐槽星
    int num4;//汪汪星
    int num5;//代养星
    //下拉刷新视图
    EGORefreshTableHeaderView * refreshView;

}
@property (nonatomic,retain)UIImageView * backImg;
@property (nonatomic,retain) FirstTableViewCell *fc;
@property (nonatomic,retain) MainPageCell *mpc;
@property (nonatomic,retain) NSDictionary *postDic;
@property (nonatomic,retain) NSMutableArray * postArray;
//@property (nonatomic,retain) UITableView *table;

@property (nonatomic,retain) NSMutableArray *customerIdArray;
@property (nonatomic,retain) NSMutableArray *customerNameArray;
@property (nonatomic,retain) NSMutableArray *customerPortraitArray;
@property (nonatomic,retain) NSMutableArray *titleArray;
@property (nonatomic,retain) NSMutableArray *contentArray;
@property (nonatomic,retain) NSMutableArray *praiseNumArray;
@property (nonatomic,retain) NSMutableArray *collectNumArray;
@property (nonatomic,retain) NSMutableArray *totalArray;
@property (nonatomic,retain) NSMutableArray *moderatorsIdArray;
@property (nonatomic,retain) NSMutableDictionary *dic;

@property (nonatomic,assign) int requestTimes;
@property (nonatomic,assign) BOOL isLoading;
////存储当前页码的数据（用于实现翻页功能）
//@property (nonatomic,retain) NSMutableArray * curPageArray;

@end
