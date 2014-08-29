//
//  GetEssencePost.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-7.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetEssencePost.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetEssencePost
@synthesize receivedData,essencePostDic,essnceArray;

-(void)getEssencePost:(int)page
{
    NSLog(@"------%d",page);
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/essencePost?page=%d&pagesize=4&key=%@&secret=%@",page,appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/essencePost?page=%d&pagesize=4&key=%@&sign=%@",page,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
  
    //建立网络连接NSURLConnection，并设置其代理
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.essencePostDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"－－－－－－－－－%@",self.essencePostDic);
    self.essnceArray = [self.essencePostDic objectForKey:@"post"];
    [error release];
    [url release];
    [request release];

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
//    self.essencePostDic = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:&error];
//    
////    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
////    appDelegate.postDic = [NSDictionary dictionaryWithDictionary:self.essencePostDic];
//    
////    NSLog(@"essencePostDic:%@",self.essencePostDic);
//    
//    [self.essencePostDic writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"post"] atomically:YES];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTPOST" object:self.essencePostDic];
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
    [essencePostDic release];
    [receivedData release];
    [essnceArray release];
    [super dealloc];
}
@end
