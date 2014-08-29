//
//  PostCustomerData.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostCustomerData.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "ALLAlert.h"
@implementation PostCustomerData

-(void)postCustomerData:(NSString *)name email:(NSString *)mail region:(NSString *)dis sex:(int)sexIndex
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customerUpdate/?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    //==============使用第三方库MKNetwork================
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%@",name] forKey:@"name"];
    [dict setValue:[NSString stringWithFormat:@"%@",mail] forKey:@"mail"];
    [dict setValue:[NSString stringWithFormat:@"%@",dis] forKey:@"region"];
    [dict setValue:[NSString stringWithFormat:@"%d",sexIndex] forKey:@"sex"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/customerUpdate/?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
//       // NSLog(@"reply response : %@",[operation responseString]);
//        NSData *data = [operation responseData];
//        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        if ([[resDic objectForKey:@"ok"] isEqualToString:@"1"]) {
            ALLAlert * alert = [[ALLAlert alloc] init];
            [alert createAlertViewWithMessage:@"信息上传成功"];
            [alert release];
 //       }
        
        //NSLog(@"reply : %@",resDic);
        
    }
        errorHandler:^(MKNetworkOperation *errOp,NSError *err)
    {
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
//上传用户头像
-(void)postUserPortrait : (NSString *)imagePath
{
    //NSLog(@"API imagePath=%@",imagePath);
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
        //  NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@" userIcon portrait : %@",resDic);
        
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSData *data = [errOp responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString * message = [resDic objectForKey:@"message"];
        NSLog(@"message＝＝＝＝＝＝＝＝＝＝＝＝%@",message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil  message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
        // NSLog(@"userIcon MKNetworkEngine请求错误");
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
}

@end
