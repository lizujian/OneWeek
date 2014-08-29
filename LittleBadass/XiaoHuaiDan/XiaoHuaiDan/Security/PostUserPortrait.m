//
//  PostUserPortrait.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-31.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostUserPortrait.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation PostUserPortrait

-(void)postUserPortrait : (NSString *)imagePath
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/portrait?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
   
    //==============使用第三方库MKNetwork================
    
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithContentsOfFile:imagePath])];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:data forKey:@"file"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/customer/portrait?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addFile:imagePath forKey:@"file"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"portrait : %@",resDic);
        
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSLog(@"MKNetworkEngine请求错误");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}

@end
