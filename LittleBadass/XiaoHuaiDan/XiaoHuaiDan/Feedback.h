//
//  Feedback.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feedback : NSObject

-(void)feedback:(NSString *)questions;

@property (nonatomic,assign) BOOL isSendToServer;

@end
