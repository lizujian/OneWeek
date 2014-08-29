//
//  ScreenView.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-29.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetFamily.h"
@interface ScreenView : UIView<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITextField *breed;//家族
}
@property (nonatomic,retain) PetFamily * pets;

@property (nonatomic,retain) UITableView *table;
@property (nonatomic,assign) int sexIndex;
@property (nonatomic,assign) int petSexIndex;
@property (nonatomic,retain) NSString *selectedBreed;
@property (nonatomic,retain) NSString *selectedRace;
@property (nonatomic,retain) NSString *num;
@property (nonatomic,retain) UIView *back;
@property (nonatomic,retain) UIView *backView;
@property (nonatomic,retain) NSArray *arr;
@property (nonatomic,assign) int distance;

@end
