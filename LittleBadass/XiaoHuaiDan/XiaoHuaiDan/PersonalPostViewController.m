//
//  PersonalPostViewController.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/27.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PersonalPostViewController.h"
#import "MainViewController.h"
#import "EditViewController.h"
#import "ContentViewController.h"
#import "GetMyPost.h"
#import "PersonalInfoViewController.h"
#import "PersonalPostViewController.h"
#import "UIImageView+WebCache.h"
#import "DeleteMyPost.h"

@interface PersonalPostViewController ()

@end

@implementation PersonalPostViewController
@synthesize isFromeMainPage,userName,userId,starIndex,starName,timeArray,time,titleName,tapTimes,starsview,postDic,table,postIdArray,customerIdArray,customerPortraitArray,titleArray,contentArray,praiseNumArray,collectNumArray,totalArray,moderatorsIdArray,picsArray,createTimeArray,petNameArray,petBirthArray,moderatorsId,requestTimes,isLoading,titleText,petPortraitArray,regions,petSexArray,petBreedArray,praiseArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postIdArray = [NSMutableArray arrayWithCapacity:0];
    self.customerIdArray = [NSMutableArray arrayWithCapacity:0];
    self.petNameArray = [NSMutableArray arrayWithCapacity:0];
    self.petBirthArray = [NSMutableArray arrayWithCapacity:0];
    self.customerPortraitArray = [NSMutableArray arrayWithCapacity:0];
    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    self.contentArray = [NSMutableArray arrayWithCapacity:0];
    self.praiseNumArray = [NSMutableArray arrayWithCapacity:0];
    self.collectNumArray = [NSMutableArray arrayWithCapacity:0];
    self.totalArray = [NSMutableArray arrayWithCapacity:0];
    self.moderatorsIdArray = [NSMutableArray arrayWithCapacity:0];
    self.picsArray = [NSMutableArray arrayWithCapacity:0];
    self.createTimeArray = [NSMutableArray arrayWithCapacity:0];
    self.postDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.petPortraitArray = [NSMutableArray arrayWithCapacity:0];
    self.regions = [NSMutableArray arrayWithCapacity:0];
    self.petSexArray = [NSMutableArray arrayWithCapacity:0];
    self.petBreedArray = [NSMutableArray arrayWithCapacity:0];
    self.timeArray = [NSMutableArray arrayWithCapacity:0];
    self.praiseArray = [NSMutableArray arrayWithCapacity:0];
    self.requestTimes = 1;
    
    GetMyPost *gmp = [[GetMyPost alloc] init];
    [gmp getMyPost:self.userId :1];
    
    
    self.postDic = [NSMutableDictionary dictionaryWithDictionary:gmp.myPostDic];
    
    for (int i = 0; i < [[postDic objectForKey:@"post"] count]; i ++) {
        [self.postIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"id"]];
        [self.customerIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customer_id"]];
        //    [self.customerNameArray addObject:[[[dic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerName"]];
        [self.customerPortraitArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerPortrait"]];
        [self.titleArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"title"]];
        [self.contentArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"content"]];
        [self.praiseNumArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"praiseNum"]];
        [self.collectNumArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"collectNum"]];
        [self.totalArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"total"]];
        [self.moderatorsIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"moderators_id"]];
        [self.picsArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"pics"]];
        [self.petNameArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petName"]];
        [self.petPortraitArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petPortrait"]];
        [self.regions addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerRegion"]];
        [self.petSexArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petSex"]];
        [self.petBreedArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petBreed"]];
        [self.timeArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"timeDiff"]];
        [self.praiseArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"praiseCustomer"]];
    }
    
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 61.0/1136.0*VIEW_FRAME_HEIGHT);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    editBtn.frame = CGRectMake(548.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT);
    [editBtn setBackgroundImage:[UIImage imageNamed:@"vector_smart_object.png"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:editBtn];
    
    self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(261.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 106.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"我的窝";
    titleText.textColor = [UIColor whiteColor];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
//    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    downBtn.frame = CGRectMake(372.0/640.0*VIEW_FRAME_WIDTH, 75.0/1136.0*VIEW_FRAME_HEIGHT, 29.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT);
//    [downBtn setBackgroundImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
//    [downBtn addTarget:self action:@selector(displayStars:) forControlEvents:UIControlEventTouchUpInside];
//    downBtn.tag = 66;
//    [barView addSubview:downBtn];
    
    [barView release];
    [titleText release];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    [table release];
    
    tapTimes = 0;
    self.isLoading = NO;
    
 
    
    [gmp release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    // 假设偏移表格高度的20%进行刷新
    
    
    
    if (!self.isLoading) { // 判断是否处于刷新状态，刷新中就不执行
        
        
        
        // 取内容的高度：
        
        //    如果内容高度大于UITableView高度，就取TableView高度
        
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        
        float height = scrollView.contentSize.height > self.table.frame.size.height ?self.table.frame.size.height : scrollView.contentSize.height;
        
        
        
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            
            // 调用上拉刷新方法
            
            self.requestTimes ++;
            self.isLoading = YES;
            
            [self.view setUserInteractionEnabled:NO];
            
            
            GetMyPost *gmp = [[GetMyPost alloc] init];
            [gmp getMyPost:self.userId :1];
            
            
            NSLog(@"%d,,,,%@",[[gmp.myPostDic objectForKey:@"post"] count],self.postDic);
            for (int i = 0; i < [[gmp.myPostDic objectForKey:@"post"]count]; i ++) {
                [self.postIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"id"]];
                [self.customerIdArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customer_id"]];
                //    [self.customerNameArray addObject:[[[dic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerName"]];
                [self.customerPortraitArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerPortrait"]];
                [self.titleArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"title"]];
                [self.contentArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"content"]];
                [self.praiseNumArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"praiseNum"]];
                [self.collectNumArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"collectNum"]];
                [self.totalArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"total"]];
                [self.moderatorsIdArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"moderators_id"]];
                [self.picsArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"pics"]];
                [self.petNameArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petName"]];
                [self.petPortraitArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petPortrait"]];
                [self.regions addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerRegion"]];
                [self.petSexArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petSex"]];
                [self.petBreedArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petBreed"]];
                [self.timeArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"timeDiff"]];
                [self.praiseArray addObject:[[[gmp.myPostDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"praiseCustomer"]];
            }
            
            [gmp release];
            
            
            [self.table reloadData];
            
            [self.view setUserInteractionEnabled:YES];
            
            NSUInteger ii[2] = {4*(requestTimes-1)+3, 0};
            NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
            [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        
        
        if (- scrollView.contentOffset.y / self.table.frame.size.height > 0.2) {
            
            // 调用下拉刷新方法
            
        }
        
    }
    
}

-(void)backToMain : (UIButton *)btn
{

    MainViewController *main = [[MainViewController alloc] init];
    [main showPersonalCenter:btn];
    [main.userBtn setBackgroundImage:[UIImage imageNamed:@"gata_press.png"] forState:UIControlStateNormal];
    [main.lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
    [main.mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
    [self presentViewController:main animated:NO completion:nil];
    [main release];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count;
    if ([self.postIdArray count]==0) {
        count = 0;
    }else{
        count = [self.postIdArray count];
    }
    return count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 510.0/1136.0*VIEW_FRAME_HEIGHT;
    }else
        return 122.0/1136.0*VIEW_FRAME_HEIGHT;
    //    return 632.0/1136.0*VIEW_FRAME_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0/1136.0*VIEW_FRAME_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake( 19.0/640.0*VIEW_FRAME_WIDTH, 0, 17, 15)];
        //        [cellView setBackgroundColor:[UIColor whiteColor]];
        //        cellView.layer.cornerRadius = 50;//设置那个圆角的有多圆
        //        cellView.layer.borderWidth = 19;//设置边框的宽度，当然可以不要
        //        [cell.contentView addSubview:cellView];
        
        if (indexPath.row == 0) {
            
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 33.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 81.0/640.0*VIEW_FRAME_WIDTH, 81.0/1136.0*VIEW_FRAME_HEIGHT)];
//            [headImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.petPortraitArray objectAtIndex:indexPath.section]]]]];
            [headImg setImageWithURL:[NSURL URLWithString:[self.petPortraitArray objectAtIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            headImg.layer.cornerRadius = headImg.bounds.size.width/2;
            headImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:headImg];
            
            UITextField *petName = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*VIEW_FRAME_WIDTH, 31.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 29.0/1136.0*VIEW_FRAME_HEIGHT)];
            petName.text = [self.petNameArray objectAtIndex:indexPath.section];
            petName.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [petName setEnabled:NO];
            [cell.contentView addSubview:petName];
            
            UIImageView *sexImg = [[UIImageView alloc] init];
            if ([[self.petSexArray objectAtIndex:indexPath.section] intValue] == 0) {
                [sexImg setFrame:CGRectMake( 228.0/640.0*VIEW_FRAME_WIDTH, 40.0/1136.0*VIEW_FRAME_HEIGHT, 26.0/640.0*VIEW_FRAME_WIDTH, 14.0/1136.0*VIEW_FRAME_HEIGHT)];
                [sexImg setImage:[UIImage imageNamed:@"bowknot.png"]];
            }else{
                [sexImg setFrame:CGRectMake( 228.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 20.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
                [sexImg setImage:[UIImage imageNamed:@"tie.png"]];
            }
            [cell.contentView addSubview:sexImg];
            
            UITextField *varieties = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            varieties.text = [self.petBreedArray objectAtIndex:indexPath.section];
            [varieties setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
            varieties.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [varieties setEnabled:NO];
            [cell.contentView addSubview:varieties];
            
            UIImageView *locaImg = [[UIImageView alloc] initWithFrame:CGRectMake( 261.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 20.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            [locaImg setImage:[UIImage imageNamed:@"pin.png"]];
            [cell.contentView addSubview:locaImg];
            
            UITextField *location = [[UITextField alloc] initWithFrame:CGRectMake( 291.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            location.text = [self.regions objectAtIndex:indexPath.section];
            [location setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
            location.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [location setEnabled:NO];
            [cell.contentView addSubview:location];
            
            UIImageView *peoImg = [[UIImageView alloc] initWithFrame:CGRectMake( 540.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 58.0/1136.0*VIEW_FRAME_HEIGHT)];
//            [peoImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.customerPortraitArray objectAtIndex:indexPath.section]]]]];
            [peoImg setImageWithURL:[NSURL URLWithString:[self.customerPortraitArray objectAtIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            peoImg.layer.cornerRadius = 5;//设置那个圆角的有多圆
            peoImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:peoImg];
            
            
            if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"day"] length] != 0) {
                self.time = [NSString stringWithFormat:@"%@天前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"day"]];
            }else if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"hour"] length] != 0){
                self.time = [NSString stringWithFormat:@"%@小时前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"hour"]];
            }else if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"min"] length] != 0){
                self.time = [NSString stringWithFormat:@"%@分钟前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"min"]];
            }
            
            UITextField *lastTime = [[UITextField alloc] initWithFrame:CGRectMake( 527.0/640.0*VIEW_FRAME_WIDTH, 85.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
            lastTime.text = self.time;
            [lastTime setFont:[UIFont fontWithName:@"Arial" size:9.0]];
            lastTime.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            lastTime.textAlignment = NSTextAlignmentCenter;
            [lastTime setEnabled:NO];
            [cell.contentView addSubview:lastTime];
            
            [headImg release];
            [petName release];
            [sexImg release];
            [varieties release];
            [locaImg release];
            [location release];
            [peoImg release];
            [lastTime release];
            
            
        }else if(indexPath.row == 1) {
            
            UIImageView *secImg = [[UIImageView alloc] initWithFrame:CGRectMake( 33.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 52.0/640.0*VIEW_FRAME_WIDTH, 52.0/1136.0*VIEW_FRAME_HEIGHT)];
            [secImg setImage:[UIImage imageNamed:@"phonto_icon.png"]];
            [cell.contentView addSubview:secImg];
            
            UITextField *title = [[UITextField alloc] initWithFrame:CGRectMake( 91.0/640.0*VIEW_FRAME_WIDTH, 35.0/1136.0*VIEW_FRAME_HEIGHT, 416.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
            title.text = [self.titleArray objectAtIndex:indexPath.section];
            [title setFont:[UIFont fontWithName:@"Arial" size:14.0]];
            //            title.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            [title setEnabled:NO];
            [cell.contentView addSubview:title];
            
            UIImageView *contImg = [[UIImageView alloc] initWithFrame:CGRectMake( 58.0/640.0*VIEW_FRAME_WIDTH, 82.0/1136.0*VIEW_FRAME_HEIGHT, 562.0/640.0*VIEW_FRAME_WIDTH, 362.0/1136.0*VIEW_FRAME_HEIGHT)];
            if ([[self.picsArray objectAtIndex:indexPath.section] count] != 0) {
//                [contImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.picsArray objectAtIndex:indexPath.section] objectAtIndex:0]]]]];
                [contImg setImageWithURL:[NSURL URLWithString:[[self.picsArray objectAtIndex:indexPath.section] objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                [cell.contentView addSubview:contImg];
            }
            
            
            UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            praiseBtn.frame = CGRectMake( 115.0/640.0*VIEW_FRAME_WIDTH, 458.0/1136.0*VIEW_FRAME_HEIGHT, 38.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT);
            [praiseBtn setBackgroundImage:[UIImage imageNamed:@"praise_icon.png"] forState:UIControlStateNormal];
            praiseBtn.tag = indexPath.section + 100;
            [praiseBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:praiseBtn];
            
            UITextField *praiseTxt = [[UITextField alloc] initWithFrame:CGRectMake( 162.0/640.0*VIEW_FRAME_WIDTH, 464.0/1136.0*VIEW_FRAME_HEIGHT, 45.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
            praiseTxt.text = (NSString *)[self.praiseNumArray objectAtIndex:indexPath.section];
            [praiseTxt setFont:[UIFont fontWithName:@"Arial" size:12.0]];
            praiseTxt.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            [praiseTxt setEnabled:NO];
            [cell.contentView addSubview:praiseTxt];
            
            UIButton *colBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            colBtn.frame = CGRectMake( 421.0/640.0*VIEW_FRAME_WIDTH-100.0/640.0*VIEW_FRAME_WIDTH, 458.0/1136.0*VIEW_FRAME_HEIGHT, 32.0/640.0*VIEW_FRAME_WIDTH, 34.0/1136.0*VIEW_FRAME_HEIGHT);
            [colBtn setBackgroundImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:colBtn];

            UITextField *colTxt = [[UITextField alloc] initWithFrame:CGRectMake( 465.0/640.0*VIEW_FRAME_WIDTH-100.0/640.0*VIEW_FRAME_WIDTH, 464.0/1136.0*VIEW_FRAME_HEIGHT, 45.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
            colTxt.text = [self.collectNumArray objectAtIndex:indexPath.section];
            [colTxt setFont:[UIFont fontWithName:@"Arial" size:12.0]];
            colTxt.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            [colTxt setEnabled:NO];
            [cell.contentView addSubview:colTxt];
            
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            deleteBtn.frame = CGRectMake( 421.0/640.0*VIEW_FRAME_WIDTH+100.0/640.0*VIEW_FRAME_WIDTH, 458.0/1136.0*VIEW_FRAME_HEIGHT, 32.0/640.0*VIEW_FRAME_WIDTH, 34.0/1136.0*VIEW_FRAME_HEIGHT);
            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            deleteBtn.tag = 200+indexPath.section;
            [deleteBtn addTarget:self action:@selector(deleteMyPost:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:deleteBtn];
            
            [secImg release];
            [title release];
            [contImg release];
            [colTxt release];
            [praiseTxt release];
            
        }
    }
    
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    btn.frame = CGRectMake( 160*i+134, 0, 17, 15);
    //    [btn setTitle:@"111" forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    //    [cellView addSubview:btn];
    
    
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row
    //                           ];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.section);
    if (indexPath.row == 1) {
        
        ContentViewController *content = [[ContentViewController alloc] init];
        content.starName = self.titleName;
        content.starIndex = self.moderatorsId;
        content.postId = [[self.postIdArray objectAtIndex:indexPath.section] intValue];
        content.praiseNum = [[self.praiseNumArray objectAtIndex:indexPath.section] intValue];
        content.postUserId = [[self.customerIdArray objectAtIndex:indexPath.section] intValue];
        content.content = [self.contentArray objectAtIndex:indexPath.section];
        content.postTitle = [self.titleArray objectAtIndex:indexPath.section];
        content.pics = [NSMutableArray arrayWithArray:[self.picsArray objectAtIndex:indexPath.section]];
        content.petNameTxt = [self.petNameArray objectAtIndex:indexPath.section];
        content.petPortrait = [self.petPortraitArray objectAtIndex:indexPath.section];
        content.usrPortrait = [self.customerPortraitArray objectAtIndex:indexPath.section];
        if ([[self.picsArray objectAtIndex:indexPath.section] count] != 0) {
            content.image = [[self.picsArray objectAtIndex:indexPath.section]objectAtIndex:0];
        }
        content.usrId = [[self.customerIdArray objectAtIndex:indexPath.section] intValue];
        content.region = [self.regions objectAtIndex:indexPath.section];
        content.breed = [self.petBreedArray objectAtIndex:indexPath.section];
        content.petSex = [[self.petSexArray objectAtIndex:indexPath.section] intValue];
        content.isPersonalPost = YES;
        content.praiseArray = [NSMutableArray arrayWithArray:[self.praiseArray objectAtIndex:indexPath.section]];
        
        if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"day"] length] != 0) {
            self.time = [NSString stringWithFormat:@"%@天前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"day"]];
        }else if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"hour"] length] != 0){
            self.time = [NSString stringWithFormat:@"%@小时前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"hour"]];
        }else if ([[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"min"] length] != 0){
            self.time = [NSString stringWithFormat:@"%@分钟前",[[self.timeArray objectAtIndex:indexPath.section] objectForKey:@"min"]];
        }
        content.timeTxt = self.time;
        
        [self presentViewController:content animated:NO completion:nil];
        [content release];
    } else
        return;
    
}

//自定义圆角边框
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView) {    // self.tableview
            CGFloat cornerRadius = 5.0f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 20.0/640*VIEW_FRAME_WIDTH, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+5, bounds.size.height-lineHeight, bounds.size.width-5, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

-(void)btnTap:(UIButton *)btn
{
    NSLog(@"111");
}

-(void)deleteMyPost:(UIButton *)btn
{
    if ([self.postIdArray objectAtIndex:btn.tag-200]) {
        DeleteMyPost *dmp = [[DeleteMyPost alloc] init];
        [dmp deleteMyPost:[[self.postIdArray objectAtIndex:btn.tag-200] intValue]];
    }

    [self.postIdArray removeObjectAtIndex:btn.tag-200];
    [self.customerIdArray removeObjectAtIndex:btn.tag-200];
    [self.customerPortraitArray removeObjectAtIndex:btn.tag-200];
    [self.titleArray removeObjectAtIndex:btn.tag-200];
    [self.contentArray removeObjectAtIndex:btn.tag-200];
    [self.praiseNumArray removeObjectAtIndex:btn.tag-200];
    [self.collectNumArray removeObjectAtIndex:btn.tag-200];
    [self.totalArray removeObjectAtIndex:btn.tag-200];
    [self.moderatorsIdArray removeObjectAtIndex:btn.tag-200];
    [self.picsArray removeObjectAtIndex:btn.tag-200];
    [self.petNameArray removeObjectAtIndex:btn.tag-200];
    [self.petPortraitArray removeObjectAtIndex:btn.tag-200];
    [self.regions removeObjectAtIndex:btn.tag-200];
    [self.petSexArray removeObjectAtIndex:btn.tag-200];
    [self.petBreedArray removeObjectAtIndex:btn.tag-200];
    [self.timeArray removeObjectAtIndex:btn.tag-200];
    [self.praiseArray removeObjectAtIndex:btn.tag-200];
    
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:btn.tag-200];
    [self.table deleteSections:index withRowAnimation:UITableViewRowAnimationRight];
    [self.table reloadData];
}

//-(void)displayStars:(UIButton *)btn
//{
//    if (tapTimes == 0) {
//        self.starsview = [[UIView alloc] initWithFrame:CGRectMake(0, 128.0/1136.0*VIEW_FRAME_HEIGHT, self.view.frame.size.width, 450.0/1136.0*VIEW_FRAME_HEIGHT)];
//        [starsview setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.65]];
//        [self.view addSubview:starsview];
//        
//        UIButton *starOne = [UIButton buttonWithType:UIButtonTypeSystem];
//        starOne.frame = CGRectMake( 60.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT, 121.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
//        [starOne setBackgroundImage:[UIImage imageNamed:@"tweeta_a.png"] forState:UIControlStateNormal];
//        [starOne addTarget:self action:@selector(chooseMederator:) forControlEvents:UIControlEventTouchUpInside];
//        starOne.tag = 70+3;
//        [starsview addSubview:starOne];
//        
//        UITextField *oneTxt = [[UITextField alloc] initWithFrame:CGRectMake( 80.0/640.0*VIEW_FRAME_WIDTH, 182.0/1136.0*VIEW_FRAME_HEIGHT, 82.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
//        oneTxt.text = @"吐槽星";
//        [oneTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0]];
//        oneTxt.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//        [oneTxt setEnabled:NO];
//        [starsview addSubview:oneTxt];
//        
//        UIButton *starTwo = [UIButton buttonWithType:UIButtonTypeSystem];
//        starTwo.frame = CGRectMake( 260.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT, 121.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
//        [starTwo setBackgroundImage:[UIImage imageNamed:@"photo_a.png"] forState:UIControlStateNormal];
//        [starTwo addTarget:self action:@selector(chooseMederator:) forControlEvents:UIControlEventTouchUpInside];
//        starTwo.tag = 70+1;
//        [starsview addSubview:starTwo];
//        
//        UITextField *twoTxt = [[UITextField alloc] initWithFrame:CGRectMake( 277.0/640.0*VIEW_FRAME_WIDTH, 182.0/1136.0*VIEW_FRAME_HEIGHT, 82.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
//        twoTxt.text = @"爆照星";
//        [twoTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0]];
//        twoTxt.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//        [twoTxt setEnabled:NO];
//        [starsview addSubview:twoTxt];
//        
//        UIButton *starThr = [UIButton buttonWithType:UIButtonTypeSystem];
//        starThr.frame = CGRectMake( 459.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT, 121.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
//        [starThr setBackgroundImage:[UIImage imageNamed:@"wang_a.png"] forState:UIControlStateNormal];
//        [starThr addTarget:self action:@selector(chooseMederator:) forControlEvents:UIControlEventTouchUpInside];
//        starThr.tag = 70+4;
//        [starsview addSubview:starThr];
//        
//        UITextField *thrTxt = [[UITextField alloc] initWithFrame:CGRectMake( 476.0/640.0*VIEW_FRAME_WIDTH, 182.0/1136.0*VIEW_FRAME_HEIGHT, 82.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
//        thrTxt.text = @"汪汪星";
//        [thrTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0]];
//        thrTxt.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//        [thrTxt setEnabled:NO];
//        [starsview addSubview:thrTxt];
//        
//        UIButton *starFou = [UIButton buttonWithType:UIButtonTypeSystem];
//        starFou.frame = CGRectMake( 157.0/640.0*VIEW_FRAME_WIDTH, 244.0/1136.0*VIEW_FRAME_HEIGHT, 121.0/640.0*VIEW_FRAME_WIDTH, 122.0/1136.0*VIEW_FRAME_HEIGHT);
//        [starFou setBackgroundImage:[UIImage imageNamed:@"meowth_a.png"] forState:UIControlStateNormal];
//        [starFou addTarget:self action:@selector(chooseMederator:) forControlEvents:UIControlEventTouchUpInside];
//        starFou.tag = 70+2;
//        [starsview addSubview:starFou];
//        
//        UITextField *fouTxt = [[UITextField alloc] initWithFrame:CGRectMake( 181.0/640.0*VIEW_FRAME_WIDTH, 385.0/1136.0*VIEW_FRAME_HEIGHT, 81.0/640.0*VIEW_FRAME_WIDTH, 27.0/1136.0*VIEW_FRAME_HEIGHT)];
//        fouTxt.text = @"喵喵星";
//        [fouTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0]];
//        fouTxt.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//        [fouTxt setEnabled:NO];
//        [starsview addSubview:fouTxt];
//        
//        UIButton *starFiv = [UIButton buttonWithType:UIButtonTypeSystem];
//        starFiv.frame = CGRectMake( 358.0/640.0*VIEW_FRAME_WIDTH, 244.0/1136.0*VIEW_FRAME_HEIGHT, 121.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
//        [starFiv setBackgroundImage:[UIImage imageNamed:@"feeds_a.png"] forState:UIControlStateNormal];
//        [starFiv addTarget:self action:@selector(chooseMederator:) forControlEvents:UIControlEventTouchUpInside];
//        starThr.tag = 70+5;
//        [starsview addSubview:starFiv];
//        
//        UITextField *fivTxt = [[UITextField alloc] initWithFrame:CGRectMake( 379.0/640.0*VIEW_FRAME_WIDTH, 385.0/1136.0*VIEW_FRAME_HEIGHT, 81.0/640.0*VIEW_FRAME_WIDTH, 27.0/1136.0*VIEW_FRAME_HEIGHT)];
//        fivTxt.text = @"代养星";
//        [fivTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:13.0]];
//        fivTxt.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//        [fivTxt setEnabled:NO];
//        [starsview addSubview:fivTxt];
//        
//        [starsview release];
//        [oneTxt release];
//        [twoTxt release];
//        [thrTxt release];
//        [fouTxt release];
//        [fivTxt release];
//        
//        [self.view addSubview:self.starsview];
//        
//        //        starsview.hidden = NO;
//        
//        [btn setBackgroundImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
//        
//        tapTimes ++;
//        
//    }else if (tapTimes > 0){
//        
//        [self.starsview removeFromSuperview];
//        
//        //        starsview.hidden = YES;
//        
//        [btn setBackgroundImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
//        
//        tapTimes = 0;
//    }
//}

-(void)edit:(UIButton *)btn
{
    EditViewController *edit = [[EditViewController alloc] init];
    edit.starName = self.titleName;
    [self presentViewController:edit animated:YES completion:nil];
    [edit release];
}

-(void)collect:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
}

//-(void)chooseMederator:(UIButton *)btn
//{
//    [self.postIdArray removeAllObjects];
//    [self.customerIdArray removeAllObjects];
//    [self.petNameArray removeAllObjects];
//    [self.petBirthArray removeAllObjects];
//    [self.customerPortraitArray removeAllObjects];
//    [self.titleArray removeAllObjects];
//    [self.contentArray removeAllObjects];
//    [self.praiseNumArray removeAllObjects];
//    [self.collectNumArray removeAllObjects];
//    [self.totalArray removeAllObjects];
//    [self.moderatorsIdArray removeAllObjects];
//    [self.picsArray removeAllObjects];
//    [self.createTimeArray removeAllObjects];
//    [self.postDic removeAllObjects];
//    
//    [self.table reloadData];
//    
//    GetMederatorPost *gmp = [[GetMederatorPost alloc] init];
//    gmp.mederatorIndex = btn.tag-70;
//    NSLog(@"%d",btn.tag-70);
//    [gmp getMederatorPost:requestTimes];
//    
//    self.postDic = [NSMutableDictionary dictionaryWithDictionary:gmp.mederatorPostDic];
//    
//    for (int i = 0; i < [[postDic objectForKey:@"post"] count]; i ++) {
//        [self.postIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"id"]];
//        [self.customerIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customer_id"]];
//        //    [self.customerNameArray addObject:[[[dic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerName"]];
//        [self.customerPortraitArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"customerPortrait"]];
//        [self.titleArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"title"]];
//        [self.contentArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"content"]];
//        [self.praiseNumArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"praiseNum"]];
//        [self.collectNumArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"collectNum"]];
//        [self.totalArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"total"]];
//        [self.moderatorsIdArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"moderators_id"]];
//        [self.picsArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"pics"]];
//        [self.petNameArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petName"]];
//        [self.petSexArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petSex"]];
//        [self.petBreedArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"petBreed"]];
//        [self.timeArray addObject:[[[postDic objectForKey:@"post"]  objectAtIndex:i] objectForKey:@"timeDiff"]];
//    }
//    
//    
//    if (btn.tag-70 == 1 ) {
//        self.titleName = @"爆照星";
//        self.titleText.text = @"爆照星";
//    }else if (btn.tag-70 == 2 ) {
//        self.titleName = @"喵喵星";
//        self.titleText.text = @"喵喵星";
//    }else if (btn.tag-70 == 3 ) {
//        self.titleName = @"吐槽星";
//        self.titleText.text = @"吐槽星";
//    }else if (btn.tag-70 == 4 ) {
//        self.titleName = @"汪汪星";
//        self.titleText.text = @"汪汪星";
//    }else if (btn.tag-70 == 5 ) {
//        self.titleName = @"代养星";
//        self.titleText.text = @"代养星";
//    }
//    
//    [self.table reloadData];
//    
//    [self.starsview removeFromSuperview];
//    
//    UIButton *button = (UIButton *)[self.view viewWithTag:66];
//    [button setBackgroundImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
//    
//    tapTimes = 0;
//    
//    [gmp release];
//}

-(void)dealloc
{
    [titleText release];
    [table release];
    [postDic release];
    [titleName release];
    [starsview release];
    [postIdArray release];
    [customerIdArray release];
    [petNameArray release];
    [petBirthArray release];
    [customerPortraitArray release];
    [titleArray release];
    [contentArray release];
    [praiseNumArray release];
    [collectNumArray release];
    [totalArray release];
    [moderatorsIdArray release];
    [picsArray release];
    [createTimeArray release];
    [petPortraitArray release];
    [regions release];
    [petBreedArray release];
    [petSexArray release];
    [time release];
    [timeArray release];
    [starName release];
    [userName release];
    [praiseArray release];
    [super dealloc];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
