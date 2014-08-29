//
//  GetVersion.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetVersion : NSObject

@property (nonatomic,retain) NSDictionary *authDic;
//获取版本
-(void)getVersion;
//获得授权
-(void)getAuth;


@end
