//
//  ThirdPlatformViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ThirdPlatformViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "publicFunction.h"
#import <ShareSDK/ShareSDK.h>
@interface ThirdPlatformViewController ()

@end

@implementation ThirdPlatformViewController
@synthesize table,isLogWithQQ,isLogWithBaidu,isLogWithRenren,isLogWithSina;

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 61.0/1136.0*VIEW_FRAME_HEIGHT);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToSet:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(261.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"第三方账号";
    titleText.textColor = [UIColor whiteColor];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    [barView release];
    [titleText release];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 360.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.scrollEnabled = NO;
    //    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToSet:(UIButton *)btn
{
    SettingViewController *set = [[SettingViewController alloc] init];
    [self presentViewController:set animated:YES completion:nil];
    [set release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0/1136.0*VIEW_FRAME_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   ShareTypeSinaWeibo = 1,         /**< 新浪微博 */
    //	ShareTypeQQSpace = 6,           /**< QQ空间 */
    //	ShareTypeRenren = 7,            /**< 人人网 */
    //    ShareTypeQQ = 24,               /**< QQ */
    
    QQName = [[NSString alloc] initWithString:@"腾讯QQ"];
    RenName = [[NSString alloc] initWithString:@"人人网"];
    SinaName = [[NSString alloc] initWithString:@"新浪微博"];
    
    QQUid = [[NSString alloc] init];
    RenUid  = [[NSString alloc] init];
    SinaUid = [[NSString alloc] init];
    //三方登录的信息
    NSMutableArray * loginInfo = [[publicFunction getInstance] readLoginInfo];
    if ([loginInfo  count]>0) {
        for(int i=0;i<[loginInfo count];i++){
            NSMutableArray * tempArray = [loginInfo objectAtIndex:i];
            if([[tempArray objectAtIndex:0]integerValue]==1){//已绑定新浪微博
                isLogWithSina = 1;
                SinaName = [tempArray objectAtIndex:2];
                //SinaUid  = [NSString stringWithFormat:@"%@",[tempArray objectAtIndex:1]];
                SinaUid = [tempArray objectAtIndex:1];
            }
            else if([[tempArray objectAtIndex:0]integerValue]==7){//已绑定人人
                isLogWithRenren = 1;
                RenName = [tempArray objectAtIndex:2];
                RenUid = [tempArray objectAtIndex:1];
                //RenUid  = [NSString stringWithFormat:@"%@",[tempArray objectAtIndex:1]];
                
            }
            else if([[tempArray objectAtIndex:0]integerValue]==6){//已绑定QQ空间
                isLogWithQQ = 1;
                QQName = [tempArray objectAtIndex:2];
                //QQUid  = [NSString stringWithFormat:@"%@",[tempArray objectAtIndex:1]];
                QQUid = [tempArray objectAtIndex:1];
                //                NSLog(@"QQUid is:%@",QQUid);
                //                NSLog(@"%@\n",QQName);
                
            }
        }
    }
    
    //NSArray *platforms = [NSArray arrayWithObjects:@"腾讯QQ",@"人人网",@"新浪微博", nil];
    NSArray *logoImages = [NSArray arrayWithObjects:@"qqlogo.png",@"renren.png",@"weibo_logo.png", nil];
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        cell = [[UITableViewCell alloc]init];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",[logoImages objectAtIndex:indexPath.row]]];
    UIButton *bindingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [bindingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindingBtn addTarget:self action:@selector(bindAccount:) forControlEvents:UIControlEventTouchUpInside];
    bindingBtn.tag = 80 + indexPath.row;
    bindingBtn.frame = CGRectMake(530.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [bindingBtn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:218.0/255.0 blue:125.0/255.0 alpha:1.0]];
    [cell.contentView addSubview:bindingBtn];
    
    if (indexPath.row==0) {
        
        cell.textLabel.text = QQName;
        
        if (isLogWithQQ == 1) {
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"已绑定" forState:UIControlStateNormal];
        }else{
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:218.0/255.0 blue:125.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"未绑定" forState:UIControlStateNormal];
        }
        
    }
    else if(indexPath.row ==1){
        cell.textLabel.text = RenName;
        if (isLogWithRenren == 1) {
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"已绑定" forState:UIControlStateNormal];
        }else{
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:218.0/255.0 blue:125.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"未绑定" forState:UIControlStateNormal];
        }
        
    }
    else{
        cell.textLabel.text = SinaName;
        if (isLogWithSina == 1) {
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"已绑定" forState:UIControlStateNormal];
        }else{
            [bindingBtn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:218.0/255.0 blue:125.0/255.0 alpha:1.0]];
            [bindingBtn setTitle:@"未绑定" forState:UIControlStateNormal];
        }
        
    }
    return cell;
}
-(void)bindAccount:(UIButton *)btn
{
    if (btn.tag ==80) {//QQ
        isLogWithQQ=!isLogWithQQ;
        if (isLogWithQQ ==0) {
            QQName = @"未绑定";
            [[publicFunction getInstance]deleteLoginInfoWithUid:QQUid];
            //cancel sso
            [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
            [self.table reloadData];
            
        }
        else{
            [self login:btn.tag];
            
        }
    }
    else if(btn.tag ==81){//renren
        isLogWithRenren = !isLogWithRenren;
        if (isLogWithRenren ==0) {
            RenName = @"未绑定";
            NSLog(@"Ren uid:%@",RenUid);
            [[publicFunction getInstance]deleteLoginInfoWithUid:RenUid];
            //cancel sso
            [ShareSDK cancelAuthWithType:ShareTypeRenren];
            [self.table reloadData];
            
        }
        else{
            [self login:btn.tag];
            
        }
    }
    else{//Sina
        isLogWithSina = !isLogWithSina;
        if (isLogWithSina ==0) {
            SinaName =@"未绑定";
            [[publicFunction getInstance]deleteLoginInfoWithUid:SinaUid];
            //cancel sso
            [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
            [self.table reloadData];
            
        }
        else{
            [self login:btn.tag];
            
        }
    }
    
    //[self.table reloadData];
    
}
//绑定接口
-(void)login:(int)Type
{
    NSInteger shareType;
    if (Type ==80) {
        shareType=ShareTypeQQSpace ;
    }
    
    if (Type ==81) {
        shareType = ShareTypeRenren;
    }
    else if (Type ==82){
        shareType = ShareTypeSinaWeibo;
        
    }
    
    [ShareSDK getUserInfoWithType:shareType authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        //第三方登录成功
        if (result) {
            //第三方登录成功，把“未绑定”改为“绑定”
            if (shareType ==ShareTypeQQSpace) {
                QQName =@"已绑定";
            }
            if (shareType == ShareTypeRenren) {
                RenName =@"已绑定";
            }
            if (shareType == ShareTypeSinaWeibo) {
                SinaName =@"已绑定";
                
            }
            
            //把登录信息保存到plist
            [[publicFunction getInstance]addLoginInfoWithLoginType:shareType Uid:[userInfo uid] nickName:[userInfo nickname]];
            
        }
        else{ //第三方登录失败，把状态再次改变回来
            if (shareType ==ShareTypeQQSpace) {
                isLogWithQQ = !isLogWithQQ;
            }
            if (shareType == ShareTypeRenren) {
                isLogWithRenren = !isLogWithRenren;
            }
            if (shareType == ShareTypeSinaWeibo) {
                isLogWithSina = !isLogWithSina;
                
            }
        }
        [self.table reloadData];
    }];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)dealloc
{
    [table release];
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
