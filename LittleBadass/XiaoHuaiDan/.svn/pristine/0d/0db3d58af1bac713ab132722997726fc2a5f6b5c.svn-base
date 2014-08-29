//
//  AttentionViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-26.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "AttentionViewController.h"
#import "MainViewController.h"
#import "PersonalInfoViewController.h"
#import "GetMyFocus.h"

@interface AttentionViewController ()

@end

@implementation AttentionViewController
@synthesize userId,starName,starIndex,focusDic,isFromeMainPage;

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
    
    GetMyFocus *getFocus = [[GetMyFocus alloc] init];
    int page = 1;
    NSLog(@"%d",self.userId);
    [getFocus getMyFocus:self.userId :page];
    
    self.focusDic = [NSMutableDictionary dictionaryWithDictionary:getFocus.myFocusDic];
    [getFocus release];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"关注";
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
    return [[self.focusDic objectForKey:@"fans"] count] ;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0/1136.0*VIEW_FRAME_HEIGHT;
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
        
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 20.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.focusDic objectForKey:@"fans"] count] != 0) {
            NSString *str = [[[self.focusDic objectForKey:@"fans"] objectAtIndex:indexPath.row] objectForKey:@"portraitUrl"];
            [headImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]]];
        }
        [cell.contentView addSubview:headImg];
        
        UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(106.0/640.0*VIEW_FRAME_WIDTH, 27.0/1136.0*VIEW_FRAME_HEIGHT, 84.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.focusDic objectForKey:@"fans"] count] != 0) {
            nameText.text = [[[self.focusDic objectForKey:@"fans"] objectAtIndex:indexPath.row] objectForKey:@"username"];
        }
        nameText.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
        [nameText setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0]];
        [nameText setEnabled:NO];
        [cell.contentView addSubview:nameText];
        
        UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake( 102.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT, 20.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.focusDic objectForKey:@"fans"] count] != 0) {
            if ([[[[self.focusDic objectForKey:@"fans"] objectAtIndex:indexPath.row] objectForKey:@"sex"] intValue] == 0) {
                [sexImg setImage:[UIImage imageNamed:@"girl_02.png"]];
            }else
            {
                [sexImg setImage:[UIImage imageNamed:@"manz-02.png"]];
            }
        }
        [cell.contentView addSubview:sexImg];
        
        UILabel *sexLbl = [[UILabel alloc] initWithFrame:CGRectMake( 130.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.focusDic objectForKey:@"fans"] count] != 0) {
            if ([[[[self.focusDic objectForKey:@"fans"] objectAtIndex:indexPath.row] objectForKey:@"sex"] intValue] == 0) {
                sexLbl.text = @"妹子";
            }else
            {
                sexLbl.text = @"帅哥";
            }
        }
        
        sexLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        sexLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
//        sexLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:sexLbl];
        
        UIImageView *locImg = [[UIImageView alloc] initWithFrame:CGRectMake( 192.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT, 18.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
        [locImg setImage:[UIImage imageNamed:@"pin.png"]];
        [cell.contentView addSubview:locImg];
        
        UILabel *locaLbl = [[UILabel alloc] initWithFrame:CGRectMake(210.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT)];
        if ([[self.focusDic objectForKey:@"fans"] count] != 0) {
            locaLbl.text = [[[self.focusDic objectForKey:@"fans"] objectAtIndex:indexPath.row] objectForKey:@"regionName"];
        }
        locaLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        locaLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        locaLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:locaLbl];
        
        UIImageView *attImg = [[UIImageView alloc] initWithFrame:CGRectMake( 562.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 60.0/1136.0*VIEW_FRAME_HEIGHT)];
        [attImg setImage:[UIImage imageNamed:@"preview.png"]];
        [cell.contentView addSubview:attImg];
        
        [headImg release];
        [nameText release];
        [sexImg release];
        [locImg release];
        [sexLbl release];
        [locaLbl release];
        [attImg release];
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
    [starName release];
    [focusDic release];
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
