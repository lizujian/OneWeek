//
//  GetMyFans.h
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/18.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMyFans : NSObject

-(void)getMyFans:(int)userId :(int)page;

@property (nonatomic,retain) NSMutableDictionary *myFansDic;

@end
