//
//  Login.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-10.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "ALLAlert.h"
@implementation Login

-(void)login
{
    //==============使用第三方库MKNetwork================
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/login?key=%@&secret=%@",appDelegate.key,appDelegate.secret];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"1" forKey:@"type"];
    [dict setValue:@"asdasd" forKey:@"keyseri"];

    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/customer/login?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"=================login===================== : %@",resDic);
        if ([[resDic objectForKey:@"ok"]isEqualToString:@"1"]) {
            appDelegate.isLogin = YES;
            ALLAlert * alert = [[ALLAlert alloc] init];
            [alert createAlertViewWithMessage:@"登录成功"];
            [alert release];
        }
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSData *data = [errOp responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * message = [resDic objectForKey:@"message"];
        ALLAlert * alert = [[ALLAlert alloc] init];
        [alert createAlertViewWithMessage:message];
        [alert release];
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}
@end
