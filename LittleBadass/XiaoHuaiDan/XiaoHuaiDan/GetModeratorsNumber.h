//
//  GetModeratorsNumber.h
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetModeratorsNumber : NSObject

@property (nonatomic,retain) NSMutableDictionary *ModeratorsNumber;
@property(nonatomic,retain)NSMutableArray * ModerArray;
-(void)getModeratorsNumber;
@end
