//
//  FotoWallViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-27.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"

@interface FotoWallViewController : ViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL isFromeMainPage;

@property (nonatomic,assign) int userId;
@property (nonatomic,retain) NSMutableDictionary *fotoDic;

@property (nonatomic,retain) NSString *starName;
@property (nonatomic,assign) int starIndex;
@end
