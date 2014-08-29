//
//  PersonalInfoView.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PersonalInfoView.h"
#import "DottedLine.h"
#import "PostFocus.h"
#import "GetUserData.h"
#import "UIImageView+WebCache.h"

@implementation PersonalInfoView
@synthesize sv,svImg,pc,svImgCurrentPage,scrollLeftOrRight,userId,starIndex,starName,dic,pNameLbl,fNumLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0]];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect frame = rect;
    
//    [self setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0]];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 128.0/1136.0*frame.size.height)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*frame.size.width, 65.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 39.0/1136.0*frame.size.height)];
    titleText.text = @"Moko窝";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*frame.size.width, 53.0/1136.0*frame.size.height, 63.0/640.0*frame.size.width, 61.0/1136.0*frame.size.height);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToCon:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UIButton *attBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    attBtn.frame = CGRectMake(548.0/640.0*frame.size.width, 53.0/1136.0*frame.size.height, 63.0/640.0*frame.size.width, 64.0/1136.0*frame.size.height);
    [attBtn setBackgroundImage:[UIImage imageNamed:@"preview_icon.png"] forState:UIControlStateNormal];
    [attBtn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:attBtn];
    
    [barView release];
    [titleText release];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake( 0.0/640.0*frame.size.width, 128.0/1136.0*frame.size.height, 640.0/640.0*frame.size.width, 540.0/1136.0*frame.size.height)];
   // [background setBackgroundColor:[UIColor blackColor]];
     [background setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"backdrop"] ] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    [background setUserInteractionEnabled:YES];
    [self addSubview:background];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 224.0/640.0*frame.size.width, 165.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 180.0/1136.0*frame.size.height)];
    [headImg setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"portrait"] ] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    headImg.layer.cornerRadius = headImg.bounds.size.width/2;
    [headImg.layer setBorderWidth:2];
    [headImg.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    headImg.layer.masksToBounds = YES;
    [background addSubview:headImg];
    
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(174.0/640.0*frame.size.width, 364.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 293.0/640.0*frame.size.width, 35.0/1136.0*frame.size.height)];
    nameText.text = [self.dic objectForKey:@"name"];
    nameText.textAlignment = UITextAlignmentCenter;
    nameText.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [nameText setFont:[UIFont fontWithName:@"Arial" size:18.0]];
    [nameText setEnabled:NO];
    [background addSubview:nameText];
    
    UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake( 225.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 18.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    if ([[self.dic objectForKey:@"sex"] intValue] == 0) {
        [sexImg setImage:[UIImage imageNamed:@"girl_02.png"]];
    }else{
        [sexImg setImage:[UIImage imageNamed:@"boy_02.png"]];
    }
    
    [background addSubview:sexImg];
    
    UILabel *sexLbl = [[UILabel alloc] initWithFrame:CGRectMake( 245.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 74.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    if ([[self.dic objectForKey:@"sex"] isEqualToString:@"0"]) {
        sexLbl.text = @"妹子";
    }else
    {
        sexLbl.text = @"帅哥";
    }
    
    sexLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    sexLbl.textColor = [UIColor whiteColor];
    [background addSubview:sexLbl];
    
    UIImageView *locImg = [[UIImageView alloc] initWithFrame:CGRectMake( 334.0/640.0*frame.size.width, 406.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 22.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height)];
    [locImg setImage:[UIImage imageNamed:@"pin.png"]];
    [background addSubview:locImg];
    
    UILabel *locLbl = [[UILabel alloc] initWithFrame:CGRectMake( 358.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 74.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    locLbl.text = [self.dic objectForKey:@"region"];
    locLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    locLbl.textColor = [UIColor whiteColor];
    [background addSubview:locLbl];
    
    [headImg release];
    [nameText release];
    [sexImg release];
    [sexLbl release];
    [locImg release];
    [locLbl release];
    
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake( 0.0/640.0*frame.size.width, 470.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, frame.size.width, 170.0/1136.0*frame.size.height)];
    sv.delegate = self;
    sv.showsHorizontalScrollIndicator = NO;
    sv.contentSize = CGSizeMake(364.0/640.0*frame.size.width*[[self.dic objectForKey:@"pets"] count], 170.0/1136.0*frame.size.height); 
    sv.tag = 10;
    sv.pagingEnabled = NO;
    sv.bounces = NO;
    sv.contentOffset = CGPointMake(344.0/640.0*frame.size.width, 0);
    [background addSubview:sv];
    
    //NSLog(@"self.dic::::%@",self.dic);
  //宠物信息
    for (int i = 0; i < [[self.dic objectForKey:@"pets"] count]; i++) {
        UIImageView *petInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake(364.0/640.0*frame.size.width*i, 0, 344.0/640.0*frame.size.width, 170.0/1136.0*frame.size.height)];
        [petInfoImg setImage:[UIImage imageNamed:@"stamp_type.png"]];
        [self.sv addSubview:petInfoImg];
        
        UIImageView *petImg = [[UIImageView alloc] initWithFrame:CGRectMake( 32.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height, 116.0/640.0*frame.size.width, 116.0/1136.0*frame.size.height)];
        [petImg setImageWithURL:[[[self.dic objectForKey:@"pets"] objectAtIndex:i] objectForKey:@"portrait"] placeholderImage:[UIImage imageNamed:@"wait.png"]];
        petImg.layer.cornerRadius = petImg.bounds.size.width/2;
        [petImg.layer setBorderWidth:2];
        [petImg.layer setBorderColor:[[UIColor grayColor] CGColor]];
        petImg.layer.masksToBounds = YES;
        [petInfoImg addSubview:petImg];
        
        self.pNameLbl = [[UILabel alloc] initWithFrame:CGRectMake( 157.0/640.0*frame.size.width, 37.0/1136.0*frame.size.height, 60.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height)];
        pNameLbl.text = [[[self.dic objectForKey:@"pets"] objectAtIndex:i] objectForKey:@"name"];
        pNameLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
        pNameLbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
        [petInfoImg addSubview:pNameLbl];
        
        UILabel *pVarietiesLbl = [[UILabel alloc] initWithFrame:CGRectMake( 160.0/640.0*frame.size.width, 77.0/1136.0*frame.size.height, 48.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height)];
        pVarietiesLbl.text = [[[self.dic objectForKey:@"pets"] objectAtIndex:i] objectForKey:@"breed"];
        pVarietiesLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        pVarietiesLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        [petInfoImg addSubview:pVarietiesLbl];
        
        UILabel *birthLbl = [[UILabel alloc] initWithFrame:CGRectMake( 158.0/640.0*frame.size.width, 111.0/1136.0*frame.size.height, 120.0/640.0*frame.size.width, 20.0/1136.0*frame.size.height)];
        birthLbl.text = [[[self.dic objectForKey:@"pets"] objectAtIndex:i] objectForKey:@"birthday"];
        birthLbl.font = [UIFont fontWithName:@"Arial" size:12.0];
        birthLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        [petInfoImg addSubview:birthLbl];
        
        UIImageView *postImg = [[UIImageView alloc] initWithFrame:CGRectMake( 252.0/640.0*frame.size.width, 98.0/1136.0*frame.size.height, 94.0/640.0*frame.size.width, 66.0/1136.0*frame.size.height)];
        [postImg setImage:[UIImage imageNamed:@"postmark.png"]];
        [petInfoImg addSubview:postImg];
        
        [petInfoImg release];
        [petImg release];
        [pNameLbl release];
        [pVarietiesLbl release];
        [birthLbl release];
        [postImg release];
    }
    
    [background release];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake( 0.0/640.0*frame.size.width, 702.0/1136.0*frame.size.height, 640.0/640.0*frame.size.width, 160.0/1136.0*frame.size.height)];
    [statusView setBackgroundColor:[UIColor whiteColor]];
    [statusView setUserInteractionEnabled:YES];
    [self addSubview:statusView];
    
    for (int j = 0; j<4; j++) {
        UIImageView *sepImg = [[UIImageView alloc] initWithFrame:CGRectMake( 127.0/640.0*frame.size.width+128.0/640.0*frame.size.width*j, 17.0/1136.0*frame.size.height, 1.0/640.0*frame.size.width, 126.0/1136.0*frame.size.height)];
        [sepImg setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
        [statusView addSubview:sepImg];
        
        [sepImg release];
    }
    
    UIButton *fansBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fansBtn.frame = CGRectMake( 42.0/640.0*frame.size.width, 17.0/1136.0*frame.size.height, 44.0/640.0*frame.size.width, 40.0/1136.0*frame.size.height);
    [fansBtn setBackgroundImage:[UIImage imageNamed:@"fans.png"] forState:UIControlStateNormal];
    [fansBtn addTarget:self action:@selector(goToFansSection:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:fansBtn];
    
    
    UILabel *fansLbl = [[UILabel alloc] initWithFrame:CGRectMake( 39.0/640.0*frame.size.width, 75.0/1136.0*frame.size.height, 50.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    fansLbl.text = @"粉丝";
    fansLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    fansLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    fansLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:fansLbl];
    
    self.fNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 50.0/640.0*frame.size.width, 122.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 19.0/1136.0*frame.size.height)];
    fNumLbl.text = [self.dic objectForKey:@"fans"];
    fNumLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    fNumLbl.textColor = [UIColor blackColor];
    fNumLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:fNumLbl];
    
    [fansLbl release];
    [fNumLbl release];
    
    UIButton *atteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    atteBtn.frame = CGRectMake( 167.0/640.0*frame.size.width, 21.0/1136.0*frame.size.height, 48.0/640.0*frame.size.width, 30.0/1136.0*frame.size.height);
    [atteBtn setBackgroundImage:[UIImage imageNamed:@"attention.png"] forState:UIControlStateNormal];
    [atteBtn addTarget:self action:@selector(goToAttentionSection:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:atteBtn];
    
    UILabel *attLbl = [[UILabel alloc] initWithFrame:CGRectMake( 167.0/640.0*frame.size.width, 75.0/1136.0*frame.size.height, 50.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    attLbl.text = @"关注";
    attLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    attLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    attLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:attLbl];
    
    UILabel *aNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 178.0/640.0*frame.size.width, 122.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 19.0/1136.0*frame.size.height)];
    aNumLbl.text = [self.dic objectForKey:@"focus"];
    aNumLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    aNumLbl.textColor = [UIColor blackColor];
    aNumLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:aNumLbl];
    
    [attLbl release];
    [aNumLbl release];
    
    UIButton *fotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fotoBtn.frame = CGRectMake( 300.0/640.0*frame.size.width, 22.0/1136.0*frame.size.height, 40.0/640.0*frame.size.width, 30.0/1136.0*frame.size.height);
    [fotoBtn setBackgroundImage:[UIImage imageNamed:@"photoicon.png"] forState:UIControlStateNormal];
    [fotoBtn addTarget:self action:@selector(goToFotoWall:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:fotoBtn];
    
    UILabel *fotoLbl = [[UILabel alloc] initWithFrame:CGRectMake( 295.0/640.0*frame.size.width, 75.0/1136.0*frame.size.height, 50.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    fotoLbl.text = @"相片";
    fotoLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    fotoLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    fotoLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:fotoLbl];
    
    UILabel *pNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 306.0/640.0*frame.size.width, 122.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 19.0/1136.0*frame.size.height)];
    pNumLbl.text = [self.dic objectForKey:@"photoNum"];
    pNumLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    pNumLbl.textColor = [UIColor blackColor];
    pNumLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:pNumLbl];
    
    [fotoLbl release];
    [pNumLbl release];
    
    UIButton *blogBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    blogBtn.frame = CGRectMake( 430.0/640.0*frame.size.width, 15.0/1136.0*frame.size.height, 32.0/640.0*frame.size.width, 40.0/1136.0*frame.size.height);
    [blogBtn setBackgroundImage:[UIImage imageNamed:@"post_icon.png"] forState:UIControlStateNormal];
    [blogBtn addTarget:self action:@selector(goToMyPost:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:blogBtn];
    
    UILabel *blogLbl = [[UILabel alloc] initWithFrame:CGRectMake( 423.0/640.0*frame.size.width, 75.0/1136.0*frame.size.height, 50.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    blogLbl.text = @"帖子";
    blogLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    blogLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    blogLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:blogLbl];
    
    UILabel *bNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 434.0/640.0*frame.size.width, 122.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 19.0/1136.0*frame.size.height)];
    bNumLbl.text = [self.dic objectForKey:@"postNum"];
    bNumLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    bNumLbl.textColor = [UIColor blackColor];
    bNumLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:bNumLbl];
    
    [blogLbl release];
    [bNumLbl release];
    
    UIButton *collBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    collBtn.frame = CGRectMake( 554.0/640.0*frame.size.width, 16.0/1136.0*frame.size.height, 44.0/640.0*frame.size.width, 42.0/1136.0*frame.size.height);
    [collBtn setBackgroundImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    [collBtn addTarget:self action:@selector(goToCollectedSection:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:collBtn];
    
    UILabel *collLbl = [[UILabel alloc] initWithFrame:CGRectMake( 551.0/640.0*frame.size.width, 75.0/1136.0*frame.size.height, 50.0/640.0*frame.size.width, 24.0/1136.0*frame.size.height)];
    collLbl.text = @"收藏";
    collLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    collLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    collLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:collLbl];
    
    UILabel *cNumLbl = [[UILabel alloc] initWithFrame:CGRectMake( 562.0/640.0*frame.size.width, 122.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 19.0/1136.0*frame.size.height)];
    cNumLbl.text = [self.dic objectForKey:@"collectNum"];
    cNumLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    cNumLbl.textColor = [UIColor blackColor];
    cNumLbl.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:cNumLbl];
    
    [collLbl release];
    [cNumLbl release];
    
    [statusView release];
    
    UILabel *mengLbl = [[UILabel alloc] initWithFrame:CGRectMake( 264.0/640.0*frame.size.width, 909.0/1136.0*frame.size.height, 118.0/640.0*frame.size.width, 30.0/1136.0*frame.size.height)];
    mengLbl.text = @"萌宠卖萌";
    mengLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    mengLbl.textColor = [UIColor colorWithRed:255.0/255.0 green:132.0/255.0 blue:144.0/255.0 alpha:1.0];
    mengLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:mengLbl];
    
    DottedLine *dl = [[DottedLine alloc] initWithFrame:CGRectMake( 10.0/640.0*frame.size.width, 924.0/1136.0*frame.size.height, 244.0/640.0*frame.size.width, 2.0/1136.0*frame.size.height)];
    [dl setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
    [self addSubview:dl];
    
    DottedLine *dll = [[DottedLine alloc] initWithFrame:CGRectMake( 392.0/640.0*frame.size.width, 924.0/1136.0*frame.size.height, 235.0/640.0*frame.size.width, 2.0/1136.0*frame.size.height)];
    [dll setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
    [self addSubview:dll];
    
    self.svImg = [[UIScrollView alloc] initWithFrame:CGRectMake( 20.0/640.0*frame.size.width, 970.0/1136.0*frame.size.height, 582.0/640.0*frame.size.width, 136.0/1136.0*frame.size.height)];
    svImg.delegate = self;
    svImg.showsHorizontalScrollIndicator = NO;
    svImg.showsVerticalScrollIndicator = NO;
    
    svImg.contentSize = CGSizeMake(frame.size.width
                                   *3, 136.0/1136.0*frame.size.height); //3改成[arry count]/4
    svImg.tag = 11;
    svImg.pagingEnabled = YES;
    svImg.bounces = NO;
    [self addSubview:svImg];
    
    svImgCurrentPage = 1;
    
    //    self.pc = [[UIPageControl alloc] initWithFrame:CGRectMake( 264.0/640.0*VIEW_FRAME_WIDTH, 650.0/1136.0*VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT,108.0/640.0*VIEW_FRAME_WIDTH, 2.0/1136.0*VIEW_FRAME_HEIGHT)];
    //    pc.numberOfPages = 3;
    //    pc.currentPage = 0;
    //    [pc addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    //    [self.view addSubview:pc];
    
    for (int k = 0; k < 12; k ++) {
        UIImageView *pImg = [[UIImageView alloc] initWithFrame:CGRectMake( 146.0/640.0*frame.size.width*k, 0.0/1136.0*frame.size.height, 136.0/640.0*frame.size.width, 136.0/1136.0*frame.size.height)];
        [pImg setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
        [svImg addSubview:pImg];
        
        [pImg release];
        
    }
    
    UIButton *turnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    turnBtn.frame = CGRectMake( 611.0/640.0*frame.size.width, 1032.0/1136.0*frame.size.height, 16.0/640.0*frame.size.width, 28.0/1136.0*frame.size.height);
    [turnBtn setBackgroundImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    [turnBtn addTarget:self action:@selector(scrollViewMove:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:turnBtn];

}

-(void)scrollViewMove:(UIButton *)btn
{
    svImgCurrentPage ++;
    
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = svImg.frame.size;
    CGRect rect = CGRectMake(svImgCurrentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [svImg scrollRectToVisible:rect animated:YES];
    
    
    
    if (svImgCurrentPage == 12/4) {
        svImgCurrentPage = 0;
    }
    
}

-(void)backToCon:(UIButton *)btn
{
//    ContentViewController *content = [[ContentViewController alloc] init];
//    content.starName = self.starName;
//    content.starIndex = self.starIndex;
//    [self presentViewController:content animated:NO completion:nil];
//    [content release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOCON" object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 10) {
        
        //        CGPoint offset = scrollView.contentOffset;
        //        CGRect bounds = CGRectMake(0, 0, 344.0/640.0*VIEW_FRAME_WIDTH, 170.0/1136.0*VIEW_FRAME_HEIGHT);
        //        [pc setCurrentPage:offset.x / bounds.size.width];
        
    }else if (scrollView.tag == 11){
        
        //Selected index's color changed.
        static float newx = 0;
        static float oldx = 0;
        newx= scrollView.contentOffset.x ;
        if (newx != oldx ) {
            //Left-YES,Right-NO
            if (newx > oldx) {
                self.scrollLeftOrRight = NO;
            }else if(newx < oldx){
                self.scrollLeftOrRight = YES;
            }
            oldx = newx;
        }
    }
    
    //    appDelegate=[[UIApplication sharedApplication] delegate];
    //    City *c = [appDelegate.cities objectAtIndex:pc.currentPage];
    //    self.cName = c.cityName;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!self.scrollLeftOrRight) {
        svImgCurrentPage ++;
        if (svImgCurrentPage == 12/4) {
            svImgCurrentPage = 0;
        }
    }else{
        if (svImgCurrentPage == 0) {
            svImgCurrentPage = 12/4;
        }
        svImgCurrentPage --;
    }
}

-(void)goToCollectedSection:(UIButton *)btn
{
//    CollectedSectionViewController *colSec = [[CollectedSectionViewController alloc] init];
//    [self presentViewController:colSec animated:NO completion:nil];
//    [colSec release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOCOL" object:nil];
}

-(void)goToMyPost:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOPOS" object:nil];
}

-(void)goToAttentionSection:(UIButton *)btn
{
//    AttentionViewController *avc = [[AttentionViewController alloc] init];
//    [self presentViewController:avc animated:NO completion:nil];
//    [avc release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOATT" object:nil];
}

-(void)goToFansSection:(UIButton *)btn
{
//    FansViewController *fans = [[FansViewController alloc] init];
//    [self presentViewController:fans animated:NO completion:nil];
//    [fans release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOFAN" object:nil];
}

-(void)goToFotoWall:(UIButton *)btn
{
//    FotoWallViewController *foto = [[FotoWallViewController alloc] init];
//    [self presentViewController:foto animated:NO completion:nil];
//    [foto release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOFOT" object:nil];
}

-(void)focus: (UIButton *)btn
{
    PostFocus *pf = [[PostFocus alloc] init];
    [pf postFocus:self.userId];
    [pf release];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注成功！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)dealloc
{
    [sv release];
    [starName release];
    [svImg release];
    [pc release];
    [dic release];
    [pNameLbl release];
    [super dealloc];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end