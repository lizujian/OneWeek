//
//  PostPraise.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-9.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostPraise.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation PostPraise
@synthesize postId,praiseDic;

-(void)postPraise
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/praise/%d?key=%@&secret=%@",postId,appDelegate.key,appDelegate.secret];
    
    NSString *urlString = [NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/praise/%d?key=%@&sign=%@",postId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]];
    
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
    
    self.praiseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
            NSLog(@"praise: %@",praiseDic);
        
    }
    [request release];
    [error release];
    
}

-(void)dealloc
{
    [praiseDic release];
    [super dealloc];
}

@end
