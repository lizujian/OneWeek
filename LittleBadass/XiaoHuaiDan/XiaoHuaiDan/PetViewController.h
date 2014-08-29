//
//  PetViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetFamily.h"
@interface PetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *petImage;//宠物种族
    UITextField *birthdayText;//宠物出生日期
    UITextField * petFamilyName;//宠物家族名
//    NSString * txtName;
//    UITableView * petTableView;
//    NSMutableArray * dataArray;
}
@property (nonatomic,retain) PetFamily * pets;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) UITextField *name;
@property (nonatomic,assign) int sexIndex;
@property (nonatomic,retain) NSString *petName;
@property (nonatomic,retain) NSString *selectedBreed;
@property (nonatomic,retain) NSString *selectedRace;
@property (nonatomic,retain) UIDatePicker *pick;
@property (nonatomic,retain) NSString *birthday;
@property (nonatomic,retain) NSString *portrait;
@property (nonatomic,retain) UIImageView *editBack;
@property (nonatomic,retain) UIButton *petBtn;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,retain) NSData *fileData;
@property (nonatomic,retain) UIImage *img;
@property (nonatomic,retain) NSString *filePath;


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
