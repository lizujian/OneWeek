//
//  PostPraise.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-9.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostPraise : NSObject

-(void)postPraise;

@property (nonatomic,assign) int postId;
@property (nonatomic,retain) NSDictionary *praiseDic;
@end
