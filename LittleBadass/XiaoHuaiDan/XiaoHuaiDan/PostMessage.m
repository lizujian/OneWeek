//
//  PostMessage.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/9.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostMessage.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation PostMessage
//@synthesize postId;

-(void)postMessage:(int)postId :(int)parentId :(NSString *)content
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/comment?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
//    NSString *urlString = [NSString stringWithFormat:@"http://cmobile.petplanetzone.com/1.0/comment?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]];
    
    //==============使用第三方库MKNetwork================
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%d",postId] forKey:@"post_id"];
    [dict setValue:[NSString stringWithFormat:@"%d",parentId] forKey:@"parent_id"];
    [dict setValue:content forKey:@"content"];
//    [dict setValue:@"" forKey:@"picture_id"];

    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/comment?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"reply : %@",resDic);
      
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSLog(@"MKNetworkEngine请求错误");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}
@end
