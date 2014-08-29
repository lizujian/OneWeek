//
//  GetReply.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-10.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetReply.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetReply

-(NSDictionary *)getReply:(int)postId
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/comment?post_id=%d&page=&pagesize=&key=%@&secret=%@",postId,appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/comment?post_id=%d&page=&pagesize=&key=%@&sign=%@",postId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSDictionary *replyDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    NSLog(@"replyDic:%@",replyDic);
    
    [url release];
    [request release];
    [error release];
    
    return replyDic;
    
}
@end
