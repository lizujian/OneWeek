//
//  DeletePet.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/8/5.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "DeletePet.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation DeletePet

-(void)deletePet:(int)petId
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/pet/%d?key=%@&secret=%@",petId,appDelegate.key,appDelegate.secret];
    
    //==============使用第三方库MKNetwork================
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
//    [dict setValue:data forKey:@"file"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/pet/%d?key=%@&sign=%@",petId,appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"DELETE"];
    
//    [op addFile:imagePath forKey:@"file"];
    
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
