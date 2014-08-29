//
//  FeedbackViewController.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//
//反馈意见
#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) UITextView *feedback;
@end
