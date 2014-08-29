//
//  ContentViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-23.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ViewController.h"

@interface ContentViewController : ViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    UIAlertView * postAlertView ;

}
@property (nonatomic,retain) NSString *starName;
@property (nonatomic,assign) int starIndex;
@property (nonatomic,retain) NSMutableArray *replyArray;
@property (nonatomic,retain) UIImageView *footView;
@property (nonatomic,assign) int postId;
@property (nonatomic,retain) NSMutableArray *praiseArray;
@property (nonatomic,assign) int praiseNum;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *postTitle;
@property (nonatomic,retain) NSString *petNameTxt;
@property (nonatomic,retain) NSString *petPortrait;
@property (nonatomic,retain) NSString *usrPortrait;
@property (nonatomic,retain) NSString *image;
@property (nonatomic,retain) UIImageView *contImg;
@property (nonatomic,assign) int usrId;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *region;
@property (nonatomic,retain) NSString *breed;
@property (nonatomic,assign) int petSex;
@property (nonatomic,retain) NSString *timeTxt;
@property (nonatomic,assign) int replyParentId;
@property (nonatomic,assign) BOOL isPersonalPost;

@property (nonatomic,retain) NSMutableArray *idsArray;
@property (nonatomic,retain) NSMutableArray *customerNameArray;
@property (nonatomic,retain) NSMutableArray *customerPortraitArray;
@property (nonatomic,retain) NSMutableArray *petNames;
@property (nonatomic,retain) NSMutableArray *petAgeArray;
@property (nonatomic,retain) NSMutableArray *contents;
@property (nonatomic,retain) NSMutableArray *pics;
@property (nonatomic,retain) NSMutableArray *createTimeArray;
@property (nonatomic,retain) NSMutableArray *childArray;
@property (nonatomic,assign) int postUserId;
@property (nonatomic,retain) NSDictionary *myPortrait;

@property (nonatomic,retain) UITableView *table;
@property (nonatomic,assign) BOOL isReplyCommentary;

@property (nonatomic,retain) NSData *fileData;
@property (nonatomic,retain) UIImage *img;
@property (nonatomic,retain) NSString *filePath;
@property (nonatomic,retain) NSMutableArray *photoes;
@property (nonatomic,assign) int addPhotoTimes;
@property (nonatomic,assign) int n;

//-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
