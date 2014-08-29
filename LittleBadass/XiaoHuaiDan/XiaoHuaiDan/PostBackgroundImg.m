//
//  PostBackgroundImg.m
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-19.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostBackgroundImg.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "ALLAlert.h"
@implementation PostBackgroundImg

-(void)postBackgroundImage : (NSString *)imagePath
{
   // NSLog(@"path=%@",imagePath);
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/backdrop?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    //==============使用第三方库MKNetwork================
    
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithContentsOfFile:imagePath])];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:data forKey:@"backdropFile"];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/customer/backdrop?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    [op addFile:imagePath forKey:@"backdropFile"];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        //NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"portrait : %@",resDic);
        //NSLog(@"%@",[resDic objectForKey:@"ok"]);

        if ([[resDic objectForKey:@"ok"]integerValue]==1) {
            //NSLog(@"%@",[resDic objectForKey:@"ok"]);
        
            ALLAlert * alert = [[ALLAlert alloc] init];
            [alert createAlertViewWithMessage:@"背景图片替换成功"];
            [alert release];
        }

    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        
       // NSLog(@"%@",err);
       // NSLog(@"upload background image fail\n");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}

@end
