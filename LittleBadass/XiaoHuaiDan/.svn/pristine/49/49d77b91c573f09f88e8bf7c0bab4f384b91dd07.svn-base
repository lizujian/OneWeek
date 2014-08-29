//
//  GetUserData.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate
- (void)setValue:(NSMutableDictionary *)value;
@end

@interface GetUserData : NSObject

-(void)getUserData:(int)userId :(UIViewController *)viewController;

@property (nonatomic,retain) NSMutableDictionary *dataDic;
@property(nonatomic, retain) id<PassValueDelegate> passDelegate;

@end
