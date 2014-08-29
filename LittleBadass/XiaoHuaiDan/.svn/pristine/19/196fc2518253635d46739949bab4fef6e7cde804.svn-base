//
//  PostPetData.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PostPetData.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"


@implementation PostPetData
@synthesize op,refreshDelegate;

-(void)postPetData:(NSString *)name Race:(NSString *)race Breed:(NSString *)breed Sex:(int)sexIndex Portrait:(NSString *)portraitPath Birth:(NSString *)birthday :(UIView *)view
{
    //prepar request
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *md5Str = [NSString stringWithFormat:@"/1.0/pet?key=%@&secret=%@",appDelegate.key,appDelegate.secret];
    
    NSData *portraitData = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:portraitPath]);
    
    //==============使用第三方库MKNetwork================
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%@",name] forKey:@"name"];
    [dict setValue:[NSString stringWithFormat:@"%@",race] forKey:@"race"];
    [dict setValue:[NSString stringWithFormat:@"%@",breed] forKey:@"breed"];
    [dict setValue:[NSString stringWithFormat:@"%d",sexIndex] forKey:@"sex"];
    [dict setValue:portraitData forKey:@"portrait"];
    [dict setValue:[NSString stringWithFormat:@"%@",birthday] forKey:@"birthday"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cmobile.petplanetzone.com" customHeaderFields:nil];
    self.op = [engine operationWithPath:[NSString stringWithFormat:@"/1.0/pet?key=%@&sign=%@",appDelegate.key,[SecurityUtil encryptMD5String:md5Str]] params:dict httpMethod:@"POST"];
    
    [op addFile:portraitPath forKey:@"portrait"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
//        NSLog(@"reply response : %@",[operation responseString]);
        NSData *data = [operation responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"reply : %@",resDic);
        
        self.refreshDelegate = (id<RefreshUserCentrerDelegate>)view;
        [self.refreshDelegate refrshUserCentrer:resDic];
        
    }errorHandler:^(MKNetworkOperation *errOp,NSError *err){
        NSData *data = [errOp responseData];
        NSMutableDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"MKNetworkEngine请求错误，%@",resDic);
    }];
    [engine enqueueOperation:op];
    
    [dict release];
    [engine release];

}

-(void)dealloc
{
    [op release];
    [super dealloc];
}
@end
