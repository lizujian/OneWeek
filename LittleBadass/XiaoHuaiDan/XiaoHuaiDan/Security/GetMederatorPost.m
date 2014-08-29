//
//  GetMederatorPost.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/7.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetMederatorPost.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetMederatorPost
@synthesize mederatorPostDic,receivedData,mederatorIndex;

-(void)getMederatorPost:(int)page
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/mederatorPost?moderators_id=%d&page=%d&pagesize=4&key=%@&secret=%@",self.mederatorIndex,page,appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/mederatorPost?moderators_id=%d&page=%d&pagesize=4&key=%@&sign=%@",self.mederatorIndex,page,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.mederatorPostDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    NSLog(@"mederatorPostDic:%@",self.mederatorPostDic);
    
    [url release];
    [request release];
    [error release];
    
}

//接收服务器回应时这个方法被调用

//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    NSLog(@"服务器响应");
//    self.receivedData = [NSMutableData  dataWithCapacity:5000];
//}
//
////接收到服务器传输数据的时候调用，此方法根据数据大小会执行若干次
//
//- (void)connection:(NSURLConnection *)connetion didReceiveData:(NSData *)data
//
//{
//    NSLog(@"服务器返回数据");
//    [self.receivedData appendData:data];
//    
//}
//
////数据传完之后调用此方法
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSError *error;
//    self.mederatorPostDic = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:&error];
//    
//    //    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
//    //    appDelegate.postDic = [NSDictionary dictionaryWithDictionary:self.essencePostDic];
//    
//    NSLog(@"mederatorPostDic:%@",self.mederatorPostDic);
//    
//    [self.mederatorPostDic writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"mederatorpost"] atomically:YES];
//    
////    [[NSNotificationCenter defaultCenter] postNotificationName:@"MEDERATORPOST" object:self.mederatorPostDic];
//}
//
////网络请求过程中，出现任何错误，如断网，连接超时等，会进入此方法
//
//- (void)connetion:(NSURLConnection *)connetion didFailWithError:(NSError *)error
//{
//    NSLog(@"%@", [error localizedDescription]);
//}

-(void)dealloc
{
    [mederatorPostDic release];
    [receivedData release];
    [super dealloc];
}

@end
