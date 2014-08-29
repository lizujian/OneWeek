//
//  PersonalInfoViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-24.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "MainViewController.h"
#import "ContentViewController.h"
#import "DottedLine.h"
#import "CollectedSectionViewController.h"
#import "AttentionViewController.h"
#import "FansViewController.h"
#import "FotoWallViewController.h"
#import "PostFocus.h"
#import "PersonalPostViewController.h"
#import "PostViewController.h"
#import "FansViewController.h"
#import "AttentionViewController.h"


@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController
@synthesize sv,svImg,pc,svImgCurrentPage,scrollLeftOrRight,userId,starIndex,starName,dic,pNameLbl,fNumLbl,per,userName,imageUrl,sexIndex,contentTxt,race,isFromPost,whereFrom,usrPortrait,petPortrait,breed;
@synthesize  isFromMain;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    GetUserData *gud = [[GetUserData alloc] init];
    [gud getUserData:self.userId :self];
    [gud release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.per = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    per.dic = [NSMutableDictionary dictionaryWithCapacity:0];
    per.userId = self.userId;
    
    
    [self.view addSubview:per];
    [per autorelease];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToFansSection:) name:@"GOFAN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToAttentionSection:) name:@"GOATT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToFotoWall:) name:@"GOFOT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCollectedSection:) name:@"GOCOL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToCon:) name:@"GOCON" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToPos:) name:@"GOPOS" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)frashView:(NSNotification *)noti
{
    [self.per setNeedsDisplay];
}

- (void)setValue:(NSMutableDictionary *)value
{
    self.dic = [NSMutableDictionary dictionaryWithDictionary:value];
    
    //NSLog(@"setvalue:::::%@",self.dic);
    
//    self.per = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    
    self.per.dic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    
//    NSLog(@"per.dic 初始化");
//    
//    [self.view addSubview:per];
//    [per autorelease];
    
    
    
    //NSLog(@"======%@",self.per.dic);
    
    [self.per setNeedsDisplay];
}

//-(void)scrollViewMove:(UIButton *)btn
//{
//    svImgCurrentPage ++;
//    
//    //令UIScrollView做出相应的滑动显示
//    CGSize viewSize = svImg.frame.size;
//    CGRect rect = CGRectMake(svImgCurrentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//    [svImg scrollRectToVisible:rect animated:YES];
//    
//    
//    
//    if (svImgCurrentPage == 12/4) {
//        svImgCurrentPage = 0;
//    }
//
//}

-(void)backToCon:(UIButton *)btn
{
    if (isFromPost) {
        PostViewController *posts = [[PostViewController alloc] init];
        posts.titleName = self.starName;
        posts.moderatorsId = self.starIndex;
        [self presentViewController:posts animated:NO completion:nil];
        [posts release];
    }if ([whereFrom isEqualToString:@"fans"]) {
        FansViewController *fans = [[FansViewController alloc] init];
        [self presentViewController:fans animated:NO completion:nil];
        [fans release];
    }if ([whereFrom isEqualToString:@"focus"]) {
        AttentionViewController *att = [[AttentionViewController alloc] init];
        [self presentViewController:att animated:NO completion:nil];
        [att release];
    }
    if(isFromMain ==YES){
        [self dismissViewControllerAnimated:YES completion:nil];
       // [self dismissModalViewControllerAnimated:YES];
    }
        else{
        ContentViewController *content = [[ContentViewController alloc] init];
        content.starName = self.starName;
        content.starIndex = self.starIndex;
        content.petNameTxt = self.userName;
        content.image = self.imageUrl;
        content.petSex = self.sexIndex;
content.content = self.contentTxt;
        content.usrPortrait = self.usrPortrait;
        content.petPortrait = self.petPortrait;
        content.breed = self.breed;
        [self presentViewController:content animated:NO completion:nil];
        [content release];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.tag == 10) {
//        
////        CGPoint offset = scrollView.contentOffset;
////        CGRect bounds = CGRectMake(0, 0, 344.0/640.0*VIEW_FRAME_WIDTH, 170.0/1136.0*VIEW_FRAME_HEIGHT);
////        [pc setCurrentPage:offset.x / bounds.size.width];
//
//    }else if (scrollView.tag == 11){
//        
//        //Selected index's color changed.
//        static float newx = 0;
//        static float oldx = 0;
//        newx= scrollView.contentOffset.x ;
//        if (newx != oldx ) {
//            //Left-YES,Right-NO
//            if (newx > oldx) {
//                self.scrollLeftOrRight = NO;
//            }else if(newx < oldx){
//                self.scrollLeftOrRight = YES;
//            }
//            oldx = newx;
//        }
//    }
//    
////    appDelegate=[[UIApplication sharedApplication] delegate];
////    City *c = [appDelegate.cities objectAtIndex:pc.currentPage];
////    self.cName = c.cityName;
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!self.scrollLeftOrRight) {
//        svImgCurrentPage ++;
//        if (svImgCurrentPage == 12/4) {
//            svImgCurrentPage = 0;
//        }
//    }else{
//        if (svImgCurrentPage == 0) {
//            svImgCurrentPage = 12/4;
//        }
//        svImgCurrentPage --;
//    }
//}

-(void)goToCollectedSection:(UIButton *)btn
{
//    CollectedSectionViewController *colSec = [[CollectedSectionViewController alloc] init];
//    colSec.userId = self.userId;
//    colSec.starName = self.starName;
//    colSec.starIndex = self.starIndex;
//    [self presentViewController:colSec animated:NO completion:nil];
//    [colSec release];
}

-(void)goToAttentionSection:(UIButton *)btn
{
//    AttentionViewController *avc = [[AttentionViewController alloc] init];
//    avc.userId = self.userId;
//    avc.starName = self.starName;
//    avc.starIndex = self.starIndex;
//    [self presentViewController:avc animated:NO completion:nil];
//    [avc release];
}

-(void)goToPos:(UIButton *)btn
{
//    PersonalPostViewController *personalPost = [[PersonalPostViewController alloc] init];
//    personalPost.userId = self.userId;
//    personalPost.starName = self.starName;
//    personalPost.starIndex = self.starIndex;
//    personalPost.userName = self.userName;
//    [self presentViewController:personalPost animated:NO completion:nil];
//    [personalPost release];
}

-(void)goToFansSection:(UIButton *)btn
{
//    FansViewController *fans = [[FansViewController alloc] init];
//    fans.userId = self.userId;
//    fans.starName = self.starName;
//    fans.starIndex = self.starIndex;
//    [self presentViewController:fans animated:NO completion:nil];
//    [fans release];
}

-(void)goToFotoWall:(UIButton *)btn
{
//    FotoWallViewController *foto = [[FotoWallViewController alloc] init];
//    foto.userId = self.userId;
//    foto.starName = self.starName;
//    foto.starIndex = self.starIndex;
//    [self presentViewController:foto animated:NO completion:nil];
//    [foto release];
}

//-(void)focus: (UIButton *)btn
//{
//    PostFocus *pf = [[PostFocus alloc] init];
//    [pf postFocus:self.userId];
//    [pf release];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注成功！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:@"GOFAN"];
    [[NSNotificationCenter defaultCenter]removeObserver:@"GOATT"];
    [[NSNotificationCenter defaultCenter]removeObserver:@"GOFOT"];
    [[NSNotificationCenter defaultCenter]removeObserver:@"GOCOL"];
    
    [sv release];
    [starName release];
    [svImg release];
    [pc release];
    [dic release];
    [pNameLbl release];
    [userName release];
    [imageUrl release];
    [contentTxt release];
    [race release];
    [whereFrom release];
    [usrPortrait release];
    [petPortrait release];
    [breed release];
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
