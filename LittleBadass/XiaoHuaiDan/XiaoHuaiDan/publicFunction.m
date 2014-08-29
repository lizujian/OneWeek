//
//  publicFunction.m
//  XiaoHuaiDan
//
//  Created by ZhouLei on 14-8-3.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "publicFunction.h"

static publicFunction *instance = nil;

@implementation publicFunction

@synthesize thirdLoginArray;

-(publicFunction *)init
{
    if (self == [super init]) {
        NSString * loginPath =[NSHomeDirectory() stringByAppendingString:@"/Documents/thirdLoginArray.plist"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:loginPath ]){
            [self createLoginFile];
        }
        thirdLoginArray = [[NSMutableArray alloc] initWithContentsOfFile:loginPath];
    }
    return self;
}
+ (publicFunction*)getInstance
{
    if (instance == nil)
    {
        instance = [[publicFunction alloc] init];
        
        //[instance initialize];
    }
    
    return instance;
}
//创建plist文件
-(void)createLoginFile
{
    //NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    NSString * fileName=@"thirdLoginArray.plist";
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]];
    //初始化文件
    NSData * data =(NSData *) [[NSMutableArray alloc] init];
    //创建文件fileName文件名称，初始化 contents文件的内容，attributes文件的属性，初始为nil
	[fileManager createFileAtPath:fileName contents:data attributes:nil];
    [data release];
}
//把某种登录信息保存到数组，再把数组作为元素保存到thirdLognArray中
-(void)addLoginInfoWithLoginType:(int) loginType Uid:(NSString *)Uid nickName:(NSString *)nickName
{
    //读取数据
    NSString *userPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/thirdLoginArray.plist"];
    NSMutableArray * curInfo = [[[NSMutableArray alloc] init] autorelease];
    NSNumber * type = [[NSNumber alloc] initWithInt:loginType];
    [curInfo addObject:type];
    [curInfo addObject:Uid];
    [curInfo addObject:nickName];
    
    for (int i=0; i<[thirdLoginArray count]; i++) {
        NSArray * tempArray = [thirdLoginArray objectAtIndex:i];
        if ([[tempArray objectAtIndex:1] isEqualToString:Uid]) {
            [thirdLoginArray replaceObjectAtIndex:i withObject:curInfo];
            [thirdLoginArray writeToFile:userPath atomically:YES];
            return;
        }
    }
    [thirdLoginArray addObject:curInfo];
    [thirdLoginArray writeToFile:userPath atomically:YES];
}
// 根据Uid删除信息，因为plist中只能存储当前分享类型的某一个Uid
-(void)deleteLoginInfoWithUid:(NSString *)Uid
{
//    NSLog(@"Uid is:%@",Uid);
//    
//    for(id obj in thirdLoginArray){
//        for (id objj in obj) {
//            NSLog(@"%@",objj);
//            
//        }
//        NSLog(@"\n");
//    }
    //读取数据
    NSString *userPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/thirdLoginArray.plist"];
    for (int i=0;i< [thirdLoginArray count];i++) {
        NSMutableArray * tempArray = [thirdLoginArray objectAtIndex:i];
        
        if ([[tempArray objectAtIndex:1] isEqualToString:Uid]) {
            [thirdLoginArray removeObject:tempArray];
            NSLog(@"delete success----------\n");
            break;
        }
    }
    //写入文件
    [thirdLoginArray writeToFile:userPath atomically:YES];
    
}
-(NSMutableArray *)readLoginInfo
{
    return thirdLoginArray;
}
@end
