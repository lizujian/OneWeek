//
//  FotoWallViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-27.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "FotoWallViewController.h"
#import "MainViewController.h"
#import "PersonalInfoViewController.h"

@interface FotoWallViewController ()

@end

@implementation FotoWallViewController
@synthesize isFromeMainPage,fotoDic,starName,starIndex,userId;

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
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"照片墙";
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
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    [table release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    }else{
        PersonalInfoViewController *pivc = [[PersonalInfoViewController alloc] init];
        pivc.starName = self.starName;
        pivc.starIndex = self.starIndex;
        pivc.userId = self.userId;
        [self presentViewController:pivc animated:NO completion:nil];
        [pivc release];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.0/1136.0*VIEW_FRAME_HEIGHT;
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
        
        for (int i = 0; i < 3; i ++) {
            
            UIButton *fotoImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            fotoImgBtn.frame = CGRectMake(10.0/640.0*VIEW_FRAME_WIDTH*(i+1) + 200.0/640.0*VIEW_FRAME_WIDTH*i , 20.0/1136.0*VIEW_FRAME_HEIGHT, 200.0/640.0*VIEW_FRAME_WIDTH, 200.0/1136.0*VIEW_FRAME_HEIGHT);
//            [attBtn setBackgroundImage:[UIImage imageNamed:@"preview_icon.png"] forState:UIControlStateNormal];
            [fotoImgBtn setBackgroundColor:[UIColor lightGrayColor]];
            [cell.contentView addSubview:fotoImgBtn];
            
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    
}

-(void)dealloc
{
    [starName release];
    [fotoDic release];
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
