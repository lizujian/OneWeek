//
//  PostPhoto.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-8-7.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostPhoto.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation PostPhoto

-(void)postPhoto:(NSString *)filePath
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/photo?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    //==============使用第三方库MKNetwork================
    
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithContentsOfFile:filePath])];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:data forKey:@"file"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/photo?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addFile:filePath forKey:@"file"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
//        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"photo : %@",resDic);
        
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSLog(@"MKNetworkEngine请求错误");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}
@end
