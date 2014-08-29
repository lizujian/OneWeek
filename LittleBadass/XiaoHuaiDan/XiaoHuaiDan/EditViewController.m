//
//  EditViewController.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/22.
//  Copyright (c) 2014年 sch. All rights reserved.
//


//starbutton tag 51-55

#import "EditViewController.h"
#import "MainViewController.h"
#import "PostViewController.h"
#import "SendPost.h"
#import "PostPhoto.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize starName,footImgOne,footImgTwo,footImgThr,footImgFou,footImgFiv,postTitle,postContent,picsArray,selectedStar,scrollView,fileData,filePath,img,photoes,addPhotoTimes,isTitle,n;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-128.0/1136.0*self.view.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    n = 0;
    self.picsArray = [NSMutableArray arrayWithCapacity:0];
    self.photoes = [NSMutableArray arrayWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];//键盘将要显示的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];//键盘将要隐藏的通知
    
    [self.view setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    

    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(284.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 74.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"发帖";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*320.0, 53.0/1136.0*568.0, 63.0/640.0*320.0, 61.0/1136.0*568.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    editBtn.frame = CGRectMake(548.0/640.0*320.0, 53.0/1136.0*568.0, 63.0/640.0*320.0, 64.0/1136.0*568.0);
    [editBtn setBackgroundImage:[UIImage imageNamed:@"mail_alt.png"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(mail:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:editBtn];
    
    [barView release];
    [titleText release];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 1.5*VIEW_FRAME_HEIGHT)];
    scrollView.delegate = self;
//    scrollView.contentSize = CGSizeMake(VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT+150.0/1136.0*VIEW_FRAME_HEIGHT);
    [scrollView setBackgroundColor:[UIColor clearColor]];
    //    scrollView.tag = 55;
    //    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = YES;
    [scrollView setUserInteractionEnabled:YES];
    [self.view addSubview:scrollView];
    
    UIButton *starOne = [UIButton buttonWithType:UIButtonTypeSystem];
    starOne.frame = CGRectMake( 49.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 78.0/1136.0*VIEW_FRAME_HEIGHT);//128
    starOne.tag = 51;
    [starOne setBackgroundImage:[UIImage imageNamed:@"tweeta_a.png"] forState:UIControlStateNormal];
    [starOne addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starOne];
    
    UIButton *starTwo = [UIButton buttonWithType:UIButtonTypeSystem];
    starTwo.frame = CGRectMake( 164.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 78.0/1136.0*VIEW_FRAME_HEIGHT);//128
    starTwo.tag = 52;
    [starTwo setBackgroundImage:[UIImage imageNamed:@"photo_a.png"] forState:UIControlStateNormal];
    [starTwo addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starTwo];

    UIButton *starThr = [UIButton buttonWithType:UIButtonTypeSystem];
    starThr.frame = CGRectMake( 279.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 78.0/1136.0*VIEW_FRAME_HEIGHT);//128
    starThr.tag = 53;
    [starThr setBackgroundImage:[UIImage imageNamed:@"wang_a.png"] forState:UIControlStateNormal];
    [starThr addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starThr];
    
    UIButton *starFou = [UIButton buttonWithType:UIButtonTypeSystem];
    starFou.frame = CGRectMake( 396.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 78.0/1136.0*VIEW_FRAME_HEIGHT);//128
    starFou.tag = 54;
    [starFou setBackgroundImage:[UIImage imageNamed:@"meowth_a.png"] forState:UIControlStateNormal];
    [starFou addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starFou];
    
    UIButton *starFiv = [UIButton buttonWithType:UIButtonTypeSystem];
    starFiv.frame = CGRectMake( 512.0/640.0*VIEW_FRAME_WIDTH, 19.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 78.0/640.0*VIEW_FRAME_WIDTH, 78.0/1136.0*VIEW_FRAME_HEIGHT);//128
    starFiv.tag = 55;
    [starFiv setBackgroundImage:[UIImage imageNamed:@"feeds_a.png"] forState:UIControlStateNormal];
    [starFiv addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starFiv];
    
    self.footImgOne = [[UIImageView alloc] initWithFrame:CGRectMake( 70.0/640.0*VIEW_FRAME_WIDTH, 136.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 28.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
    [footImgOne setImage:[UIImage imageNamed:@"footprint_02.png"]];//128
    [self.view addSubview:footImgOne];
    
    self.footImgTwo = [[UIImageView alloc] initWithFrame:CGRectMake( 189.0/640.0*VIEW_FRAME_WIDTH, 136.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 28.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
    [footImgTwo setImage:[UIImage imageNamed:@"footprint_02.png"]];
    [self.view addSubview:footImgTwo];
    
    self.footImgThr = [[UIImageView alloc] initWithFrame:CGRectMake( 306.0/640.0*VIEW_FRAME_WIDTH, 136.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 28.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
    [footImgThr setImage:[UIImage imageNamed:@"footprint_02.png"]];
    [self.view addSubview:footImgThr];
    
    self.footImgFou = [[UIImageView alloc] initWithFrame:CGRectMake( 422.0/640.0*VIEW_FRAME_WIDTH, 136.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 28.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
    [footImgFou setImage:[UIImage imageNamed:@"footprint_02.png"]];
    [self.view addSubview:footImgFou];
    
    self.footImgFiv = [[UIImageView alloc] initWithFrame:CGRectMake( 546.0/640.0*VIEW_FRAME_WIDTH, 136.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 28.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
    [footImgFiv setImage:[UIImage imageNamed:@"footprint_02.png"]];
    [self.view addSubview:footImgFiv];
    
    UITextField *oneTxt = [[UITextField alloc] initWithFrame:CGRectMake( 55.0/640.0*VIEW_FRAME_WIDTH, 105.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    oneTxt.text = @"吐槽星";
    [oneTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0]];
    oneTxt.textColor = [UIColor colorWithRed:231.0/255.0 green:86.0/255.0 blue:219.0/255.0 alpha:1.0];
    [oneTxt setEnabled:NO];
    [self.view addSubview:oneTxt];
    
    UITextField *twoTxt = [[UITextField alloc] initWithFrame:CGRectMake( 173.0/640.0*VIEW_FRAME_WIDTH, 104.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT)];
    twoTxt.text = @"爆照星";
    [twoTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0]];
    twoTxt.textColor = [UIColor colorWithRed:255.0/255.0 green:81.0/255.0 blue:91.0/255.0 alpha:1.0];
    [twoTxt setEnabled:NO];
    [self.view addSubview:twoTxt];
    
    UITextField *thrTxt = [[UITextField alloc] initWithFrame:CGRectMake( 289.0/640.0*VIEW_FRAME_WIDTH, 104.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT)];
    thrTxt.text = @"汪汪星";
    [thrTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0]];
    thrTxt.textColor = [UIColor colorWithRed:0.0/255.0 green:216.0/255.0 blue:125.0/255.0 alpha:1.0];
    [thrTxt setEnabled:NO];
    [self.view addSubview:thrTxt];
    
    UITextField *fouTxt = [[UITextField alloc] initWithFrame:CGRectMake( 406.0/640.0*VIEW_FRAME_WIDTH, 104.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT)];
    fouTxt.text = @"喵喵星";
    [fouTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0]];
    fouTxt.textColor = [UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:245.0/255.0 alpha:1.0];
    [fouTxt setEnabled:NO];
    [self.view addSubview:fouTxt];

    UITextField *fivTxt = [[UITextField alloc] initWithFrame:CGRectMake( 520.0/640.0*VIEW_FRAME_WIDTH, 104.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 60.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT)];
    fivTxt.text = @"代养星";
    [fivTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0]];
    fivTxt.textColor = [UIColor colorWithRed:254.0/255.0 green:173.0/255.0 blue:0.0/255.0 alpha:1.0];
    [fivTxt setEnabled:NO];
    [self.view addSubview:fivTxt];
    
    [oneTxt release];
    [twoTxt release];
    [thrTxt release];
    [fouTxt release];
    [fivTxt release];
    
    self.postTitle = [[UITextField alloc] initWithFrame:CGRectMake( 19.0/640.0*VIEW_FRAME_WIDTH, 189.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 600.0/640.0*VIEW_FRAME_WIDTH, 81.0/1136.0*VIEW_FRAME_HEIGHT)];
    postTitle.placeholder = @"标题";
    postTitle.backgroundColor=[UIColor whiteColor];
    postTitle.delegate = self;
    [self.view addSubview:postTitle];
    
    UITapGestureRecognizer* textfieldTap;
    textfieldTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTap:)];
    textfieldTap.numberOfTapsRequired = 1; // 单击
    [postTitle addGestureRecognizer:textfieldTap];

    self.postContent = [[UITextView alloc] initWithFrame:CGRectMake( 20.0/640.0*VIEW_FRAME_WIDTH, 278.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 600.0/640.0*VIEW_FRAME_WIDTH, 570.0/1136.0*VIEW_FRAME_HEIGHT)];
    postContent.backgroundColor = [UIColor whiteColor];
    postContent.delegate = self;
    [postContent setEditable:NO];
    [self.view addSubview:postContent];
    
    UITapGestureRecognizer* textViewTap;
    textViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTap:)];
    textViewTap.numberOfTapsRequired = 1; // 单击
    [postContent addGestureRecognizer:textViewTap];
    
    [postTitle release];
    [postContent release];
    
    UIView *toolsView = [[UIView alloc] initWithFrame:CGRectMake( 19.0/640.0*VIEW_FRAME_WIDTH, 848.0/1136.0*VIEW_FRAME_HEIGHT+128.0/1136.0*VIEW_FRAME_HEIGHT, 600.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
    [toolsView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:toolsView];
    
    UITextField *cutoff = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, 540.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT)];
    cutoff.text = @"................................................................................................................................................................................................................................................";
    [cutoff setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:5.0]];
    cutoff.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [oneTxt setEnabled:NO];
    [cutoff setEnabled:NO];
    [toolsView addSubview:cutoff];
    
    UIButton *expression = [UIButton buttonWithType:UIButtonTypeSystem];
    expression.frame = CGRectMake( 32.0/640.0*VIEW_FRAME_WIDTH, 17.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [expression setBackgroundImage:[UIImage imageNamed:@"face_01.png"] forState:UIControlStateNormal];
//    [expression addTarget:self action:@selector(starTap:) forControlEvents:UIControlEventTouchUpInside];
//    [toolsView addSubview:expression];
    
    UIButton *photo = [UIButton buttonWithType:UIButtonTypeSystem];
    photo.frame = CGRectMake( 101.0/640.0*VIEW_FRAME_WIDTH, 17.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [photo setBackgroundImage:[UIImage imageNamed:@"printer.png"] forState:UIControlStateNormal];
    [photo addTarget:self action:@selector(showPhotoView:) forControlEvents:UIControlEventTouchUpInside];
//    [toolsView addSubview:photo];
    
    [toolsView release];
    [cutoff release];
    
    UITapGestureRecognizer* singleTapRecognizer;
    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    [self.view addGestureRecognizer:singleTapRecognizer];
    
    [singleTapRecognizer release];
    [scrollView release];
    
    
    //==========================================
    
    
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
    
    UIButton *expressionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    expressionBtn.frame = CGRectMake(14.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [expressionBtn setBackgroundImage:[UIImage imageNamed:@"face_01.png"] forState:UIControlStateNormal];
    [expressionBtn addTarget:self action:@selector(showFace:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:expressionBtn];
    
    UIButton *fotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fotoBtn.frame = CGRectMake(80.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 50.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [fotoBtn setBackgroundImage:[UIImage imageNamed:@"printer.png"] forState:UIControlStateNormal];
    [fotoBtn addTarget:self action:@selector(showFotoView:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:fotoBtn];
    
    UITextView *replyText = [[UITextView alloc] initWithFrame:CGRectMake( 142.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
    [replyText setBackgroundColor:[UIColor whiteColor]];
    replyText.tag = 3;
    replyText.delegate = self;
    [replyView addSubview:replyText];
    
    UIButton *overBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    overBtn.frame = CGRectMake(554.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [overBtn setTitle:@"完成" forState:UIControlStateNormal];
    [overBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [overBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [overBtn addTarget:self action:@selector(inputEnd:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:overBtn];
    
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
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 38.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 121.0/1136.0*VIEW_FRAME_HEIGHT)];
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.contentSize = CGSizeMake(160.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
    sc.tag = 99;
    sc.pagingEnabled = NO;
    sc.bounces = NO;
    [sc setUserInteractionEnabled:YES];
    [fotoesView addSubview:sc];
    
    UIButton *addFotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addFotoBtn.frame = CGRectMake(20.0/640.0*VIEW_FRAME_WIDTH, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
    [addFotoBtn addTarget:self action:@selector(fotoDisplay:) forControlEvents:UIControlEventTouchUpInside];
    [addFotoBtn setBackgroundImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    addFotoBtn.tag = 97;
    [sc addSubview:addFotoBtn];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(210.0/640.0*VIEW_FRAME_WIDTH, 180.0/1136.0*VIEW_FRAME_HEIGHT, 230.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    lbl.text = @"已选0张，还有6张可选";
    lbl.tag = 6;
    lbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    lbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0];
    [fotoesView addSubview:lbl];
    
    [sc release];
    [lbl release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.isTitle = YES;
    return YES;
}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    self.isTitle = NO;
//    return YES;
//}

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


-(void)inputEnd:(UIButton *)btn
{
    UITextView *txtView = (UITextView *)[self.view viewWithTag:3];
    
    if (isTitle) {
        self.postTitle.text = txtView.text;
        self.isTitle = NO;
//        txtView.text = @"";
    }else{
        self.postContent.text = txtView.text;
//        txtView.text = @"";
    }
    
    [txtView resignFirstResponder];
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
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:104.0/255.0 blue:104.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [backImg addSubview:cancelBtn];
    
    [backImg release];
}


-(void)keyBoardWillShow:(NSNotification *)notif{

    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
    
    if (isTitle) {
        [self.postTitle resignFirstResponder];
    }else{
       [self.postContent resignFirstResponder];
    }
    
    UIView *fotoView = [self.view viewWithTag:60];
    [fotoView setHidden:YES];
    UIView *faceView = [self.view viewWithTag:4];
    [faceView setHidden:YES];

    UIView *replyView = [self.view viewWithTag:2];
    [replyView setHidden:NO];
    [replyView setFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-replyView.frame.size.height-height, VIEW_FRAME_WIDTH, replyView.frame.size.height)];
    
    UITextView *replyText = (UITextView *)[self.view viewWithTag:3];
    [replyText becomeFirstResponder];
    
    CATransition* transition = [CATransition animation];
    [transition setDuration:0.48];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [replyView.layer addAnimation:transition forKey:kCATransition];
    
    
}
-(void)keyBoardWillHidden:(NSNotification *)notif{

    UIView *replyView = [self.view viewWithTag:2];
    [replyView setHidden:YES];
}

-(void)titleTap:(UILongPressGestureRecognizer *)paramSender
{
    UITextView *replyText = (UITextView *)[self.view viewWithTag:3];
    [replyText becomeFirstResponder];
    isTitle = YES;
    replyText.text = self.postTitle.text;
}

-(void)singleTap:(UILongPressGestureRecognizer *)paramSender{
    [self.postTitle resignFirstResponder];
    [self.postContent resignFirstResponder];
}

-(void)textViewTap:(UILongPressGestureRecognizer *)paramSender{
    UITextView *replyText = (UITextView *)[self.view viewWithTag:3];
    [replyText becomeFirstResponder];
    isTitle = NO;
    replyText.text = self.postContent.text;
}

-(void)showPhotoView:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
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
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
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
    UIScrollView *sc = (UIScrollView *)[self.view viewWithTag:99];
    sc.contentSize = CGSizeMake(140.0/640.0*VIEW_FRAME_WIDTH*([self.photoes count]+1), 120.0/1136.0*VIEW_FRAME_HEIGHT);
    
    for (int i = 0; i< [self.photoes count]; i++ ) {
        UIImageView *addedImg = [[UIImageView alloc] initWithFrame:CGRectMake( 20.0/640.0*VIEW_FRAME_WIDTH*(i+1)+120.0/1136.0*VIEW_FRAME_HEIGHT*i, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT)];
        [addedImg  setImage:[UIImage imageWithContentsOfFile:[self.photoes objectAtIndex:i]]];
        [addedImg setUserInteractionEnabled:YES];
        addedImg.tag = 80+i;
        [sc addSubview:addedImg];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        deleteBtn.frame = CGRectMake(84.0/640.0*VIEW_FRAME_WIDTH, 0, 36.0/640.0*VIEW_FRAME_WIDTH, 36.0/1136.0*VIEW_FRAME_HEIGHT);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delelte_icon.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = 90 + i ;
        [addedImg addSubview:deleteBtn];
        
        [addedImg release];
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:97];
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

-(void)deleteImg:(UIButton *)btn
{
//    [btn.superview removeFromSuperview];
    [self.photoes removeObjectAtIndex:btn.tag-90];
    
    UIScrollView *sview = (UIScrollView *)[self.view viewWithTag:99];
    sview.contentSize = CGSizeMake(140.0/640.0*VIEW_FRAME_WIDTH*([self.photoes count]+1), 120.0/1136.0*VIEW_FRAME_HEIGHT);
    
    for (UIView *view in sview.subviews) {
        if (view.tag-80 == btn.tag-90) {
            [view removeFromSuperview];
        }
        if (view.tag-80 > btn.tag-90) {
            view.frame = CGRectMake(view.frame.origin.x-140.0/640.0*VIEW_FRAME_WIDTH, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
    }
    
    UILabel *l = (UILabel *)[self.view viewWithTag:6];
    l.text = [NSString stringWithFormat:@"已选%d张，还有%d张可选",[self.photoes count],6-[self.photoes count]];
    
    //    UIButton *button = (UIButton *)[self.view viewWithTag:58];
    //    button.frame = CGRectMake( button.frame.origin.x-140.0/640.0*VIEW_FRAME_WIDTH, 1.0/1136.0*VIEW_FRAME_HEIGHT, 120.0/640.0*VIEW_FRAME_WIDTH, 120.0/1136.0*VIEW_FRAME_HEIGHT);
}


-(void)cancel:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

-(void)backToLastPage:(UIButton *)btn
{
    PostViewController *pvc = [[PostViewController alloc] init];
    pvc.titleName = self.starName;
    pvc.moderatorsId = self.starIndex;
    [self presentViewController:pvc animated:YES completion:nil];
    [pvc release];
}

-(void)mail:(UIButton *)btn
{
    SendPost *sp = [[SendPost alloc] init];
    
    if (selectedStar == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请先选择发布的星球！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }else if (self.postTitle.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入标题！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }else if (self.postContent.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入帖子内容！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }else{
        
        NSData *data = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fish.png"])];
        [self.picsArray addObject:data];
        
        [sp sendPost:self.selectedStar Title:self.postTitle.text Content:self.postContent.text Pics:self.picsArray];
        [sp release];
        
        [self.postTitle resignFirstResponder];
        [self.postContent resignFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发送成功啦！点击确定返回板块。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 8;
        alert.delegate = self;
        [alert show];
        [alert release];
        return;
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8) {
        PostViewController *pvc = [[PostViewController alloc] init];
        pvc.moderatorsId = self.starIndex;
        pvc.titleName = self.starName;
        [self presentViewController:pvc animated:NO completion:nil];
        [pvc release];
    }
    
}

-(void)starTap:(UIButton *)btn
{
    if (btn.tag == 51) {
        
        [self.footImgOne setImage:[UIImage imageNamed:@"footprint_01.png"]];
        [self.footImgTwo setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgThr setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFou setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFiv setImage:[UIImage imageNamed:@"footprint_02.png"]];
        self.selectedStar = 3;
        
    }else if (btn.tag == 52) {
        
        [self.footImgOne setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgTwo setImage:[UIImage imageNamed:@"footprint_01.png"]];
        [self.footImgThr setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFou setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFiv setImage:[UIImage imageNamed:@"footprint_02.png"]];
        self.selectedStar = 1;
        
    }else if (btn.tag == 53) {
        
        [self.footImgOne setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgTwo setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgThr setImage:[UIImage imageNamed:@"footprint_01.png"]];
        [self.footImgFou setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFiv setImage:[UIImage imageNamed:@"footprint_02.png"]];
        self.selectedStar = 4;
        
    }else if (btn.tag == 54) {
        
        [self.footImgOne setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgTwo setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgThr setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFou setImage:[UIImage imageNamed:@"footprint_01.png"]];
        [self.footImgFiv setImage:[UIImage imageNamed:@"footprint_02.png"]];
        self.selectedStar = 2;
        
    }else if (btn.tag == 55) {
        
        [self.footImgOne setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgTwo setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgThr setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFou setImage:[UIImage imageNamed:@"footprint_02.png"]];
        [self.footImgFiv setImage:[UIImage imageNamed:@"footprint_01.png"]];
        self.selectedStar = 5;
    }
}

-(void)dealloc
{
    [starName release];
    [footImgOne release];
    [footImgTwo release];
    [footImgThr release];
    [footImgFou release];
    [footImgFiv release];
    [postTitle release];
    [postContent release];
    [picsArray release];
    [scrollView release];
    [super dealloc];
}

@end
