//
//  FansViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-27.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"

@interface FansViewController : ViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) int userId;
@property (nonatomic,retain) NSMutableDictionary *fansDic;

@property (nonatomic,retain) NSString *starName;
@property (nonatomic,assign) int starIndex;
@property (nonatomic,assign) BOOL isFromeMainPage;
@end
