//
//  GetRegion.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-4.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetRegion.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation GetRegion
@synthesize regionDic,receivedData,regionsAndCitiesArray,gcities,regionsArr;

-(void)getRegion
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/region?parentid=&key=%@&secret=%@",appDelegate.key,appDelegate.secret];
//    [SecurityUtil encryptMD5String:md5Str];
    
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/region?parentid=&key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //建立网络连接NSURLConnection，并设置其代理
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    [url release];
    [request release];
    
    self.regionsAndCitiesArray = [NSMutableArray arrayWithCapacity:0];
    self.regionsArr = [NSMutableArray arrayWithCapacity:0];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citiesGot:) name:@"CITESGOT"  object:nil];
}

//接收服务器回应时这个方法被调用

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"服务器响应");
    self.receivedData = [NSMutableData  dataWithCapacity:5000];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小会执行若干次

- (void)connection:(NSURLConnection *)connetion didReceiveData:(NSData *)data

{
    NSLog(@"服务器返回数据");
    [self.receivedData appendData:data];
    
}

//数据传完之后调用此方法

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    self.regionDic = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:&error];
//    NSLog(@"getRegion:%@",regionDic);
    
    self.regionsArr = [self.regionDic objectForKey:@"regions"];
    
    self.gcities = [[GetCities alloc] init];
    
    gcities.regionsArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i<[regionsArr count]; i++) {
//        NSLog(@"[GetRegion]cityId:%@",[[regionsArr objectAtIndex:i] objectForKey:@"id"]);
        gcities.citiyId = [[regionsArr objectAtIndex:i] objectForKey:@"id"];
        
        [gcities.regionsArray addObject:[[regionsArr objectAtIndex:i] objectForKey:@"name"]];
        
        NSLog(@"getRegion=%d=time",i);
        
        [gcities getCities];

    }
    
    for (int j = 0; j<[regionsArr count]; j++) {
    
        NSLog(@"gcities.regionsArray:%@",[gcities.regionsArray objectAtIndex:j]);
    }
    
    [gcities release];
}

//网络请求过程中，出现任何错误，如断网，连接超时等，会进入此方法

- (void)connetion:(NSURLConnection *)connetion didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

//-(void)citiesGot:(NSNotification *)noti
//{
//    for (int i = 0; i<[regionsArr count]; i++) {
//        for (int j = 0; j<[[gcities.citiesDic objectForKey:@"regions"] count]; j++) {
//            NSLog(@"getCites:%@",[[[gcities.citiesDic objectForKey:@"regions"] objectAtIndex:i]objectForKey:@"name"]);
//        }
//        
//    }
//}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CITESGOT" object:nil];
    [gcities release];
    [regionsAndCitiesArray release];
    [regionDic release];
    [receivedData release];
    [super dealloc];
}
@end
