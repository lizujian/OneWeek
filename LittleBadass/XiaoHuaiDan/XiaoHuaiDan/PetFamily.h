//
//  PetFamily.h
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetFamily : UIView<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * myTable;
    NSMutableArray * dataArray;
    NSMutableArray * sectionArray;
}

@property (nonatomic,copy)NSString * petName;
//选择猫或者狗的种类
@property (nonatomic,assign)id delegate;
@property (nonatomic,assign)SEL method;

- (id)initWithFrame:(CGRect)frame name:(NSString *)petsName;

@end
