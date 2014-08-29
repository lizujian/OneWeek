//
//  PostViewController.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/5/31.
//  Copyright (c) 2014年 sch. All rights reserved.

//各种星球

#import <UIKit/UIKit.h>


@interface PostViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSString *titleName;
@property (nonatomic,assign) int tapTimes;
@property (nonatomic,retain) UIView *starsview;
@property (nonatomic,retain) NSMutableDictionary *postDic;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) UITextField *titleText;
@property (nonatomic,assign) int moderatorsId;
@property (nonatomic,assign) int requestTimes;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,retain) NSString *time;

@property (nonatomic,retain) NSMutableArray *postIdArray;
@property (nonatomic,retain) NSMutableArray *customerIdArray;
@property (nonatomic,retain) NSMutableArray *petNameArray;
@property (nonatomic,retain) NSMutableArray *petBirthArray;
@property (nonatomic,retain) NSMutableArray *petSexArray;
@property (nonatomic,retain) NSMutableArray *petBreedArray;
@property (nonatomic,retain) NSMutableArray *customerPortraitArray;
@property (nonatomic,retain) NSMutableArray *petPortraitArray;
@property (nonatomic,retain) NSMutableArray *titleArray;
@property (nonatomic,retain) NSMutableArray *contentArray;
@property (nonatomic,retain) NSMutableArray *praiseNumArray;
@property (nonatomic,retain) NSMutableArray *collectNumArray;
@property (nonatomic,retain) NSMutableArray *totalArray;
@property (nonatomic,retain) NSMutableArray *moderatorsIdArray;
@property (nonatomic,retain) NSMutableArray *picsArray;
@property (nonatomic,retain) NSMutableArray *createTimeArray;
@property (nonatomic,retain) NSMutableArray *regions;
@property (nonatomic,retain) NSMutableArray *timeArray;
@property (nonatomic,retain) NSMutableArray *praiseArray;
//@property (nonatomic,retain) NSMutableArray *childArray;

@end
