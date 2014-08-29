//
//  MainTableItem.m
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-5.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MainTableItem.h"

@implementation MainTableItem
@synthesize moderatorsName =_moderatorsName;
@synthesize imageArray =_imageArray;
@synthesize userIcon =_userIcon;
@synthesize userName =_userName;
@synthesize Online =_Online;
@synthesize Title =_Title;
@synthesize Content =_Content;
@synthesize contentID =_contentID;
@synthesize userID =_userID;
@synthesize moderators_id =_moderators_id;
@synthesize collectNum=_collectNum;
@synthesize createTime =_createTime;
@synthesize noderatorsName =_noderatorsName;
@synthesize praiseIcon=_praiseIcon;
@synthesize petAge=_petAge;
@synthesize petBreed=_petBreed;
@synthesize petIcon=_petIcon;
@synthesize petName=_petName;
@synthesize petRace =_petRace;
@synthesize petSex=_petSex;
@synthesize praiseUserInfo =_praiseUserInfo;
@synthesize praiseNum =_praiseNum;
@synthesize timeDiff=_timeDiff;
-(void)dealloc
{
    self.moderatorsName= nil;
    self.imageArray=nil;
    self.userIcon =nil;
    self.userName =nil;
    self.userRegion= nil;
    self.Online =nil;
    self.Title =nil;
    self.Content =nil;
    self.userID =nil;
    self.contentID =nil;
    self.moderators_id=nil;
    self.collectNum=nil;
    self.createTime =nil;
    self.noderatorsName =nil;
    self.praiseUserInfo =nil;
    self.petAge =nil;
    self.petBreed =nil;
    self.petName =nil;
    self.petIcon =nil;
    self.petRace =nil;
    self.praiseUserInfo =nil;
    self.timeDiff =nil;
    [super dealloc];
}

-(CGFloat)height
{
    //根据字体,显示的宽度,以及换行方式计算字符串高度
    CGSize size = [self.Content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}


@end
