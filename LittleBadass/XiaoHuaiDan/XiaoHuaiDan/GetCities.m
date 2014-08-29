//
//  GetCities.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-4.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetCities.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetCities
@synthesize receivedData,citiesArray,citiyId,citiesDic,regionsArray,regionsAndCitiesDic;

-(void)getCities
{
    self.citiesArray = [NSMutableArray arrayWithCapacity:0];
    
    self.regionsAndCitiesDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];

        
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/region?parentid=%@&key=%@&secret=%@",self.citiyId,appDelegate.key,appDelegate.secret];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/region?parentid=%@&key=%@&sign=%@",self.citiyId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    [url release];
    [request release];
    
}

//接收服务器回应时这个方法被调用

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [NSMutableData  dataWithCapacity:5000];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小会执行若干次

- (void)connection:(NSURLConnection *)connetion didReceiveData:(NSData *)data

{
    [self.receivedData appendData:data];
    
}

//数据传完之后调用此方法

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    self.citiesDic = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:&error];

    for (int i = 0; i < [[self.citiesDic objectForKey:@"regions"] count]; i++)
    {
        [citiesArray addObject:[[[self.citiesDic objectForKey:@"regions"] objectAtIndex:i]objectForKey:@"name"]];
    }
    
}

//网络请求过程中，出现任何错误，如断网，连接超时等，会进入此方法
- (void)connetion:(NSURLConnection *)connetion didFailWithError:(NSError *)error
{
    NSLog(@"出错啦erro");
    NSLog(@"%@", [error localizedDescription]);
}

-(void)dealloc
{
    [regionsArray release];
    [citiesDic release];
    [citiyId release];
    [citiesArray release];
    [receivedData release];
    [super dealloc];
}
@end
