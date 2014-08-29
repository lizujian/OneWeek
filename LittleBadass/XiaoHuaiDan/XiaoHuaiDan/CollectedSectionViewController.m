//
//  CollectedSectionViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-26.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "CollectedSectionViewController.h"
#import "MainViewController.h"
#import "PersonalInfoViewController.h"
#import "GetMyCollection.h"

@interface CollectedSectionViewController ()

@end

@implementation CollectedSectionViewController
@synthesize userId,starName,starIndex,collectDic,isFromeMainPage;

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
    
    GetMyCollection *getCollection = [[GetMyCollection alloc] init];
    [getCollection getMyCollection:self.userId :1];
    self.collectDic = [NSMutableDictionary dictionaryWithDictionary:getCollection.myColDic];
    [getCollection release];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"收藏贴";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*320.0, 53.0/1136.0*568.0, 63.0/640.0*320.0, 61.0/1136.0*568.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
//    UIButton *attBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    attBtn.frame = CGRectMake(548.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT);
//    [attBtn setBackgroundImage:[UIImage imageNamed:@"preview_icon.png"] forState:UIControlStateNormal];
//    [barView addSubview:attBtn];
    
    [barView release];
    [titleText release];

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    //    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    [table release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.collectDic objectForKey:@"post"] count] ;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *secImg = [[UIImageView alloc] initWithFrame:CGRectMake( 20.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
        
        if ([[self.collectDic objectForKey:@"post"] count] != 0) {
            if ([[[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"moderatorsName"] isEqualToString:@"爆照星"]) {
                [secImg setImage:[UIImage imageNamed:@"phonto_icon.png"]];
            }else if ([[[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"moderatorsName"] isEqualToString:@"喵喵星"]){
                [secImg setImage:[UIImage imageNamed:@"meowth_c.png"]];
            }else if ([[[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"moderatorsName"] isEqualToString:@"吐槽星"]){
                [secImg setImage:[UIImage imageNamed:@"talk_icon.png"]];
            }else if ([[[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"moderatorsName"] isEqualToString:@"汪汪星"]){
                [secImg setImage:[UIImage imageNamed:@"talk_icon.png"]];
            }else{
                [secImg setImage:[UIImage imageNamed:@"feeds_c.png"]];
            }

        }

        [cell.contentView addSubview:secImg];
        
        UITextField *conText = [[UITextField alloc] initWithFrame:CGRectMake(79.0/640.0*VIEW_FRAME_WIDTH, 41.0/1136.0*VIEW_FRAME_HEIGHT, 412.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.collectDic objectForKey:@"post"] count] != 0) {
            conText.text = [[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"title"];
        }
        
        conText.textColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
        [conText setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0]];
        [conText setEnabled:NO];
        [cell.contentView addSubview:conText];
        
        UIImageView *loveImg = [[UIImageView alloc] initWithFrame:CGRectMake( 521.0/640.0*VIEW_FRAME_WIDTH, 31.0/1136.0*VIEW_FRAME_HEIGHT, 34.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
        [loveImg setImage:[UIImage imageNamed:@"praise_icon.png"]];
        [cell.contentView addSubview:loveImg];
        
        UIImageView *replyImg = [[UIImageView alloc] initWithFrame:CGRectMake( 584.0/640.0*VIEW_FRAME_WIDTH, 27.0/1136.0*VIEW_FRAME_HEIGHT, 32.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT)];
        [replyImg setImage:[UIImage imageNamed:@"collect_icon.png"]];
        [cell.contentView addSubview:replyImg];
        
        UILabel *loveNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 518.0/640.0*VIEW_FRAME_WIDTH, 66.0/1136.0*VIEW_FRAME_HEIGHT, 42.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.collectDic objectForKey:@"post"] count] != 0) {
            loveNumLbl.text = [[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"praiseNum"];
        }
        loveNumLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        loveNumLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        loveNumLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:loveNumLbl];
        
        UILabel *repNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 580.0/640.0*VIEW_FRAME_WIDTH, 66.0/1136.0*VIEW_FRAME_HEIGHT, 42.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.collectDic objectForKey:@"post"] count] != 0) {
            repNumLbl.text = [[[self.collectDic objectForKey:@"post"] objectAtIndex:indexPath.row] objectForKey:@"collectNum"];
        }
        repNumLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        repNumLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        repNumLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:repNumLbl];
            
        [secImg release];
        [conText release];
        [loveImg release];
        [replyImg release];
        [loveNumLbl release];
        [repNumLbl release];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)back:(UIButton *)btn
{
    if (isFromeMainPage) {
        MainViewController *main = [[MainViewController alloc] init];
        [main showPersonalCenter:btn];
        [main.userBtn setBackgroundImage:[UIImage imageNamed:@"gata_press.png"] forState:UIControlStateNormal];
        [main.lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
        [main.mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
        [self presentViewController:main animated:NO completion:nil];
        [main release];
    } else {
        PersonalInfoViewController *pivc = [[PersonalInfoViewController alloc] init];
        pivc.starName = self.starName;
        pivc.starIndex = self.starIndex;
        pivc.userId = self.userId;
        [self presentViewController:pivc animated:NO completion:nil];
        [pivc release];

    }
}

-(void)dealloc
{
    [collectDic release];
    [starName release];
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
