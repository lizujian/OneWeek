//
//  GetUserInfo.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/17.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserInfo : NSObject

-(void)getUserInfo:(int)userId;

@property (nonatomic,retain) NSMutableDictionary *userDataDic;

@end
