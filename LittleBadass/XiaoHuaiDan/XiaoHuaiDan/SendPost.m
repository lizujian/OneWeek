//
//  SendPost.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "SendPost.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation SendPost

-(void)sendPost:(int)moderatorId Title:(NSString *)title Content:(NSString *)content Pics:(NSMutableArray *)picsArray
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/post?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    
    //==============使用第三方库MKNetwork================
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%d",moderatorId] forKey:@"moderators_id"];
    [dict setValue:[NSString stringWithFormat:@"%@",title] forKey:@"title"];
    [dict setValue:[NSString stringWithFormat:@"%@",content] forKey:@"content"];
    [dict setValue:[picsArray objectAtIndex:0]forKey:@"picture_id"];

    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/post?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
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
