//
//  GetEssencePost.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-7.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetEssencePost : NSObject

-(void)getEssencePost:(int)page;

@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) NSMutableDictionary *essencePostDic;
@property (nonatomic,retain) NSMutableArray * essnceArray;

@end
