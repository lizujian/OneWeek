//
//  publicFunction.h
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface publicFunction : NSObject
{
    NSMutableArray * thirdLoginArray;
}
//存放第三方登录的信息
@property(retain)NSMutableArray * thirdLoginArray;

-(publicFunction *)init;
+(publicFunction *)getInstance;

-(void)addLoginInfoWithLoginType:(int) loginType Uid:(NSString *)Uid nickName:(NSString *)nickName;
-(NSMutableArray *)readLoginInfo;
-(void)deleteLoginInfoWithUid:(NSString *)Uid;

@end
