//
//  LogOut.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "LogOut.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation LogOut

-(void)logOut
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/logout?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/customer/logout?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSMutableDictionary *myPostDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"－－－－－－－－－%@",myPostDic);
    
    [error release];
    [url release];
    [request release];

}
@end
