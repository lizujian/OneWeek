//
//  Table.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-1.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Table : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSArray *array;
@end
