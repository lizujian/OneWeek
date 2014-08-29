//
//  GetUserInfo.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/17.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetUserInfo.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation GetUserInfo
@synthesize userDataDic;

-(void)getUserInfo:(int)userId
{

    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/info/%d?key=%@&secret=%@",userId,appDelegate.key,appDelegate.secret];
    
    NSString *urlString = [NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/customer/info/%d?key=%@&sign=%@",userId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/Json"];
//    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.userDataDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"-------------userDataDic------------: %@",userDataDic);
        
    }
    [request release];
    [error release];
}

-(void)dealloc
{
    [userDataDic release];
    [super dealloc];
}

@end
