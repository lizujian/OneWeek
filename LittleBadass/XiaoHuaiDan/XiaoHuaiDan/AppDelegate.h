//
//  AppDelegate.h
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-8.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic,retain) NSString *key;
@property (nonatomic,retain) NSString *secret;
@property (nonatomic,retain) NSDictionary *postDic;
@property (nonatomic,assign) BOOL isLogin;

@end
