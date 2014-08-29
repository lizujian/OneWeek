//
//  AppDelegate.m
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-8.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "MainViewController.h"

#import "GetVersion.h"
#import "GetEssencePost.h"
#import "Login.h"

#import <ShareSDK/ShareSDK.h>
#import <RennSDK/RennSDK.h>
#import <QZoneConnection/QZoneConnection.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <SinaWeiboConnection/SinaWeiboConnection.h>

@implementation AppDelegate
@synthesize key,secret,postDic,isLogin;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    
    [key release];
    [secret release];
    [postDic release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:3];

    //注册share SDK平台
    [ShareSDK registerApp:@"27ed057481e3"];
    //sina weibo SSO
    [ShareSDK connectSinaWeiboWithAppKey:@"4006802425"
                               appSecret:@"e01174245a78429d26687514508cd9f5"
                             redirectUri:@"http://weibo.petplanetzone.com"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK connectSinaWeiboWithAppKey:@"4006802425" appSecret:@"e01174245a78429d26687514508cd9f5" redirectUri:@"http://weibo.petplanetzone.com" weiboSDKCls:[WeiboSDK class]];
    
    //Qzone SSO
    [ShareSDK connectQZoneWithAppKey:@"101142853"
                           appSecret:@"163906f1f85bb73c8024a806119feaff"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //RenRen SSo
    //RenRen share
    [ShareSDK connectRenRenWithAppId:@"226427" appKey:@"fc5b8aed373c4c27a05b712acba0f8c3" appSecret:@"f29df781abdd4f49beca5a2194676ca4" renrenClientClass:[RennClient class]];
    
    //WeiXin share
    [ShareSDK connectWeChatTimelineWithAppId:@"wx2176ca814deb6ceb" wechatCls:[WXApi class]];
    [ShareSDK importWeChatClass:[WXApi class]];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    //===============真机路径=================
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *infoPath = [docDir stringByAppendingPathComponent:@"info"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        
        GetVersion *gv = [[GetVersion alloc] init];
        [gv getVersion];
        [gv getAuth];
        [gv.authDic writeToFile:infoPath atomically:YES];
        self.key = [gv.authDic objectForKey:@"key"];
        self.secret = [gv.authDic objectForKey:@"secret"];
        
        [gv release];
        
        NSLog(@"Web key:%@,secret:%@",self.key,self.secret);
        
    }else{
        
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:infoPath];
        self.key = [dic objectForKey:@"key"];
        self.secret = [dic objectForKey:@"secret"];
        
        [dic release];
        
        NSLog(@"File key:%@,secret:%@",self.key,self.secret);
        
    }

    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
//    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    
    self.viewController = [[[MainViewController alloc] init] autorelease];

    self.window.rootViewController = self.viewController;

    [self.window makeKeyAndVisible];
    
    
    Login *log = [[Login alloc] init];
    [log login];
    [log release];
    
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
    
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
