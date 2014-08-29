//
//  ContentViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-6-23.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ContentViewController.h"
#import "MainViewController.h"
#import "PostViewController.h"
#import "PersonalInfoViewController.h"
#import "PostPraise.h"
#import "LoginViewController.h"
#import "PostMessage.h"
#import "PostCollect.h"
#import "AppDelegate.h"
#import "GetReply.h"
#import "PostFocus.h"
#import "ReplyChildTable.h"
#import "PersonalPostViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PostPhoto.h"
#import "GetUserInfo.h"

#import <ShareSDK/ShareSDK.h>
@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize replyParentId,isReplyCommentary,table,timeTxt,petSex,breed,region,userName,usrId,image,contImg,usrPortrait,petPortrait,petNameTxt,postTitle,content,starName,replyArray,footView,starIndex,postId,praiseArray,praiseNum,idsArray,customerNameArray,customerPortraitArray,petNames,petAgeArray,contents,pics,createTimeArray,childArray,isPersonalPost,postUserId,fileData,filePath,img,photoes,addPhotoTimes,n,myPortrait;

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
    
    GetUserInfo *gui = [[GetUserInfo alloc] init];
    gui.userDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [gui getUserInfo:0];
    
    self.myPortrait = [NSDictionary dictionaryWithObject:[gui.userDataDic objectForKey:@"portrait"] forKey:@"customerPortrait"];
    [gui release];
    
    addPhotoTimes = 0;
    self.photoes = [NSMutableArray arrayWithCapacity:0];
  
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(284.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 74.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"帖子";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*320.0, 53.0/1136.0*568.0, 63.0/640.0*320.0, 61.0/1136.0*568.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToPost:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    //关注
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkBtn.frame = CGRectMake(548.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT);
    [checkBtn setBackgroundImage:[UIImage imageNamed:@"preview_icon.png"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:checkBtn];
    
    [barView release];
    [titleText release];

    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
//    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //toolBar
    self.footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-91.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 91.0/1136.0*VIEW_FRAME_HEIGHT)];
    self.footView.layer.borderWidth = 0.5;
    self.footView.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0] CGColor];
    [self.footView setBackgroundColor:[UIColor whiteColor]];
    [self.footView setUserInteractionEnabled:YES];
    [self.view addSubview:self.footView];
    
     //点赞
    UIButton *loveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loveBtn.frame = CGRectMake(62.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 36.0/640.0*VIEW_FRAME_WIDTH, 33.0/1136.0*VIEW_FRAME_HEIGHT);
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"praise_icon.png"] forState:UIControlStateNormal];
    [loveBtn addTarget:self action:@selector(praise:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:loveBtn];
    
    //回复
    UIButton *replyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    replyBtn.frame = CGRectMake(221.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 36.0/640.0*VIEW_FRAME_WIDTH, 33.0/1136.0*VIEW_FRAME_HEIGHT);
    [replyBtn setBackgroundImage:[UIImage imageNamed:@"messege_icon.png"] forState:UIControlStateNormal];
    [replyBtn addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:replyBtn];
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    shareBtn.frame = CGRectMake(383.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 36.0/640.0*VIEW_FRAME_WIDTH, 33.0/1136.0*VIEW_FRAME_HEIGHT);
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:shareBtn];
    
    //收藏
    UIButton *colBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    colBtn.frame = CGRectMake(541.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 36.0/640.0*VIEW_FRAME_WIDTH, 33.0/1136.0*VIEW_FRAME_HEIGHT);
    [colBtn setBackgroundImage:[UIImage imageNamed:@"collect_icon.png"] forState:UIControlStateNormal];
    [colBtn addTarget:self action:@selector(collectPost:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:colBtn];
    
      //分割竖线
    UIView *lineViewOne = [[UIView alloc] initWithFrame:CGRectMake(159.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 1.0/640.0*VIEW_FRAME_WIDTH, 36.0/1136.0*VIEW_FRAME_HEIGHT)];
    [lineViewOne setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]];
    [self.footView addSubview:lineViewOne];
    
    UIView *lineViewTwo = [[UIView alloc] initWithFrame:CGRectMake(317.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 1.0/640.0*VIEW_FRAME_WIDTH, 36.0/1136.0*VIEW_FRAME_HEIGHT)];
    [lineViewTwo setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]];
    [self.footView addSubview:lineViewTwo];
    
    UIView *lineViewThr = [[UIView alloc] initWithFrame:CGRectMake(475.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 1.0/640.0*VIEW_FRAME_WIDTH, 36.0/1136.0*VIEW_FRAME_HEIGHT)];
    [lineViewThr setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]];
    [self.footView addSubview:lineViewThr];
    
    [lineViewOne release];
    [lineViewTwo release];
    [lineViewThr release];
    [footView release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    UIView *replyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-70.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT)];
    [replyView setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
    [replyView setUserInteractionEnabled:YES];
    [replyView setHidden:YES];
    replyView.tag = 2;
    [self.view addSubview:replyView];
    
    CATransition* transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [replyView.layer addAnimation:transition forKey:kCATransition];
    
     //评论进行时的表情选择按钮
    UIButton *expressionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    expressionBtn.frame = CGRectMake(14.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [expressionBtn setBackgroundImage:[UIImage imageNamed:@"face_01.png"] forState:UIControlStateNormal];
    [expressionBtn addTarget:self action:@selector(showFace:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:expressionBtn];
    
    //评论进行时的图片选择按钮
    UIButton *fotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fotoBtn.frame = CGRectMake(80.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [fotoBtn setBackgroundImage:[UIImage imageNamed:@"printer.png"] forState:UIControlStateNormal];
    [fotoBtn addTarget:self action:@selector(showFotoView:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:fotoBtn];
    
    //输入框
    UITextView *replyText = [[UITextView alloc] initWithFrame:CGRectMake( 142.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
    [replyText setBackgroundColor:[UIColor whiteColor]];
    replyText.tag = 3;
    replyText.delegate = self;
    [replyView addSubview:replyText];
    
    //发送按钮
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    postBtn.frame = CGRectMake(554.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [postBtn setTitle:@"发送" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [postBtn addTarget:self action:@selector(postMessage:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:postBtn];
    
    [replyText release];
    [replyView release];
    
    UIView *faceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-325.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 325.0/1136.0*VIEW_FRAME_HEIGHT)];
    [faceView setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
    [faceView setUserInteractionEnabled:YES];
    [faceView setHidden:YES];
    faceView.tag = 4;
    [self.view addSubview:faceView];
    
    UIScrollView *faceScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 275.0/1136.0*VIEW_FRAME_HEIGHT)];
    faceScroll.delegate = self;
    faceScroll.contentSize = CGSizeMake((120/28)*VIEW_FRAME_WIDTH, 275.0/1136.0*VIEW_FRAME_HEIGHT);
    faceScroll.tag = 55;
    faceScroll.pagingEnabled = YES;
    faceScroll.showsHorizontalScrollIndicator = NO;
    faceScroll.showsVerticalScrollIndicator = NO;
    [faceScroll setUserInteractionEnabled:YES];
    [faceView addSubview:faceScroll];
    
    for (int i = 1; i<=120; i++) {
        UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeSystem];
        faceButton.tag = 100+i;

        [faceButton addTarget:self
                       action:@selector(faceButtonTap:)
             forControlEvents:UIControlEventTouchUpInside];
        
        //计算每一个表情按钮的坐标和在哪一屏
        faceButton.frame = CGRectMake((((i-1)%28)%7)*40+5*(((i-1)%7)+2)+((i-1)/28*320), (((i-1)%28)/7)*30+6*((i-1)%28/7+1), 40/640.0*VIEW_FRAME_WIDTH, 40/1136.0*VIEW_FRAME_HEIGHT);
        
        [faceButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]] forState:UIControlStateNormal];
        [faceScroll addSubview:faceButton];
    }

    
    UIView *fotoesView = [[UIView alloc] initWithFrame:CGRectMake(0, 916.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT)];
    [fotoesView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    fotoesView.opaque = NO;
    fotoesView.tag = 60;
    [fotoesView setHidden:YES];
    [self.view addSubview:fotoesView];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 38.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 121.0/1136.0*VIEW_FRAME_HEIGHT)];
    sv.delegate = self;
    sv.showsHorizontalScrollIndicator = NO;
    sv.contentSize = CGSizeMake(160.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
    sv.tag = 57;
    sv.pagingEnabled = NO;
    sv.bounces = NO;
    [sv setUserInteractionEnabled:YES];
    [fotoesView addSubview:sv];
 
    UIButton *addFotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addFotoBtn.frame = CGRectMake(20.0/640.0*VIEW_FRAME_WIDTH, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
    [addFotoBtn addTarget:self action:@selector(fotoDisplay:) forControlEvents:UIControlEventTouchUpInside];
    [addFotoBtn setBackgroundImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    addFotoBtn.tag = 58;
    [sv addSubview:addFotoBtn];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(210.0/640.0*VIEW_FRAME_WIDTH, 180.0/1136.0*VIEW_FRAME_HEIGHT, 230.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    lbl.text = @"已选0张，还有6张可选";
    lbl.tag = 6;
    lbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    lbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0];
    [fotoesView addSubview:lbl];
    
    [sv release];
    [lbl release];

    
    GetReply *gr =[[GetReply alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[gr getReply:self.postId] ];
    self.replyArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"comments"]];
    NSLog(@"reply arr : ---------------%d",[self.replyArray count]);
    self.idsArray = [NSMutableArray arrayWithCapacity:0];
    
    if ([self.replyArray count] != 0) {
        for (int i = 0; i < [self.replyArray count] ; i++) {
            [self.idsArray addObject:[[self.replyArray objectAtIndex:i] objectForKey:@"id"]];
            
        }
    }
    
    NSLog(@"id:%@",self.idsArray);

    [gr release];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(childReply:) name:@"REPLY" object:nil];
    
    n = 0;
    
    NSLog(@"pics:%@",self.pics);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize sizeToFit = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
//    return sizeToFit.height;
    
    int m = (int)(sizeToFit.height/(textView.frame.size.height-n*70.0/1136.0*VIEW_FRAME_HEIGHT));
    
    NSLog(@"%f,%f",sizeToFit.height,textView.frame.size.height);
    NSLog(@"%d",m);
    if (m>n) {
        n=m;
        UIView *v = [self.view viewWithTag:2];
        v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y-70.0/1136.0*VIEW_FRAME_HEIGHT, v.frame.size.width, v.frame.size.height+70.0/1136.0*VIEW_FRAME_HEIGHT);
        
        UITextView *txt = (UITextView *)[self.view viewWithTag:3];
        txt.frame = CGRectMake(txt.frame.origin.x, txt.frame.origin.y , txt.frame.size.width, txt.frame.size.height+70.0/1136.0*VIEW_FRAME_HEIGHT);
    }
    if (m<n) {
        n=m;
        UIView *v = [self.view viewWithTag:2];
        v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y+70.0/1136.0*VIEW_FRAME_HEIGHT, v.frame.size.width, v.frame.size.height-70.0/1136.0*VIEW_FRAME_HEIGHT);
        
        UITextView *txt = (UITextView *)[self.view viewWithTag:3];
        txt.frame = CGRectMake(txt.frame.origin.x, txt.frame.origin.y , txt.frame.size.width, txt.frame.size.height-70.0/1136.0*VIEW_FRAME_HEIGHT);
    }
    
}

-(void)faceButtonTap:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
}

-(void)showFace:(UIButton *)btn
{
    CATransition* transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    UITextView *text = (UITextView *)[self.view viewWithTag:3];
    [text resignFirstResponder];
    
    UIView *view = [self.view viewWithTag:2];
    [view setHidden:NO];
    view.frame = CGRectMake(0, VIEW_FRAME_HEIGHT-325.0/1136.0*VIEW_FRAME_HEIGHT-view.frame.size.height, view.frame.size.width, view.frame.size.height);
    
    UIView *face = [self.view viewWithTag:4];
    [face setHidden:NO];
    
    UIView *foto = [self.view viewWithTag:60];
    if (foto) {
        [foto setHidden:YES];
    }
    
//    [face.layer addAnimation:transition forKey:kCATransition];
}

-(void)showFotoView:(UIButton *)btn
{

    UIView *face = [self.view viewWithTag:4];
    if (face) {
        [face setHidden:YES];
    }
    
    UITextField *text = (UITextField *)[self.view viewWithTag:3];
    [text resignFirstResponder];
    
    UIView *view = [self.view viewWithTag:2];
    [view setHidden:NO];
    view.frame = CGRectMake(0, VIEW_FRAME_HEIGHT-220.0/1136.0*VIEW_FRAME_HEIGHT-view.frame.size.height, VIEW_FRAME_WIDTH, view.frame.size.height);
    
    UIView *fotoesView = [self.view viewWithTag:60];
    [fotoesView setHidden:NO];

}

-(void)fotoDisplay:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    photoBtn.frame = CGRectMake(10.0/640.0*VIEW_FRAME_WIDTH, 898.0/1136.0*VIEW_FRAME_HEIGHT, 620.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT);
    [photoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [photoBtn setBackgroundColor:[UIColor whiteColor]];
    [backImg addSubview:photoBtn];
    
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    albumBtn.frame = CGRectMake(10.0/640.0*VIEW_FRAME_WIDTH, 975.0/1136.0*VIEW_FRAME_HEIGHT, 620.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT);
    [albumBtn setTitle:@"从相册中选择" forState:UIControlStateNormal];
    [albumBtn addTarget:self action:@selector(chooseFromAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [albumBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [albumBtn setBackgroundColor:[UIColor whiteColor]];
    [backImg addSubview:albumBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10.0/640.0*VIEW_FRAME_WIDTH, 1058.0/1136.0*VIEW_FRAME_HEIGHT, 620.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT);
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn addTarget:self action:@selector(cancelFoto:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:104.0/255.0 blue:104.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [backImg addSubview:cancelBtn];
    
    [backImg release];
}

-(void)takePhoto:(UIButton *)btn
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];//进入照相界面
    [picker release];
}

-(void)chooseFromAlbum:(UIButton *)btn
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentModalViewController:pickerImage animated:YES];
    [pickerImage release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //拍照完，或者选取照片后调用
    //    self.img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //    self.fileData = UIImageJPEGRepresentation(img, 0.0);
    //
    //    [self.petBtn setImage:[UIImage imageWithData:self.fileData] forState:UIControlStateNormal];
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"type:%@",type);
    
    //当选择的类型是图片
    //    if ([type isEqualToString:@"public.image"])
    //    {
    //先把图片转成NSData
    self.img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
//压缩图片
//    CGSize imagesize = img.size;
//    imagesize.height =626;
//    imagesize.width =413;
//    self.img = [self imageWithImage:self.img scaledToSize:imagesize];
    
    if (UIImagePNGRepresentation(img) == nil)
    {
        fileData = UIImageJPEGRepresentation(img, 0.0);
    }
    else
    {
        
        fileData = UIImagePNGRepresentation(img);
        
    }
    
    addPhotoTimes += 1;
    
    //图片保存的路径
    
    //这里将图片放在沙盒的documents文件夹中
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/image%d.png",addPhotoTimes]] contents:self.fileData attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    
    self.filePath = [NSString stringWithFormat:@"%@/image%d.png",DocumentsPath,addPhotoTimes];
    [self.photoes addObject:self.filePath];
    
    //发送照片
    PostPhoto *pp = [[PostPhoto alloc] init];
    [pp postPhoto:self.filePath];
    [pp release];
    
    //显示照片
    UIScrollView *view = (UIScrollView *)[self.view viewWithTag:57];
    view.contentSize = CGSizeMake(140.0/640.0*VIEW_FRAME_WIDTH*([self.photoes count]+1), 120.0/1136.0*VIEW_FRAME_HEIGHT);
    for (int i = 0; i< [self.photoes count]; i++ ) {
        UIImageView *addedImg = [[UIImageView alloc] initWithFrame:CGRectMake( 20.0/640.0*VIEW_FRAME_WIDTH*(i+1)+120.0/1136.0*VIEW_FRAME_HEIGHT*i, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT)];
        [addedImg  setImage:[UIImage imageWithContentsOfFile:[self.photoes objectAtIndex:i]]];
        [addedImg setUserInteractionEnabled:YES];
        addedImg.tag = 10+i;
        [view addSubview:addedImg];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        deleteBtn.frame = CGRectMake(84.0/640.0*VIEW_FRAME_WIDTH, 0, 36.0/640.0*VIEW_FRAME_WIDTH, 36.0/1136.0*VIEW_FRAME_HEIGHT);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delelte_icon.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = 20 + i ;
        [addedImg addSubview:deleteBtn];
        
        [addedImg release];
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:58];
        if ([self.photoes count] == 6) {
            [btn removeFromSuperview];
        }else{
            btn.frame = CGRectMake(  20.0/640.0*VIEW_FRAME_WIDTH*(i+2)+120.0/1136.0*VIEW_FRAME_HEIGHT*(i+1), 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
        }
    }
    UILabel *l = (UILabel *)[self.view viewWithTag:6];
    l.text = [NSString stringWithFormat:@"已选%d张，还有%d张可选",addPhotoTimes,6-addPhotoTimes];
    
    
    
    //关闭相册界面
    
    [picker dismissModalViewControllerAnimated:YES];
    
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

//对图片尺寸进行压缩--
//-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    
//    // Create a graphics image context
//    
//    UIGraphicsBeginImageContext(newSize);
//    
//    
//    // Tell the old image to draw in this new context, with the desired
//    
//    // new size
//    
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    
//    
//    // Get the new image from the context
//    
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    
//    // End the context
//    
//    UIGraphicsEndImageContext();
//    
//    
//    // Return the new image.
//    
//    return newImage;
//    
//}

-(void)deleteImage:(UIButton *)btn
{
//    [btn.superview removeFromSuperview];
    [self.photoes removeObjectAtIndex:btn.tag-20];
    
    UIScrollView *sview = (UIScrollView *)[self.view viewWithTag:57];
    sview.contentSize = CGSizeMake(140.0/640.0*VIEW_FRAME_WIDTH*([self.photoes count]+1), 120.0/1136.0*VIEW_FRAME_HEIGHT);
    
    for (UIView *view in sview.subviews) {
        if (view.tag-10 == btn.tag-20) {
            [view removeFromSuperview];
        }
        if (view.tag-10 > btn.tag-20) {
            view.frame = CGRectMake(view.frame.origin.x-140.0/640.0*VIEW_FRAME_WIDTH, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
    }

    UILabel *l = (UILabel *)[self.view viewWithTag:6];
    l.text = [NSString stringWithFormat:@"已选%d张，还有%d张可选",[self.photoes count],6-[self.photoes count]];
    
//    UIButton *button = (UIButton *)[self.view viewWithTag:58];
//    button.frame = CGRectMake( button.frame.origin.x-140.0/640.0*VIEW_FRAME_WIDTH, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
}

-(void)cancelFoto:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}


-(void)postMessage:(UIButton *)btn
{
    postAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"亲，你还没有登录哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"登录", nil];
    [postAlertView show];
//    NSMutableArray *picIds = [NSMutableArray arrayWithCapacity:0];
    UITextField *replyText = (UITextField *)[self.view viewWithTag:3];
    
    if (replyText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败" message:@"回复不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }

    [replyText resignFirstResponder];
    
    [self.footView setHidden:NO];
    
    UIView *reply = [self.view viewWithTag:2];
    reply.frame = CGRectMake(0, VIEW_FRAME_HEIGHT-70.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT);
    [reply setHidden:YES];
    
    UITextView *txt = (UITextView *)[self.view viewWithTag:3];
    txt.frame = CGRectMake( 142.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    txt.text = @"";
    
    UIView *foto = [self.view viewWithTag:60];
    [foto setHidden:YES];
    
    UIView *face = [self.view viewWithTag:4];
    [face setHidden:YES];
    
    PostMessage *pm = [[PostMessage alloc] init];
    if (isReplyCommentary) {
        [pm postMessage:self.postId :self.replyParentId :replyText.text];
    }else{
        [pm postMessage:self.postId :0 :replyText.text];
    }
    replyText.text = @"";
    [pm release];
    
    GetReply *gr =[[GetReply alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[gr getReply:self.postId] ];
    [self.replyArray removeAllObjects];
    self.replyArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"comments"]];
    [gr release];
    
    NSLog(@"%@",self.replyArray);
    
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + [self.replyArray count];

}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = 0.0;
    CGSize stringSize = [self.content sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0]];
    
    if (indexPath.row == 1) {
        if ([self.pics count]>1 && [self.pics count]<4) {
            cellHeight = 35.0/1136.0*VIEW_FRAME_HEIGHT+84.5/1136.0*VIEW_FRAME_HEIGHT+stringSize.height/1136.0*VIEW_FRAME_HEIGHT+40.0/1136.0*VIEW_FRAME_HEIGHT;
        }else if ([self.pics count]>4) {
            cellHeight = 35.0/1136.0*VIEW_FRAME_HEIGHT+2*84.5/1136.0*VIEW_FRAME_HEIGHT+stringSize.height/1136.0*VIEW_FRAME_HEIGHT+50.0/1136.0*VIEW_FRAME_HEIGHT;
        }else{
            cellHeight = 510.0/1136.0*VIEW_FRAME_HEIGHT+stringSize.height/1136.0*VIEW_FRAME_HEIGHT;
        }
    }else if(indexPath.row ==0 || indexPath.row == 2){
        cellHeight = 122.0/1136.0*VIEW_FRAME_HEIGHT;
    }
    else if (indexPath.row > 2 ){
        if ([[[self.replyArray objectAtIndex:indexPath.row-3]objectForKey:@"child"] count] != 0) {
            cellHeight = 140.0/1136.0*VIEW_FRAME_HEIGHT + 50*[[[self.replyArray objectAtIndex:indexPath.row-3]objectForKey:@"child"] count]/1136.0*VIEW_FRAME_HEIGHT;
        }else
            cellHeight = 140.0/1136.0*VIEW_FRAME_HEIGHT;
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc]init];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 33.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 81.0/640.0*VIEW_FRAME_WIDTH, 81.0/1136.0*VIEW_FRAME_HEIGHT)];
//            [headImg  setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.petPortrait]]]];
            [headImg setImageWithURL:[NSURL URLWithString:self.petPortrait] placeholderImage:[UIImage imageNamed:@"wait.png"]];
           // [headImg sd_setImageWithURL:[NSURL URLWithString:self.petPortrait] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            headImg.layer.cornerRadius = headImg.bounds.size.width/2;
            headImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:headImg];
            
            UITextField *petName = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*VIEW_FRAME_WIDTH, 31.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 29.0/1136.0*VIEW_FRAME_HEIGHT)];
            petName.text = self.petNameTxt;
            petName.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [petName setEnabled:NO];
            [cell.contentView addSubview:petName];
            
            UIImageView *sexImg = [[UIImageView alloc] init];
            if(self.petSex == 0){
                [sexImg setFrame:CGRectMake( 228.0/640.0*VIEW_FRAME_WIDTH, 40.0/1136.0*VIEW_FRAME_HEIGHT, 26.0/640.0*VIEW_FRAME_WIDTH, 14.0/1136.0*VIEW_FRAME_HEIGHT)];
                [sexImg setImage:[UIImage imageNamed:@"bowknot.png"]];
            }else{
                [sexImg setFrame:CGRectMake( 228.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 20.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
                [sexImg setImage:[UIImage imageNamed:@"tie.png"]];
            }
            [cell.contentView addSubview:sexImg];
            
            UITextField *varieties = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            varieties.text = self.breed;
            [varieties setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
            varieties.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [varieties setEnabled:NO];
            [cell.contentView addSubview:varieties];
            
            UIImageView *locaImg = [[UIImageView alloc] initWithFrame:CGRectMake( 261.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 20.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            [locaImg setImage:[UIImage imageNamed:@"pin.png"]];
            [cell.contentView addSubview:locaImg];
            
            UITextField *location = [[UITextField alloc] initWithFrame:CGRectMake( 291.0/640.0*VIEW_FRAME_WIDTH, 71.0/1136.0*VIEW_FRAME_HEIGHT, 90.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            location.text = self.region;
            [location setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
            location.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [location setEnabled:NO];
            [cell.contentView addSubview:location];
            
            UIImageView *peoImg = [[UIImageView alloc] initWithFrame:CGRectMake( 540.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 58.0/1136.0*VIEW_FRAME_HEIGHT)];
//            [peoImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.usrPortrait]]]];
            [peoImg setImageWithURL:[NSURL URLWithString:self.usrPortrait] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            //[peoImg sd_setImageWithURL:[NSURL URLWithString:self.usrPortrait] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            peoImg.layer.cornerRadius = 5;//设置那个圆角的有多圆
            peoImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:peoImg];
            
            UITextField *lastTime = [[UITextField alloc] initWithFrame:CGRectMake( 527.0/640.0*VIEW_FRAME_WIDTH, 85.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
            lastTime.text = self.timeTxt;
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
            title.text = self.postTitle;
            [title setFont:[UIFont fontWithName:@"Arial" size:14.0]];
            //            title.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            [title setEnabled:NO];
            [cell.contentView addSubview:title];
        
            
            if ([self.pics count]>0) {
                
                if ([self.pics count] == 1) {
                    
                    if (self.image.length != 0) {
                        self.contImg = [[UIImageView alloc] initWithFrame:CGRectMake( 58.0/640.0*VIEW_FRAME_WIDTH, 82.0/1136.0*VIEW_FRAME_HEIGHT, 562.0/640.0*VIEW_FRAME_WIDTH, 362.0/1136.0*VIEW_FRAME_HEIGHT)];
                        //                [contImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.image]]]];
                        [contImg setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        //[contImg sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        [cell.contentView addSubview:contImg];
                    }
                }
                if ([self.pics count] > 1 && [self.pics count] < 4) {
                    for (int i = 0; i<[self.pics count]; i++) {
                        
//                        UIImageView *cImg = [[UIImageView alloc] initWithFrame:CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH + 94.0/640.0*VIEW_FRAME_WIDTH*i, 82.0/1136.0*VIEW_FRAME_HEIGHT, 62.0/640.0*VIEW_FRAME_WIDTH, 84.5/1136.0*VIEW_FRAME_HEIGHT)];
//                        [cImg sd_setImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
//                        [cell.contentView addSubview:cImg];
                        
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                        btn.frame = CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH + 94.0/640.0*VIEW_FRAME_WIDTH*i, 82.0/1136.0*VIEW_FRAME_HEIGHT, 62.0/640.0*VIEW_FRAME_WIDTH, 84.5/1136.0*VIEW_FRAME_HEIGHT);
                        [btn setImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        [btn addTarget:self action:@selector(imgBtn:) forControlEvents:UIControlEventTouchUpInside];
                        btn.tag = 90+i;
                        [cell.contentView addSubview:btn];
                    }
                }
                if ([self.pics count] > 4) {
                    for (int i = 0; i<[self.pics count]; i++) {
                        
//                        UIImageView *cImg = [[UIImageView alloc] initWithFrame:CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH + 94.0/640.0*VIEW_FRAME_WIDTH*i, 179.0/1136.0*VIEW_FRAME_HEIGHT, 62.0/640.0*VIEW_FRAME_WIDTH, 84.5/1136.0*VIEW_FRAME_HEIGHT)];
//                        [cImg sd_setImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
//                        [cell.contentView addSubview:cImg];
                        
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                        btn.frame = CGRectMake( 35.0/640.0*VIEW_FRAME_WIDTH + 94.0/640.0*VIEW_FRAME_WIDTH*i, 179.0/1136.0*VIEW_FRAME_HEIGHT, 62.0/640.0*VIEW_FRAME_WIDTH, 84.5/1136.0*VIEW_FRAME_HEIGHT);
                        [btn setImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.pics objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"wait.png"]];
                        [btn addTarget:self action:@selector(imgBtn:) forControlEvents:UIControlEventTouchUpInside];
                        btn.tag = 90+i;
                        [cell.contentView addSubview:btn];
                    }
                }
            }
            
            CGSize stringSize = [self.content sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0]];
            
            UITextField *contentTxt = [[UITextField alloc] init];
//            WithFrame:CGRectMake( 58.0/640.0*VIEW_FRAME_WIDTH, 454.0/1136.0*VIEW_FRAME_HEIGHT, 449.0/640.0*VIEW_FRAME_WIDTH, 60.0/1136.0*VIEW_FRAME_HEIGHT)
            if ([self.pics count] > 1 && [self.pics count] < 4){
                contentTxt.frame = CGRectMake( 58.0/640.0*VIEW_FRAME_WIDTH, 454.0/1136.0*VIEW_FRAME_HEIGHT-84.5/1136.0*VIEW_FRAME_HEIGHT, 449.0/640.0*VIEW_FRAME_WIDTH, stringSize.height/1136.0*VIEW_FRAME_HEIGHT);
            }else
            {
                contentTxt.frame = CGRectMake( 58.0/640.0*VIEW_FRAME_WIDTH, 454.0/1136.0*VIEW_FRAME_HEIGHT, 449.0/640.0*VIEW_FRAME_WIDTH, stringSize.height);
            }
            contentTxt.text = self.content;
            [contentTxt setFont:[UIFont fontWithName:@"Arial" size:11.0]];
            [contentTxt setEnabled:NO];
            [cell.contentView addSubview:contentTxt];
            
            [contentTxt release];
            [secImg release];
            [title release];
            [contImg release];
            
        }else if (indexPath.row == 2){
            for (int i = 0; i < praiseNum; i++) {
                UIImageView *praiserImg = [[UIImageView alloc] initWithFrame:CGRectMake( 24.0/640.0*VIEW_FRAME_WIDTH + 83.0/640.0*VIEW_FRAME_WIDTH*i , 20.0/1136.0*VIEW_FRAME_HEIGHT, 59.0/640.0*VIEW_FRAME_WIDTH, 59.0/1136.0*VIEW_FRAME_HEIGHT)];
//                [praiserImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.praiseArray objectAtIndex:i] objectForKey:@"customerPortrait"]]]]];
                [praiserImg setImageWithURL:[NSURL URLWithString:[[self.praiseArray objectAtIndex:i] objectForKey:@"customerPortrait"]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
                [cell.contentView addSubview:praiserImg];
                
                [praiserImg release];
            }
            
        }
        else if(indexPath.row > 2){
            
            UIImageView *replierHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake( 24.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT, 59.0/640.0*VIEW_FRAME_WIDTH, 59.0/1136.0*VIEW_FRAME_HEIGHT)];
//            [replierHeadImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"customerPortrait"]]]]];
            [replierHeadImg setImageWithURL:[NSURL URLWithString:[[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"customerPortrait"]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
            [cell.contentView addSubview:replierHeadImg];
            
            [replierHeadImg release];
            
            UILabel *replierName = [[UILabel alloc] initWithFrame:CGRectMake( 91.0/640.0*VIEW_FRAME_WIDTH, 23.0/1136.0*VIEW_FRAME_HEIGHT, 100.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT)];
            replierName.text = [[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"customerName"];
            [replierName setFont:[UIFont fontWithName:@"Arial" size:11.0]];
            [cell.contentView addSubview:replierName];
            
            [replierName release];
            
            UILabel *floor = [[UILabel alloc] initWithFrame:CGRectMake( 91.0/640.0*VIEW_FRAME_WIDTH, 58.0/1136.0*VIEW_FRAME_HEIGHT, 34.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT)];
            floor.text = [NSString stringWithFormat:@"%d楼",indexPath.row-2];
            [floor setFont:[UIFont fontWithName:@"Arial" size:10.0]];
            [cell.contentView addSubview:floor];
            
            [floor release];
            
            UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(135.0/640.0*VIEW_FRAME_WIDTH, 58.0/1136.0*VIEW_FRAME_HEIGHT, 80.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT)];
            time.text = [NSString stringWithFormat:@"%@分钟前",[[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"create_time"]];
            [time setFont:[UIFont fontWithName:@"Arial" size:10.0]];
            [cell.contentView addSubview:time];
            
            [time release];
            
            UITextField *replyTxt = [[UITextField alloc] initWithFrame:CGRectMake( 91.0/640.0*VIEW_FRAME_WIDTH, 95.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH-84.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT)];
//            replyTxt.text = [self.replyArray objectAtIndex:indexPath.row -4];
            replyTxt.text = [[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"content"];
            [replyTxt setFont:[UIFont fontWithName:@"Arial-BoldMT" size:11.0]];
            [replyTxt setEnabled:NO];
            [cell.contentView addSubview:replyTxt];
            
            [replyTxt release];
            
            UIButton *reBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            reBtn.frame = CGRectMake( 580.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT, 40.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT);
            [reBtn setBackgroundImage:[UIImage imageNamed:@"frorm.png"] forState:UIControlStateNormal];
            [reBtn addTarget:self action:@selector(replyCommentary:) forControlEvents:UIControlEventTouchUpInside];
            reBtn.tag = 198 + indexPath.row;
            [cell.contentView addSubview:reBtn];
            
            ReplyChildTable *childTable = [[ReplyChildTable alloc]initWithFrame:CGRectMake(91.0/640.0*VIEW_FRAME_WIDTH, 134.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH-91.0/640.0*VIEW_FRAME_WIDTH, (float)[[[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"child"] count]/1136.0*VIEW_FRAME_HEIGHT)];
            childTable.childArr = [NSMutableArray arrayWithArray:[[self.replyArray objectAtIndex:indexPath.row-3] objectForKey:@"child"]];
            [cell.contentView addSubview:childTable];
            
            
            [childTable release];
            
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PersonalInfoViewController *personalInfo = [[PersonalInfoViewController alloc] init];
        personalInfo.userId = self.postUserId;
        personalInfo.starName = self.starName;
        personalInfo.starIndex = self.starIndex;
        personalInfo.userId = self.usrId;
        personalInfo.userName = self.petNameTxt;
        personalInfo.imageUrl = self.image;
        personalInfo.sexIndex = self.petSex;
        personalInfo.contentTxt = self.content;
        personalInfo.usrPortrait = self.usrPortrait;
        personalInfo.petPortrait = self.petPortrait;
        personalInfo.breed = self.breed;
        [self presentViewController:personalInfo animated:NO completion:nil];
        [personalInfo release];
    }else{
        UITextField *text = (UITextField *)[self.view viewWithTag:3];
        [text resignFirstResponder];
        UIView *view = [self.view viewWithTag:2];
        [view setFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-70.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT)];
        [view setHidden:YES];
        UIView *viewTwo = [self.view viewWithTag:60];
        [viewTwo setHidden:YES];
        UIView *face = [self.view viewWithTag:4];
        [face setHidden:YES];
        UITextView *txt = (UITextView *)[self.view viewWithTag:3];
        txt.text = @"";
        txt.frame = CGRectMake( 142.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
        addPhotoTimes = 0;
        [self.photoes removeAllObjects];
        [self.footView setHidden:NO];
    }
        
}

-(void)imgBtn:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
}

-(void)backToPost:(UIButton *)btn
{
    if (isPersonalPost) {
        PersonalPostViewController *ppc = [[PersonalPostViewController alloc] init];
        [self presentViewController:ppc animated:NO completion:nil];
        [ppc release];
    }else{
        PostViewController *posts = [[PostViewController alloc] init];
        posts.titleName = self.starName;
        posts.moderatorsId = self.starIndex;
        [self presentViewController:posts animated:NO completion:nil];
        [posts release];
    }
}

-(void)praise:(UIButton *)btn
{

    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.isLogin) {
        
        PostPraise *pp = [[PostPraise alloc] init];
        pp.postId = self.postId;
        [pp postPraise];
        [pp release];
        
        self.praiseNum+=1;
        [self.praiseArray addObject:self.myPortrait];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:@"您还未登陆，无法进行该操作。请先登陆！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil];
        [alert show];
        [alert release];
    }
    
    [self.table reloadData];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"cancel");
    }else{
        
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:NO completion:nil];
        [login release];
        
    }
    if (alertView == postAlertView && buttonIndex ==1) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:NO completion:nil];
        [login release];
    }
}

-(void)focus: (UIButton *)btn
{
    PostFocus *pf = [[PostFocus alloc] init];
    [pf postFocus:self.postUserId];
    [pf release];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注成功！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)replyCommentary:(UIButton *)btn
{
    UIView *view = [self.view viewWithTag:2];
    [view setHidden:NO];
    self.isReplyCommentary = YES;
    self.replyParentId = [self.idsArray objectAtIndex:btn.tag-201];
}

-(void)reply:(UIButton *)btn
{
    [self.footView setHidden:YES];

    UIView *view = [self.view viewWithTag:2];
    [view setHidden:NO];
}

-(void)childReply:(NSNotification *)noti
{
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
    NSLog(@"%f",height);
    UIView *view = [self.view viewWithTag:2];
    [view setFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-view.frame.size.height-height, VIEW_FRAME_WIDTH, view.frame.size.height)];
    
    CATransition* transition = [CATransition animation];
    [transition setDuration:0.48];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:transition forKey:kCATransition];
}

-(void)share:(UIButton *)btn
{
    
    NSString * shareContent = [NSString stringWithString:self.content];
    NSLog(@"share content=%@\n",shareContent);
    NSLog(@"title:%@",self.postTitle);
    //分享图片为空,则填入默认图片
    if (self.image.length == 0) {
        self.image =@"http://list.image.baidu.com/t/yingshi.jpg";
    }
    else{
    }
    id<ISSContent> publishContent = [ShareSDK content:shareContent
                                       defaultContent:@"宠物星球分享"
                                                image:[ShareSDK imageWithUrl:self.image]
                                                title:self.postTitle
                                                  url:@"http://www.petplanetzone.com"
                                          description:shareContent
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type,SSResponseState state,id<ISSPlatformShareInfo>statusInfo,id<ICMErrorInfo>error,BOOL end){
                                if (state == SSResponseStateSuccess) {
                                    NSLog(@"分享成功-------\n");
                                }
                                else if(state == SSResponseStateFail){
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

-(void)collectPost:(UIButton *)btn
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
   
    if (appDelegate.isLogin) {
        
        PostCollect *pc = [[PostCollect alloc] init];
        [pc postCollection:self.postId];
        [pc release];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:@"您还未登陆，无法进行该操作。请先登陆！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil];
        [alert show];
        [alert release];
    }
    
}

-(void)cancel:(UIButton *)btn
{
    UIView *view = [self.view viewWithTag:1];
    [view removeFromSuperview];
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

-(void)dealloc
{
    [idsArray release];
    [customerNameArray release];
    [customerPortraitArray release];
    [petNames release];
    [petAgeArray release];
    [contents release];
    [pics release];
    [createTimeArray release];
    [childArray release];
    [content release];
    [postTitle release];
    [petNameTxt release];
    [petPortrait release];
    [usrPortrait release];
    [image release];
    [contImg release];
    [userName release];
    [breed release];
    [region release];
    [timeTxt release];
    [table release];
    [praiseArray release];
    [starName release];
    [replyArray release];
    [footView release];
    [filePath release];
    [fileData release];
    [photoes release];
    [myPortrait release];

    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"REPLY" object:nil];
    [super dealloc];
}

@end
