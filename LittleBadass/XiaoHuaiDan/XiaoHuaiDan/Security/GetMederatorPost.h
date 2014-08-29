//
//  GetMederatorPost.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/7.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMederatorPost : NSObject

-(void)getMederatorPost:(int)page;

@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) NSMutableDictionary *mederatorPostDic;
@property (nonatomic,assign) int mederatorIndex;

@end
