//
//  SettingViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerView.h"

@interface SettingViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,updateLabel,UITextFieldDelegate,UIActionSheetDelegate>
{
        
        UIImageView * headImage;//头像
        BOOL iconISchanged;
        NSString * userIconPath;
        UITableView * myTableView;
    NSMutableArray * dataArray;
    UITextField * location;
}
//@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) NSString *loc;
@property (nonatomic,assign) int sexIndex;
@property (nonatomic, strong) CityPickerView *cityPick;

@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain) NSString *peoName;

@end
