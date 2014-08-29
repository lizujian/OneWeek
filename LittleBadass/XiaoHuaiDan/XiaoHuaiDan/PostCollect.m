//
//  PostCollect.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/10.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostCollect.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation PostCollect

-(void)postCollection:(int)postId
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/collect/%d?key=%@&secret=%@",postId,appDelegate.key,appDelegate.secret];
    
    NSString *urlString = [NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/collect/%d?key=%@&sign=%@",postId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]];
    
    NSLog(@"%d",postId);
    NSLog(@"collect===%@",urlString);
    
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
    
    NSMutableDictionary *praiseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
            NSLog(@"Response: %@",praiseDic);
        
    }
    [request release];
    [error release];
}
@end
