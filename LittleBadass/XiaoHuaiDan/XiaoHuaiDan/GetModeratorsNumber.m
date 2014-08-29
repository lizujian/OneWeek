//
//  GetModeratorsNumber.m
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetModeratorsNumber.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
@implementation GetModeratorsNumber
@synthesize ModeratorsNumber,ModerArray;
-(void)getModeratorsNumber
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/moderators?parentid=&key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    //创建NSURL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/moderators?parentid=&key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]]];
    
    //通过URL创建NSURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];

    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    self.ModeratorsNumber = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"－－－－－－－－－%@",self.ModeratorsNumber);
    ModerArray = [self.ModeratorsNumber objectForKey:@"moderators"];
    [error release];
    [url release];
    [request release];
    
}
-(void)dealloc
{
    [ModeratorsNumber release];
    [ModerArray release];
    [super dealloc];
    
}

@end
