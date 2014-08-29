//
//  PostPetData.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@protocol RefreshUserCentrerDelegate
- (void)refrshUserCentrer:(NSMutableDictionary *)value;
@end

@interface PostPetData : NSObject

-(void)postPetData:(NSString *)name Race:(NSString *)race Breed:(NSString *)breed Sex:(int)sexIndex Portrait:(NSString *)portraitPath Birth:(NSString *)birthday :(UIView *)view;

@property (nonatomic,retain) MKNetworkOperation *op;
@property(nonatomic, retain) id<RefreshUserCentrerDelegate> refreshDelegate;
@end
