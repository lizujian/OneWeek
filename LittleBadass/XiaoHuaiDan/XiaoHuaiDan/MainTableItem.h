//
//  MainTableItem.h
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-5.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTableItem : NSObject
@property (retain, nonatomic) NSArray * imageArray;
@property (retain, nonatomic) NSString *userIcon;
@property (retain, nonatomic) NSString *userName;
@property (retain,nonatomic) NSString * userRegion;
@property (retain, nonatomic) NSString *Online;
@property (retain, nonatomic) NSString *Title;
@property (retain, nonatomic) NSString *Content;
@property (assign,nonatomic)NSString  *contentID;//帖子ID
@property (retain, nonatomic) NSString * userID;
@property (retain,nonatomic) NSString * moderators_id;//星球ID
@property (retain, nonatomic) NSString *moderatorsName;//星球名字
@property (assign ,nonatomic)NSInteger collectNum;// 收藏数量
@property (retain,nonatomic)NSString * createTime;//帖子创建时间
@property (retain,nonatomic)NSString *  noderatorsName;//星球名字
@property (retain,nonatomic)NSArray * praiseIcon;//点赞的头像
@property(assign,nonatomic)NSInteger  petAge;
@property (retain,nonatomic)NSString * petBreed;//宠物品种（什么狗）
@property (retain,nonatomic)NSString * petName;//宠物名字
@property (retain,nonatomic)NSString * petIcon;//宠物头像
@property (retain,nonatomic)NSString * petRace;//宠物种族（狗or猫）
@property(retain,nonatomic)NSString * petSex;//宠物性别
@property(retain,nonatomic)NSArray * praiseUserInfo;//点赞用户的信息（数组里面每个用户的资料是字典形式）
@property (assign,nonatomic)NSInteger praiseNum;
@property (retain,nonatomic)NSDictionary * timeDiff;//距今几天几时几分
//获得动态信息的高度
-(CGFloat)height;

@end
