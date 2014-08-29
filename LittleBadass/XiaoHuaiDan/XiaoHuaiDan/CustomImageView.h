//
//  CustomImageView.h
//  SnsDemo
//
//  Created by qianfeng on 13-9-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView

//只能用assign
@property (nonatomic,assign) id delegate;    //回调对象
@property (nonatomic,assign) SEL method;    //回调方法

@end
