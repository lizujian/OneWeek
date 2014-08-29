//
//  PetFamily.m
//  XiaoHuaiDan
//
//  Created by Amy on 14-8-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PetFamily.h"

@implementation PetFamily
@synthesize petName;

- (id)initWithFrame:(CGRect)frame name:(NSString *)petsName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        petName = [[NSString alloc] init];
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128.0/1136.0*self.frame.size.height)];
        [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
        [self addSubview:barView];
        self.backgroundColor = [UIColor redColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        backBtn.frame = CGRectMake(29.0/640.0*self.frame.size.width, 53.0/1136.0*self.frame.size.height, 63.0/640.0*self.frame.size.width, 61.0/1136.0*self.frame.size.height);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:backBtn];
        //        petName =@"dog";
        petName = petsName;
        //        NSLog(@"petName:%@",petName);
        
        NSError *error;
        NSString * content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",petName] ofType:@"txt"]  encoding: NSUTF16StringEncoding error:&error];
        
        // If there are no results, something went wrong
        if (content == nil) {
            // an error occurred
            NSLog(@"error reading text file,%@",[error localizedFailureReason]);
        }
        
        
        dataArray = [[NSMutableArray alloc] init];
        sectionArray = [[NSMutableArray alloc] init];
        NSArray *lines = [content componentsSeparatedByString:@"\n"];
        for (int i =0; i< [lines count]-1; i++) {
            NSString * str = [lines objectAtIndex:i];
            NSArray *  temLine = [str componentsSeparatedByString:@"："];
            NSArray * array = [NSArray arrayWithObjects:[temLine objectAtIndex:0],[[temLine objectAtIndex:1] componentsSeparatedByString:@"，"],nil];
            [sectionArray addObject:[temLine objectAtIndex:0]];
            [dataArray addObject:array];
        }
        
        NSString * versionStr = [[UIDevice currentDevice]systemVersion];
        NSRange range = [versionStr rangeOfString:@"7"];
        if(range.location!=NSNotFound)
        {//说明是iOS7
            myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];
        }
        else
        {
            myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }
        myTable.delegate = self;
        myTable.dataSource = self;
        [self addSubview:myTable];
        
    }
    return self;
}
#pragma  mark --tableView
//section 右侧索引表
//表格所有组的索引标题数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionArray;
}
////表格有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return  [dataArray count];
}
//每个section 的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * array = [dataArray objectAtIndex:section];
    return [array objectAtIndex:0];
}
////某一个索引相对应的数据源（组）的索引
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index< [sectionArray count]) {
        return index;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[dataArray objectAtIndex:section] objectAtIndex:1]count];
}

-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"MyCellName";
    //获得是否有可复用标识符
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    //如果没有就创建新对象
    if(cell == nil){
        //不是所有的类的对象的初始化方法都是init
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    NSArray * array = [dataArray objectAtIndex:indexPath.section];
    NSArray * subArray = [array objectAtIndex:1];
    cell.textLabel.text = [subArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [dataArray objectAtIndex:indexPath.section];
    NSArray * subArray = [array objectAtIndex:1];
    if (self.delegate && [self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:[subArray objectAtIndex:indexPath.row]];
    }
    [self removeFromSuperview];
}
-(void)dealloc
{
    [dataArray release];
    [sectionArray release];
    
    [myTable release];
    [petName release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
