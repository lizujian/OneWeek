//
//  Feedback.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "Feedback.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation Feedback
@synthesize isSendToServer;

-(void)feedback:(NSString *)questions
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/feedback?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    
    //==============使用第三方库MKNetwork================
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%@",questions] forKey:@"question"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/feedback?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"feedback : %@",resDic);
        if ([[resDic objectForKey:@"ok"] intValue] == 1) {
            isSendToServer = 1;
        }
        
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSLog(@"MKNetworkEngine请求错误");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
    
}
@end
