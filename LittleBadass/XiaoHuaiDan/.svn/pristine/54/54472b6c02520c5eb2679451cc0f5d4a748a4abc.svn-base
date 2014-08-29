//
//  GetUserData.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "GetUserData.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "PersonalInfoViewController.h"
#import "PersonalInfoView.h"

@implementation GetUserData
@synthesize dataDic,passDelegate;

-(void)getUserData:(int)userId :(UIViewController *)viewController
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/customer/info/%d?key=%@&secret=%@",userId,appDelegate.key,appDelegate.secret];
    
    
    //==============使用第三方库MKNetwork================
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%d",userId] forKey:@"id"];
    
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/customer/info/%d?key=%@&sign=%@",userId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"GetUserData-------- : %@",dataDic);
        
        self.passDelegate = (id<PassValueDelegate>)viewController;
        [self.passDelegate setValue:self.dataDic];
 
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSLog(@"MKNetworkEngine请求错误");
    }];
   
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];
    
    NSLog(@"dataDic : %@",dataDic);
    
}
@end
