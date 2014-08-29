//
//  EditViewController.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/22.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,retain) NSString *starName;
@property (nonatomic,retain) UIImageView *footImgOne;
@property (nonatomic,retain) UIImageView *footImgTwo;
@property (nonatomic,retain) UIImageView *footImgThr;
@property (nonatomic,retain) UIImageView *footImgFou;
@property (nonatomic,retain) UIImageView *footImgFiv;
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,assign) int starIndex;
@property (nonatomic,assign) int selectedStar;
@property (nonatomic,retain) UITextField *postTitle;
@property (nonatomic,retain) UITextView *postContent;
@property (nonatomic,retain) NSMutableArray *picsArray;

@property (nonatomic,retain) NSData *fileData;
@property (nonatomic,retain) UIImage *img;
@property (nonatomic,retain) NSString *filePath;
@property (nonatomic,retain) NSMutableArray *photoes;
@property (nonatomic,assign) int addPhotoTimes;
@property (nonatomic,assign) int n;
@property (nonatomic,assign) BOOL isTitle;
@end
