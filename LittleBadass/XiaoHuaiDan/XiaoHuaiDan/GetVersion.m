//
//  GetVersion.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetVersion.h"

@implementation GetVersion
@synthesize authDic;

-(void)getVersion
{
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cmobile.petplanetzone.com/1.0"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *versionDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSString *versionInfo = [versionDic objectForKey:@"ok"];
    
    NSLog(@"Version返回的内容：%@", versionInfo);
}

-(void)getAuth
{
    //prepar request
    NSString *urlString = [NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/auth"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/Json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.authDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
//        NSLog(@"Response: %@",authDic);
        
    }
    [request release];
    [error release];
    
}



-(void)dealloc
{
    [authDic release];
    [super dealloc];
}
@end
