//
//  GetMyFans.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/18.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetMyFans.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetMyFans
@synthesize myFansDic;

-(void)getMyFans:(int)userId :(int)page
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/fans?customer_id=%d&page=%d&pagesize=5&key=%@&secret=%@",userId,page,appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/fans?customer_id=%d&page=%d&pagesize=5&key=%@&sign=%@",userId,page,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.myFansDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"－－－－－－－－－%@",self.myFansDic);
    
    [error release];
    [url release];
    [request release];
}

-(void)dealloc
{
    [myFansDic release];
    [super dealloc];
}
@end
