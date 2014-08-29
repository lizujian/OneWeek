//
//  ThirdPlatformViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdPlatformViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString * QQName;
    NSString * RenName;
    NSString * SinaName;
    
    NSString * QQUid;
    NSString * RenUid;
    NSString * SinaUid;
    
}
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,assign) BOOL isLogWithQQ;
@property (nonatomic,assign) BOOL isLogWithBaidu;
@property (nonatomic,assign) BOOL isLogWithRenren;
@property (nonatomic,assign) BOOL isLogWithSina;
@end

