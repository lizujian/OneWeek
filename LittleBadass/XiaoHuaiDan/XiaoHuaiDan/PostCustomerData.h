//
//  PostCustomerData.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostCustomerData : NSObject

-(void)postCustomerData:(NSString *)name email:(NSString *)mail region:(NSString *)dis sex:(int)sexIndex;
//上传用户头像
-(void)postUserPortrait : (NSString *)imagePath;

@end
