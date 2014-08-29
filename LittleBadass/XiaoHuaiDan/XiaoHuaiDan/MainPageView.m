//
//  MainPageView.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/28.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MainPageView.h"
#import "GetEssencePost.h"
#import "GetVersion.h"
#import "UIImageView+WebCache.h"
#import "MainTableViewCell.h"
#import "MainTableItem.h"
#import "GetModeratorsNumber.h"
#import "CustomImageView.h"
#import "PersonalInfoViewController.h"
#define VIEW_FRAME_HEIGHT    self.frame.size.height
#define VIEW_FRAME_WIDTH     self.frame.size.width

@implementation MainPageView
@synthesize fc,mpc,postDic,dic,requestTimes,isLoading,postArray;
@synthesize backImg;
//@synthesize curPageArray = _curPageArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //判断是否为iOS7
//        NSString * versionStr = [[UIDevice currentDevice]systemVersion];
//        NSRange range = [versionStr rangeOfString:@"7"];
//        if(range.location!=NSNotFound)
//        {//说明是iOS7
//            myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];
//        }
//        else    {
//            myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        }
        myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:myTableView];
        
        //下拉刷新视图
        frame = myTableView.frame;
        frame.origin.y -= (frame.size.height+20)
;
        refreshView = [[EGORefreshTableHeaderView alloc]initWithFrame:frame];
        refreshView.delegate = self;
        [myTableView addSubview:refreshView];
        //最后刷新时间
        [refreshView refreshLastUpdatedDate];

        dataArray  = [[NSMutableArray alloc]init];

        self.isLoading = NO;
        //获取第一页的数据，每页4条记录
        self.requestTimes = 1;
        
        GetEssencePost *getPost = [[GetEssencePost alloc] init];
        [getPost getEssencePost:self.requestTimes];
        
        //获得各个星球的在线人数
        GetModeratorsNumber * moderNum = [[GetModeratorsNumber alloc] init];
        [moderNum getModeratorsNumber];
        NSLog(@"%d",   [moderNum.ModerArray count]);
        for (int i =0; i<[moderNum.ModerArray count]; i++) {
            NSDictionary * dict = [moderNum.ModerArray objectAtIndex:i];
            if ([[dict objectForKey:@"id"] integerValue]==1) {
                num1 = [[dict objectForKey:@"num"] integerValue];
            }
            else if ([[dict objectForKey:@"id"] integerValue]==2) {
                num2 = [[dict objectForKey:@"num"] integerValue];
            }
           else if ([[dict objectForKey:@"id"] integerValue]==3) {
                num3 = [[dict objectForKey:@"num"] integerValue];
            }
            else if ([[dict objectForKey:@"id"] integerValue]==4) {
                num4 = [[dict objectForKey:@"num"] integerValue];
            }
            else  {
                num5 = [[dict objectForKey:@"num"] integerValue];
            }
       
        }
//        self.customerIdArray = [NSMutableArray arrayWithCapacity:0];
//        self.customerNameArray = [NSMutableArray arrayWithCapacity:0];
//        self.customerPortraitArray = [NSMutableArray arrayWithCapacity:0];
//        self.titleArray = [NSMutableArray arrayWithCapacity:0];
//        self.contentArray = [NSMutableArray arrayWithCapacity:0];
//        self.praiseNumArray = [NSMutableArray arrayWithCapacity:0];
//        self.collectNumArray = [NSMutableArray arrayWithCapacity:0];
//        self.totalArray = [NSMutableArray arrayWithCapacity:0];
//        self.moderatorsIdArray = [NSMutableArray arrayWithCapacity:0];
        self.dic = [NSMutableDictionary dictionaryWithCapacity:0];
        self.dic = [NSMutableDictionary dictionaryWithDictionary:getPost.essencePostDic];
        
        postArray = [[NSMutableArray alloc] init];
        [postArray addObjectsFromArray:getPost.essnceArray];
        if ([postArray count] !=0) {
            for (int i=0; i<[postArray count]; i++) {
                MainTableItem * item = [[MainTableItem alloc] init];
                item.collectNum = [[postArray objectAtIndex:i] objectForKey:@"collectNum"];
                item.Content =[[postArray  objectAtIndex:i] objectForKey:@"content"];
                item.createTime =[[postArray  objectAtIndex:i] objectForKey:@"create_time"];
                item.userName =[[postArray  objectAtIndex:i] objectForKey:@"customerName"];
                item.userIcon =[[postArray  objectAtIndex:i] objectForKey:@"customerPortrait"];
                item.userRegion =[[postArray  objectAtIndex:i] objectForKey:@"customerRegion"];
                item.userID = [[postArray objectAtIndex:i] objectForKey:@"customer_id"];
                item.contentID = [[postArray objectAtIndex:i] objectForKey:@"id"];
                item.moderators_id = [NSString stringWithFormat:@"%@",[[postArray objectAtIndex:i] objectForKey:@"moderators_id"]];
                
                // item.moderators_id = [[[dic objectForKey:@"post"] objectAtIndex:i] objectForKey:@"moderators_id"];
                item.moderatorsName = [[postArray objectAtIndex:i] objectForKey:@"moderatorsName"];
                
                item.Title =[[postArray  objectAtIndex:i] objectForKey:@"title"];
                item.petName = [[postArray  objectAtIndex:i] objectForKey:@"petName"];
                item.petAge = [[postArray objectAtIndex:i] objectForKey:@"petAge"];
                item.petBreed = [[postArray  objectAtIndex:i] objectForKey:@"petBreed"];
                item.petIcon = [[postArray objectAtIndex:i] objectForKey:@"petPortrait"];
                item.petRace = [[postArray objectAtIndex:i] objectForKey:@"petRace"];
                item.petSex = [[postArray  objectAtIndex:i] objectForKey:@"petSex"];
                item.imageArray = [[postArray  objectAtIndex:i] objectForKey:@"pics"];
                item.praiseUserInfo = [[postArray objectAtIndex:i] objectForKey:@"praiseCustomer"];
                item.praiseNum = [[postArray
                                   objectAtIndex:i] objectForKey:@"praiseNum"];
                //[self.curPageArray addObject:item];
                [dataArray addObject:item];
                [item release];
                //[self.moderatorsIdArray addObject:[[[dic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"moderators_id"]];

            }
        }
        //通知下拉刷新视图加载结束
        //[refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];

        [getPost release];
    }
    return self;
}
-(void)click:(UIButton *)btn
{
   // NSLog(@"btn.tag=%d",btn.tag);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTO" object:[NSString stringWithFormat: @"%d", btn.tag-1]];
}

#pragma mark --tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"dataArray count=%d",[dataArray count]);
    if (requestTimes==1) {
       return ([dataArray count]+1);
    }
    return [dataArray count];
}
//返回每行高度的协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row=%d",indexPath.row);
    NSLog(@"dataArray =%d",[dataArray count]);
    if (requestTimes ==1) {
        if (indexPath.row ==0) {
            return 250;
        }
        else{
            MainTableItem * item = [dataArray objectAtIndex:indexPath.row-1];
            if([item.imageArray count]==0)
            {
                return 45+[item height]+44;
            }
            else return 45+[item height]+44+100+10;
        }
        
    }
    else{
        MainTableItem * item = [dataArray objectAtIndex:indexPath.row];
        if([item.imageArray count]==0)
        {
            return 45+[item height]+44;
        }
        else return 45+[item height]+44+100+10;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row== 0&&requestTimes ==1){
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image.png"]];
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellforRow:%d",indexPath.row);
    if (indexPath.row ==0&&requestTimes ==1) {
        static NSString *CellIdentifier = @"myCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            UIButton *blastingImg = [UIButton buttonWithType:UIButtonTypeCustom];
            blastingImg.frame =CGRectMake((320-74)/2, 108, 90, 74);
            blastingImg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"according_blasting_a.png"]];
            blastingImg.tag = 1;
            [blastingImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:blastingImg];
            
            UILabel * blastingName = [[UILabel alloc] initWithFrame:CGRectMake( blastingImg.frame.origin.x, blastingImg.frame.origin.y+ blastingImg.frame.size.height,  blastingImg.frame.size.width, 15)];
            blastingName.text =@"爆照星";
            blastingName.textAlignment = NSTextAlignmentCenter;
            [ blastingName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14.0]];
            blastingName.textColor = [UIColor colorWithRed:255.0/255.0  green:81.0/255.0  blue:90.0/255.0  alpha:1];
            [cell.contentView addSubview: blastingName];
            
            UILabel * blastingOnline = [[UILabel alloc] initWithFrame:CGRectMake( blastingName.frame.origin.x, blastingName.frame.origin.y+ blastingName.frame.size.height,  blastingName.frame.size.width, 15)];
            blastingOnline.text = [NSString stringWithFormat:@"%d在线",num1];
            blastingOnline.textAlignment = NSTextAlignmentCenter;
            blastingOnline.textColor = [UIColor whiteColor];
            [ blastingOnline setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
            [cell.contentView addSubview: blastingOnline];
            
            UILabel * choice = [[UILabel alloc] initWithFrame:CGRectMake(blastingOnline.frame.origin.x, blastingOnline.frame.size.height+blastingOnline.frame.origin.y+10, blastingOnline.frame.size.width, 20)];
            choice.text = @"每日精选" ;
            choice.textAlignment = NSTextAlignmentCenter;
            choice.textColor = [UIColor colorWithRed:253.0/255.0 green:133.0/255.0 blue:144.0/255.0 alpha:1];
            [choice setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
            [cell.contentView addSubview:choice];
            [choice release];
            [ blastingOnline release];
            [ blastingName release];
            
            UIButton *kittenImg = [UIButton buttonWithType:UIButtonTypeCustom];
            kittenImg.frame =CGRectMake(230, 85, 58, 48);
            kittenImg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kitten_star_a.png"]];
            //[kittenImg setImage:[UIImage imageNamed:@"kitten_star_a.png" ] forState:UIControlStateNormal];
            kittenImg.tag = 2;
            [kittenImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:kittenImg];
            
            UILabel * kittenName = [[UILabel alloc] initWithFrame:CGRectMake(kittenImg.frame.origin.x,kittenImg.frame.origin.y+kittenImg.frame.size.height, kittenImg.frame.size.width, 15)];
            kittenName.text =@"喵喵星";
            kittenName.textAlignment = NSTextAlignmentCenter;
            [kittenName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14.0]];
            kittenName.textColor = [UIColor colorWithRed:98.0/255.0 green:204.0/255.0 blue:205.0/255.0 alpha:1];
            [cell.contentView addSubview:kittenName];
            
            UILabel *kittenOnline = [[UILabel alloc] initWithFrame:CGRectMake(kittenName.frame.origin.x, kittenName.frame.origin.y+kittenName.frame.size.height, kittenName.frame.size.width, 15)];
            kittenOnline.text = [NSString stringWithFormat:@"%d在线",num2];
            kittenOnline.textAlignment = NSTextAlignmentCenter;
            kittenOnline.textColor = [UIColor whiteColor];
            [kittenOnline setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
            [cell.contentView addSubview:kittenOnline];
            
            [kittenOnline release];
            [kittenName release];
            
            UIButton *spitslotImg = [UIButton buttonWithType:UIButtonTypeCustom];
            spitslotImg.frame =CGRectMake(170, 20, 58, 48);
            spitslotImg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"spitslot_a.png"]];
            spitslotImg.tag = 3;
            [spitslotImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:spitslotImg];
            
            UILabel * spitslotName = [[UILabel alloc] initWithFrame:CGRectMake(spitslotImg.frame.origin.x, spitslotImg.frame.origin.y+spitslotImg.frame.size.height, spitslotImg.frame.size.width, 15)];
            spitslotName.text =@"吐槽星";
            spitslotName.textAlignment = NSTextAlignmentCenter;
            [spitslotName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14.0]];
            spitslotName.textColor = [UIColor colorWithRed:255.0/255.0 green:63.0/255.0 blue:143.0/255.0 alpha:1];
            [cell.contentView addSubview:spitslotName];
            
            UILabel *spitslotOnline = [[UILabel alloc] initWithFrame:CGRectMake(spitslotName.frame.origin.x, spitslotName.frame.origin.y+spitslotName.frame.size.height, spitslotName.frame.size.width, 15)];
            spitslotOnline.text = [NSString stringWithFormat:@"%d在线",num3];
            spitslotOnline.textAlignment = NSTextAlignmentCenter;
            spitslotOnline.textColor = [UIColor whiteColor];
            [spitslotOnline setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
            [cell.contentView addSubview:spitslotOnline];
            
            [spitslotOnline release];
            [spitslotName release];
            
            UIButton * bowwowImg = [UIButton buttonWithType:UIButtonTypeCustom];
            bowwowImg.frame =CGRectMake(90, 20, 58, 48);
            bowwowImg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bowwow_a.png"]];
            bowwowImg.tag = 4;
            [cell.contentView addSubview:bowwowImg];
            [bowwowImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * bowwowName = [[UILabel alloc] initWithFrame:CGRectMake(bowwowImg.frame.origin.x, bowwowImg.frame.origin.y+bowwowImg.frame.size.height+5, bowwowImg.frame.size.width, 15)];
            bowwowName.text =@"汪汪星";
            bowwowName.textAlignment = NSTextAlignmentCenter;
            [bowwowName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14.0]];
            bowwowName.textColor = [UIColor colorWithRed:167.0/255.0 green:254.0/255.0  blue:94.0/255.0  alpha:1];
            [cell.contentView addSubview:bowwowName];
            
            UILabel *bowwowOnline = [[UILabel alloc] initWithFrame:CGRectMake(bowwowName.frame.origin.x, bowwowName.frame.origin.y+bowwowName.frame.size.height, bowwowName.frame.size.width, 15)];
            bowwowOnline.text = [NSString stringWithFormat:@"%d在线",num4];
            bowwowOnline.textAlignment = NSTextAlignmentCenter;
            bowwowOnline.textColor = [UIColor whiteColor];
            [bowwowOnline setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
            [cell.contentView addSubview:bowwowOnline];
            
            [bowwowOnline release];
            [bowwowName release];
            
            UIButton * feedImg = [UIButton buttonWithType:UIButtonTypeCustom];
            feedImg.frame = CGRectMake(15, 85, 58, 48);
            feedImg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"feed.png"]];
            feedImg.tag = 5;
            [feedImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:feedImg];
            
            UILabel * feedName = [[UILabel alloc] initWithFrame:CGRectMake(feedImg.frame.origin.x, feedImg.frame.origin.y+feedImg.frame.size.height+5, feedImg.frame.size.width, 15)];
            feedName.text =@"代养星";
            feedName.textAlignment = NSTextAlignmentCenter;
            [feedName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14.0]];
            feedName.textColor = [UIColor colorWithRed:237.0/255.0  green:204.0/255.0  blue:46.0/255.0   alpha:1];
            [cell.contentView addSubview:feedName];
            
            UILabel *feedOnline = [[UILabel alloc] initWithFrame:CGRectMake(feedName.frame.origin.x, feedName.frame.origin.y+feedName.frame.size.height, feedName.frame.size.width, 15)];
            feedOnline.text = [NSString stringWithFormat:@"%d在线",num5 ];
            feedOnline.textAlignment = NSTextAlignmentCenter;
            feedOnline.textColor = [UIColor whiteColor];
            [feedOnline setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
            [cell.contentView addSubview:feedOnline];
            
            [feedOnline release];
            [feedName release];
            
        }
        return cell;
    }
    else{
        static NSString * cellId = @"MainTableViewCell";
        MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil] lastObject];
            cell.userInteractionEnabled = YES;
        }
        MainTableItem * item= [[MainTableItem alloc] init];
        if (requestTimes ==1) {
            item = [dataArray objectAtIndex:indexPath.row-1];
        }
        else{
            item = [dataArray objectAtIndex:indexPath.row];

        }
        
        if ([item.moderators_id  isEqualToString:@"1"]) {//爆照星
            cell.Star.image = [UIImage imageNamed:@"photo_c.png"];
            cell.Star.tag= 11;
        }
        else if([item.moderators_id  isEqualToString:@"2"]==YES){//喵喵星
            cell.Star.image = [UIImage imageNamed:@"meowth_c.png"];
            cell.Star.tag= 12;

        }
        else if([item.moderators_id  isEqualToString:@"3"]==YES){//吐嘈星
            cell.Star.image = [UIImage imageNamed:@"talk_icon.png"];
            cell.Star.tag= 13;

        }
        else if ([item.moderators_id  isEqualToString:@"4"]==YES){//汪汪星
            cell.Star.image = [UIImage imageNamed:@"wang_c.png"];
            cell.Star.tag= 14;

        }
        else{
            cell.Star.image = [UIImage imageNamed:@"feeds_c.png"];
            cell.Star.tag= 15;

        }
        //点击进入星球
        CustomImageView * StarImg = cell.Star;
        StarImg.tag = cell.Star.tag;
        StarImg.delegate = self;
        StarImg.method = @selector(goToModerators:);
        cell.Star.userInteractionEnabled = YES;
        
        CustomImageView * userImg = cell.Icon;
        userImg.tag =  [item.userID intValue];
        userImg.delegate = self;
        userImg.method = @selector(goToPersonView:);
        cell.Icon.userInteractionEnabled = YES;
        
        cell.Title.text = item.Title;
        cell.Content.text = item.Content;
        cell.Name.text = item.userName;
        cell.Online.text =item.Online;
        //设置计算高度时的参数
        cell.Content.font = [UIFont systemFontOfSize:14];
        cell.Content.lineBreakMode = UILineBreakModeCharacterWrap;
        //设置行数为0,有多少显示多少
        cell.Content.numberOfLines = 0;
        cell.Online.text = [NSString stringWithFormat:@"访问人数:%d",1233];
        //得到新设置标签的高度
        CGRect frame = cell.Content.frame;
        frame.size.height = [item height];
        cell.Content.frame = frame;
        cell.Content.text = item.Content;
        NSArray * array = [NSArray arrayWithObjects:cell.Img1,cell.Img2,cell.Img3,nil];
        CGRect imageFrame = cell.Img1.frame;
        imageFrame.origin.y = 43+item.height;
        for (int i=0; i<[array count]; i++) {
            UIImageView * imageView = [array objectAtIndex:i];
            if (i<[item.imageArray count]) {
                imageView.hidden = NO;
                [imageView setImageWithURL:[item.imageArray objectAtIndex:i]];
            }
            else
            {
                imageView.hidden = YES;
            }
            imageFrame.origin.x = 35+(92+1)*i;
            imageView.frame = imageFrame;
        }
        NSURL * url = [[NSURL alloc] initWithString:item.userIcon];
        [cell.Icon setImageWithURL:url];
        [url release];
        
        cell.Icon.frame = CGRectMake(35, cell.Img1.frame.origin.y+cell.Img1.frame.size.height+1, 38, 41);
        cell.Name.frame = CGRectMake(73, cell.Img1.frame.origin.y+cell.Img1.frame.size.height+1, 119, 41);
        cell.Online.frame = CGRectMake(192, cell.Img1.frame.origin.y+cell.Img1.frame.size.height+1, 121, 41);
        if ([item.imageArray count]==0) {
            cell.Icon.frame = CGRectMake(35, cell.Content.frame.origin.y+cell.Content.frame.size.height+1, 38, 41);
            cell.Name.frame = CGRectMake(73, cell.Icon.frame.origin.y+1, 119, 41);
            cell.Online.frame = CGRectMake(192, cell.Icon.frame.origin.y+1, 121, 41);
        }
        cell.Icon.layer.cornerRadius = 115;//设置那个圆角的有多圆
        //不高亮显示
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}
//点击星球图片响应的方法
 -(void)goToModerators:(CustomImageView *)imageView
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTO" object:[NSString stringWithFormat: @"%d", imageView.tag-10]];
   // if (imageView.tag ==11) {
     //   NSLog(@"baozhaoxing");
   // }
}
-(void)goToPersonView:(CustomImageView *)imageView
{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTOPERSONALINFO" object:[NSString stringWithFormat: @"%d",imageView.tag]];
    
        NSLog(@"tag:%d",imageView.tag);
    //NSLog(@"PersonalView");
    
}
-(void)dealloc
{
    
    [myTableView release];
    [refreshView release];
    [dataArray release];
    [postArray release];
    [super dealloc];
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return;
//    } else {
//        NSLog(@"go to section %d",indexPath.row+1);
//    }
//}
/*
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FOOTHIDEORNOT" object:@"YES"];
}
//停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
        [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FOOTHIDEORNOT" object:@"NO"];
}
//当前是否正在刷新
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return isLoading;
}
//最后刷新时间
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    
    // 假设偏移表格高度的20%进行刷新
    if (!self.isLoading) { // 判断是否处于刷新状态，刷新中就不执行
        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = scrollView.contentSize.height > myTableView.frame.size.height ?myTableView.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            self.requestTimes ++;
            self.isLoading = YES;
            UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            testActivityIndicator.center = CGPointMake(VIEW_FRAME_WIDTH /2-20.0/1136.0*VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-50.0/1136.0*VIEW_FRAME_HEIGHT);//只能设置中心，不能设置大小
            [scrollView addSubview:testActivityIndicator];
            testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
           [testActivityIndicator startAnimating]; // 开始旋转
            [self setUserInteractionEnabled:NO];
            
            GetEssencePost *getPost = [[GetEssencePost alloc] init];
            [getPost getEssencePost:self.requestTimes];
            if ([dataArray count]>0) {
                [dataArray removeAllObjects];
            }
            postArray =[ NSMutableArray arrayWithArray:getPost.essnceArray];
            for (int i = 0; i < [postArray count]; i ++)
            {
                    MainTableItem * item = [[MainTableItem alloc] init];
                    item.collectNum = [[postArray  objectAtIndex:i] objectForKey:@"collectNum"];
                    item.Content =[[postArray  objectAtIndex:i] objectForKey:@"content"];
                    item.createTime =[[postArray  objectAtIndex:i] objectForKey:@"create_time"];
                    item.userName =[[postArray  objectAtIndex:i] objectForKey:@"customerName"];
                    item.userIcon =[[postArray  objectAtIndex:i] objectForKey:@"customerPortrait"];
                    item.userRegion =[[postArray  objectAtIndex:i] objectForKey:@"customerRegion"];
                    item.userID = [[postArray objectAtIndex:i] objectForKey:@"customer_id"];
                    item.contentID = [[postArray  objectAtIndex:i] objectForKey:@"id"];
                    item.moderators_id = [NSString stringWithFormat:@"%@",[[postArray objectAtIndex:i] objectForKey:@"moderators_id"]];
                    
                    // item.moderators_id = [[[dic objectForKey:@"post"] objectAtIndex:i] objectForKey:@"moderators_id"];
                    item.moderatorsName = [[postArray  objectAtIndex:i] objectForKey:@"moderatorsName"];
                    
                    item.Title =[[postArray  objectAtIndex:i] objectForKey:@"title"];
                    item.petName = [[postArray   objectAtIndex:i] objectForKey:@"petName"];
                    item.petAge = [[postArray   objectAtIndex:i] objectForKey:@"petAge"];
                    item.petBreed = [[postArray   objectAtIndex:i] objectForKey:@"petBreed"];
                    item.petIcon = [[postArray   objectAtIndex:i] objectForKey:@"petPortrait"];
                    item.petRace = [[postArray   objectAtIndex:i] objectForKey:@"petRace"];
                    item.petSex = [[postArray   objectAtIndex:i] objectForKey:@"petSex"];
                    item.imageArray = [[postArray   objectAtIndex:i] objectForKey:@"pics"];
                    item.praiseUserInfo = [[postArray   objectAtIndex:i] objectForKey:@"praiseCustomer"];
                    item.praiseNum = [[postArray   objectAtIndex:i] objectForKey:@"praiseNum"];
                    [dataArray addObject:item];
                    [item release];
                    //[self.moderatorsIdArray addObject:[[[dic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"moderators_id"]
            }
           // NSLog(@"%d count is:%d",requestTimes,[dataArray count]);

            [getPost release];
            
            [testActivityIndicator stopAnimating]; // 结束旋转
            [testActivityIndicator release];
            
            [myTableView reloadData];
            
            [self setUserInteractionEnabled:YES];
            
            if ([postArray count] != 0) {
                NSUInteger ii[2] = {0, 5*(requestTimes-1)+4};
                NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
                [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        }
        
        if (- scrollView.contentOffset.y /myTableView.frame.size.height > 0.2) {
            // 调用下拉刷新方法
            [refreshView egoRefreshScrollViewDidScroll:scrollView];

            
        }
        
    }
    
}

*/
/*
-(void)dealloc
{
    //[dataArray release];
   // [postArray release];
   // [fc release];
    //[mpc release];
   // [postDic release];
   // [customerIdArray release];
    //[customerNameArray release];
  //  [customerPortraitArray release];
  //  [titleArray release];
   // [contentArray release];
  //  [praiseNumArray release];
  //  [collectNumArray release];
  //  [totalArray release];
  //  [moderatorsIdArray release];
  //  [dic release];
    [table release];
    [super dealloc];
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
