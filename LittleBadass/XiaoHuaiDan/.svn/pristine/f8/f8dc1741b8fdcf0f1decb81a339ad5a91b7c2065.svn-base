//
//  LoginViewController.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/29.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "SignViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
     
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
        
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(30.0/640.0*320.0, 56.0/1136.0*568.0, 60.0/640.0*320.0, 60.0/1136.0*568.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backToPost:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIImageView *loginCatImg = [[UIImageView alloc] initWithFrame:CGRectMake( 70.0/640.0*VIEW_FRAME_WIDTH, 222.0/1136.0*VIEW_FRAME_HEIGHT, 206.0/640.0*VIEW_FRAME_WIDTH, 212.0/1136.0*VIEW_FRAME_HEIGHT)];
    [loginCatImg setImage:[UIImage imageNamed:@"login_cat.png"]];
    [self.view addSubview:loginCatImg];
    
    [loginCatImg release];
    
    UIImageView *loginCardImg = [[UIImageView alloc] initWithFrame:CGRectMake( 344.0/640.0*VIEW_FRAME_WIDTH, 124.0/1136.0*VIEW_FRAME_HEIGHT, 236.0/640.0*VIEW_FRAME_WIDTH, 284.0/1136.0*VIEW_FRAME_HEIGHT)];
    [loginCardImg setImage:[UIImage imageNamed:@"login_card.png"]];
    [self.view addSubview:loginCardImg];
    
    UILabel *loginLbl = [[UILabel alloc] initWithFrame:CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH, 100.0/1136.0*VIEW_FRAME_HEIGHT, 165.0/640.0*VIEW_FRAME_WIDTH, 40.0/1136.0*VIEW_FRAME_HEIGHT)];
    loginLbl.text = @"星球登陆";
    loginLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:19.0];
    loginLbl.textColor = [UIColor colorWithRed:115.0/255.0 green:56.0/255.0 blue:46.0/255.0 alpha:1.0];
    loginLbl.textAlignment = NSTextAlignmentCenter;
    [loginCardImg addSubview:loginLbl];
    
    UILabel *chooseLbl = [[UILabel alloc] initWithFrame:CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH, 165.0/1136.0*VIEW_FRAME_HEIGHT, 165.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
    chooseLbl.text = @"请选择下方合作账号登陆";
    chooseLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    chooseLbl.textColor = [UIColor colorWithRed:115.0/255.0 green:56.0/255.0 blue:46.0/255.0 alpha:1.0];
    chooseLbl.textAlignment = NSTextAlignmentCenter;
    chooseLbl.lineBreakMode = UILineBreakModeWordWrap;
    chooseLbl.numberOfLines = 2;
    [loginCardImg addSubview:chooseLbl];
    
    [loginCardImg release];
    [loginLbl release];
    [chooseLbl release];
    
    UIImageView *loginShelfImg = [[UIImageView alloc] initWithFrame:CGRectMake( 14.0/640.0*VIEW_FRAME_WIDTH, 434.0/1136.0*VIEW_FRAME_HEIGHT, 616.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
    [loginShelfImg setImage:[UIImage imageNamed:@"login_shelf.png"]];
    [self.view addSubview:loginShelfImg];
    
    [loginShelfImg release];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake( 109.0/640.0*VIEW_FRAME_WIDTH, 467.0/1136.0*VIEW_FRAME_HEIGHT, 4.0/640.0*VIEW_FRAME_WIDTH, 280.0/1136.0*VIEW_FRAME_HEIGHT)];
    [line setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:228.0/255.0 blue:220.0/255.0 alpha:1.0]];
    [self.view addSubview:line];
    
    [line release];
    
    UIImageView *fish = [[UIImageView alloc] initWithFrame:CGRectMake( 30.0/640.0*VIEW_FRAME_WIDTH, 740.0/1136.0*VIEW_FRAME_HEIGHT, 160.0/640.0*VIEW_FRAME_WIDTH, 110.0/1136.0*VIEW_FRAME_HEIGHT)];
    [fish setImage:[UIImage imageNamed:@"login_fish.png"]];
    [fish setUserInteractionEnabled:YES];
    [self.view addSubview:fish];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    qqBtn.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH, 35.0/1136.0*VIEW_FRAME_HEIGHT, 40.0/640.0*VIEW_FRAME_WIDTH, 44.0/1136.0*VIEW_FRAME_HEIGHT);
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qqlogo.png"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [fish addSubview:qqBtn];
    
    [fish release];
    
    UIImageView *linee = [[UIImageView alloc] initWithFrame:CGRectMake( 255.0/640.0*VIEW_FRAME_WIDTH, 467.0/1136.0*VIEW_FRAME_HEIGHT, 4.0/640.0*VIEW_FRAME_WIDTH, 396.0/1136.0*VIEW_FRAME_HEIGHT)];
    [linee setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:228.0/255.0 blue:220.0/255.0 alpha:1.0]];
    [self.view addSubview:linee];
    
    [linee release];
    
    UIImageView *fishh = [[UIImageView alloc] initWithFrame:CGRectMake( 176.0/640.0*VIEW_FRAME_WIDTH, 856.0/1136.0*VIEW_FRAME_HEIGHT, 160.0/640.0*VIEW_FRAME_WIDTH, 110.0/1136.0*VIEW_FRAME_HEIGHT)];
    [fishh setImage:[UIImage imageNamed:@"login_fish.png"]];
    [fishh setUserInteractionEnabled:YES];
    [self.view addSubview:fishh];
    
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sinaBtn.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH, 35.0/1136.0*VIEW_FRAME_HEIGHT, 46.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT);
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"weibo_logo.png"] forState:UIControlStateNormal];
    //    [qqBtn addTarget:self action:@selector(backToPost:) forControlEvents:UIControlEventTouchUpInside];
    [fishh addSubview:sinaBtn];
    
    [fishh release];
    
    UIImageView *lineee = [[UIImageView alloc] initWithFrame:CGRectMake( 401.0/640.0*VIEW_FRAME_WIDTH, 467.0/1136.0*VIEW_FRAME_HEIGHT, 4.0/640.0*VIEW_FRAME_WIDTH, 198.0/1136.0*VIEW_FRAME_HEIGHT)];
    [lineee setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:228.0/255.0 blue:220.0/255.0 alpha:1.0]];
    [self.view addSubview:lineee];
    
    [lineee release];
    
    UIImageView *fishhh = [[UIImageView alloc] initWithFrame:CGRectMake( 318.0/640.0*VIEW_FRAME_WIDTH, 622.0/1136.0*VIEW_FRAME_HEIGHT, 160.0/640.0*VIEW_FRAME_WIDTH, 110.0/1136.0*VIEW_FRAME_HEIGHT)];
    [fishhh setImage:[UIImage imageNamed:@"login_fish.png"]];
    [fishhh setUserInteractionEnabled:YES];
    [self.view addSubview:fishhh];
    
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    weixinBtn.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH, 35.0/1136.0*VIEW_FRAME_HEIGHT, 46.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT);
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
    //    [qqBtn addTarget:self action:@selector(backToPost:) forControlEvents:UIControlEventTouchUpInside];
    [fishhh addSubview:weixinBtn];
    
    [fishhh release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)login:(UIButton *)btn
{
    SignViewController *sign = [[SignViewController alloc] init];
    [self presentViewController:sign animated:NO completion:nil];
    [sign release];
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
