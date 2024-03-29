//
//  SignViewController.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/29.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "SignViewController.h"
#import "MainViewController.h"
#import "DottedLine.h"
#import "FamiliesViewController.h"
#import "GetRegion.h"
#import "GetCities.h"
#import "PostCustomerData.h"
#import "PostPetData.h"
#import "PetFamily.h"
#import "UIButton+WebCache.h"
@interface SignViewController ()

@end

@implementation SignViewController
@synthesize sexChooseBtn,petSexChooseBtn,varChooseBtn,petBirthChooseBtn,pick,birthday,disChooseBtn,peoBtn,petBtn,cityPick,distrString,nameTxt,sexIndex,petSexIndex,usrName,petName,race,breed,petNameTxt,petPortrait;
@synthesize selectedRace;

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
    
    GetRegion *gRegion = [[GetRegion alloc] init];
    [gRegion getRegion];
    
//    NSMutableArray *regionsArr = [gRegion.regionDic objectForKey:@"regions"];
    
//    NSLog(@"%d",[regionsArr count]);
//    NSMutableDictionary *regionsAndCitiesDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
//    NSMutableArray *arr = [self.regionDic objectForKey:@"regions"];
//    for (int i = 0; i<[arr count]; i++) {
//        NSLog(@"%@",[[arr objectAtIndex:i] objectForKey:@"id"]);
//    }
    
//    GetCities *gCities = [[GetCities alloc] init];
    
//    for (int i = 0; i<[regionsArr count]; i++) {
//        gCities.citiyId = [[regionsArr objectAtIndex:i] objectForKey:@"id"];
//        [gCities getCities];
    
        
//    }
    
    
    [gRegion release];
 
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"通行证";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 61.0/1136.0*VIEW_FRAME_HEIGHT);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    [barView release];
    [titleText release];
    
    UIImageView *partOne = [[UIImageView alloc] initWithFrame:CGRectMake( 60.0/640.0*VIEW_FRAME_WIDTH, 150.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT)];
    [partOne setBackgroundColor:[UIColor whiteColor]];
    partOne.layer.cornerRadius = 5;//设置那个圆角的有多圆
    [partOne setUserInteractionEnabled:YES];
    [self.view addSubview:partOne];
    
    UIImageView *partTwo = [[UIImageView alloc] initWithFrame:CGRectMake( 60.0/640.0*VIEW_FRAME_WIDTH, 222.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 590.0/1136.0*VIEW_FRAME_HEIGHT)];
    [partTwo setBackgroundColor:[UIColor whiteColor]];
    partTwo.layer.cornerRadius = 5;
    [partTwo setUserInteractionEnabled:YES];
    [self.view addSubview:partTwo];
    
    UIImageView *partThr = [[UIImageView alloc] initWithFrame:CGRectMake( 60.0/640.0*VIEW_FRAME_WIDTH, 814.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 200.0/1136.0*VIEW_FRAME_HEIGHT)];
    [partThr setBackgroundColor:[UIColor whiteColor]];
    partThr.layer.cornerRadius = 5;
    [partThr setUserInteractionEnabled:YES];
    [self.view addSubview:partThr];

//part 1--------------------------------
    UILabel *welcomeLbl = [[UILabel alloc] initWithFrame:CGRectMake( 10.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT, 250.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
    welcomeLbl.text = @"宠物星球航班欢迎您";
    welcomeLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    welcomeLbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partOne addSubview:welcomeLbl];
    
    UILabel *passLbl = [[UILabel alloc] initWithFrame:CGRectMake( 354.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT, 150.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
    passLbl.text = @"星球通行证";
    passLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0];
    passLbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partOne addSubview:passLbl];
    
    [welcomeLbl release];
    [passLbl release];
 
//part 2 --------------------------------------------
    self.peoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    peoBtn.frame = CGRectMake(20.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 130.0/640.0*VIEW_FRAME_WIDTH, 130.0/1136.0*VIEW_FRAME_HEIGHT);
    [peoBtn setBackgroundImage:[UIImage imageNamed:@"master_head.png"] forState:UIControlStateNormal];
    [peoBtn addTarget:self action:@selector(setPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [peoBtn setImageWithURL:[NSURL URLWithString:@"http://hdn.xnimg.cn/photos/hdn121/20110922/1520/h_large_s1uj_3c530000632a2f75.jpgv"] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    [partTwo addSubview:peoBtn];
    
    UILabel *masterName = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 40.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    masterName.text = @"名字";
    masterName.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    masterName.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:masterName];
    
    UILabel *masterSex = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 100.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    masterSex.text = @"性别";
    masterSex.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    masterSex.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:masterSex];

    UILabel *distr = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 160.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    distr.text = @"地区";
    distr.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    distr.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:distr];
    
    self.nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
    nameTxt.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [nameTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0]];
    nameTxt.textAlignment = NSTextAlignmentCenter;
    [nameTxt setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    nameTxt.delegate= self;
    [partTwo addSubview:nameTxt];
    
    self.sexChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sexChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 88.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [self.sexChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.sexChooseBtn addTarget:self action:@selector(masterSexChoose:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:self.sexChooseBtn];
    
    self.disChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    disChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 148.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [disChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [disChooseBtn addTarget:self action:@selector(districtChoose:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:disChooseBtn];
    
    [masterName release];
    [masterSex release];
    [distr release];
    [nameTxt release];
    
    DottedLine *dl = [[DottedLine alloc] initWithFrame:CGRectMake( 0.0/640.0*VIEW_FRAME_WIDTH, 228.0/1136.0*VIEW_FRAME_HEIGHT, partTwo.frame.size.width, 2.0/1136.0*VIEW_FRAME_HEIGHT)];
    [dl setBackgroundColor:[UIColor whiteColor]];
    [partTwo addSubview:dl];
    
    [dl release];
    
    self.petBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    petBtn.frame = CGRectMake(20.0/640.0*VIEW_FRAME_WIDTH, 260.0/1136.0*VIEW_FRAME_HEIGHT, 130.0/640.0*VIEW_FRAME_WIDTH, 130.0/1136.0*VIEW_FRAME_HEIGHT);
    [petBtn setBackgroundImage:[UIImage imageNamed:@"pet_avatar.png"] forState:UIControlStateNormal];
    [petBtn addTarget:self action:@selector(setPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:petBtn];
    
    UILabel *petNameLbl = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 270.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    petNameLbl.text = @"名字";
    petNameLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    petNameLbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:petNameLbl];
    
    UILabel *petBirth = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 330.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    petBirth.text = @"生日";
    petBirth.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    petBirth.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:petBirth];
    
    UILabel *petSex = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 390.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    petSex.text = @"性别";
    petSex.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    petSex.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:petSex];
    
    UILabel *petVar = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 450.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    petVar.text = @"种族";
    petVar.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    petVar.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:petVar];
    
    UILabel *family = [[UILabel alloc] initWithFrame:CGRectMake( 180.0/640.0*VIEW_FRAME_WIDTH, 510.0/1136.0*VIEW_FRAME_HEIGHT, 55.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT)];
    family.text = @"家族";
    family.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
    family.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [partTwo addSubview:family];
    
    self.petNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 256.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT)];
    petNameTxt.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    [petNameTxt setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0]];
    petNameTxt.textAlignment = NSTextAlignmentCenter;
    [petNameTxt setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    petNameTxt.delegate = self;
    [partTwo addSubview:petNameTxt];
    
    self.petBirthChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.petBirthChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 316.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [self.petBirthChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.petBirthChooseBtn addTarget:self action:@selector(chooseBirth:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:self.petBirthChooseBtn];
    
    self.petSexChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.petSexChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 376.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [self.petSexChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.petSexChooseBtn addTarget:self action:@selector(choosePetSex:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:self.petSexChooseBtn];
    
    self.varChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.varChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 436.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [self.varChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.varChooseBtn addTarget:self action:@selector(choosePetVar:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:self.varChooseBtn];
    
    UIButton *famChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    famChooseBtn.frame = CGRectMake(259.0/640.0*VIEW_FRAME_WIDTH, 496.0/1136.0*VIEW_FRAME_HEIGHT, 240.0/640.0*VIEW_FRAME_WIDTH, 50.0/1136.0*VIEW_FRAME_HEIGHT);
    [famChooseBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [famChooseBtn addTarget:self action:@selector(familyChoose:) forControlEvents:UIControlEventTouchUpInside];
    [partTwo addSubview:famChooseBtn];
    
    UIImageView *codeImg = [[UIImageView alloc] initWithFrame:CGRectMake( 64.0/640.0*VIEW_FRAME_WIDTH, 406.0/1136.0*VIEW_FRAME_HEIGHT, 58.0/640.0*VIEW_FRAME_WIDTH, 140.0/1136.0*VIEW_FRAME_HEIGHT)];
    [codeImg setImage:[UIImage imageNamed:@"-bar_code01.png"]];
    [partTwo addSubview:codeImg];
    
    [petName release];
    [petBirth release];
    [petVar release];
    [petSex release];
    [petNameTxt release];
    [family release];
    [codeImg release];
    
//part 3 ---------------------------------------------
    
//814.0
    UILabel *flight = [[UILabel alloc] initWithFrame:CGRectMake( 30.0/640.0*VIEW_FRAME_WIDTH, 12.0/1136.0*VIEW_FRAME_HEIGHT,38.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    flight.text = @"航班";
    flight.font = [UIFont fontWithName:@"Arial" size:9.0];
    flight.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:flight];
    [flight release];
    
    UILabel *flightNum = [[UILabel alloc] initWithFrame:CGRectMake( 114.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT,80.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    flightNum.text = @"XHD66";
    flightNum.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    flightNum.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:flightNum];
    [flightNum release];
    
    UILabel *destination = [[UILabel alloc] initWithFrame:CGRectMake( 30.0/640.0*VIEW_FRAME_WIDTH, 62.0/1136.0*VIEW_FRAME_HEIGHT,56.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    destination.text = @"目的地";
    destination.font = [UIFont fontWithName:@"Arial" size:9.0];
    destination.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:destination];
    [destination release];
    
    UILabel *destinationTxt = [[UILabel alloc] initWithFrame:CGRectMake( 114.0/640.0*VIEW_FRAME_WIDTH, 60.0/1136.0*VIEW_FRAME_HEIGHT,70.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    destinationTxt.text = @"银河系";
    destinationTxt.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    destinationTxt.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:destinationTxt];
    [destinationTxt release];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake( 30.0/640.0*VIEW_FRAME_WIDTH, 112.0/1136.0*VIEW_FRAME_HEIGHT,56.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    date.text = @"日期";
    date.font = [UIFont fontWithName:@"Arial" size:9.0];
    date.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:date];
    [date release];
    
    //获取当前日期
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    UILabel *dateTxt = [[UILabel alloc] initWithFrame:CGRectMake( 114.0/640.0*VIEW_FRAME_WIDTH, 110.0/1136.0*VIEW_FRAME_HEIGHT,150.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    dateTxt.text = locationString;
    dateTxt.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    dateTxt.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:dateTxt];
    [dateTxt release];
    
    [dateformatter release];
    
    UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake( 302.0/640.0*VIEW_FRAME_WIDTH, 12.0/1136.0*VIEW_FRAME_HEIGHT,80.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    level.text = @"舱位等级";
    level.font = [UIFont fontWithName:@"Arial" size:9.0];
    level.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:level];
    [level release];
    
    UILabel *gate = [[UILabel alloc] initWithFrame:CGRectMake( 302.0/640.0*VIEW_FRAME_WIDTH, 62.0/1136.0*VIEW_FRAME_HEIGHT,56.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    gate.text = @"登机口";
    gate.font = [UIFont fontWithName:@"Arial" size:9.0];
    gate.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:gate];
    [gate release];
    
    UILabel *logTime = [[UILabel alloc] initWithFrame:CGRectMake( 302.0/640.0*VIEW_FRAME_WIDTH, 112.0/1136.0*VIEW_FRAME_HEIGHT,80.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    logTime.text = @"登机时间";
    logTime.font = [UIFont fontWithName:@"Arial" size:9.0];
    logTime.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [partThr addSubview:logTime];
    [logTime release];
    
    UILabel *cabin = [[UILabel alloc] initWithFrame:CGRectMake( 408.0/640.0*VIEW_FRAME_WIDTH, 10.0/1136.0*VIEW_FRAME_HEIGHT,80.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    cabin.text = @"头等舱";
    cabin.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    cabin.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:cabin];
    [cabin release];
    
    UILabel *gateTxt = [[UILabel alloc] initWithFrame:CGRectMake( 408.0/640.0*VIEW_FRAME_WIDTH, 60.0/1136.0*VIEW_FRAME_HEIGHT,100.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    gateTxt.text = @"专属通道";
    gateTxt.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    gateTxt.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:gateTxt];
    [gateTxt release];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake( 408.0/640.0*VIEW_FRAME_WIDTH, 110.0/1136.0*VIEW_FRAME_HEIGHT,100.0/640.0*VIEW_FRAME_WIDTH, 20.0/1136.0*VIEW_FRAME_HEIGHT)];
    time.text = @"马上起飞";
    time.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:11.0];
    time.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [partThr addSubview:time];
    [time release];
    
    UIImageView *barCodeImg = [[UIImageView alloc] initWithFrame:CGRectMake( 34.0/640.0*VIEW_FRAME_WIDTH, 144.0/1136.0*VIEW_FRAME_HEIGHT, 454.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barCodeImg setImage:[UIImage imageNamed:@"-bar_code.png"]];
    [partThr addSubview:barCodeImg];
    
    [partOne release];
    [partTwo release];
    [partThr release];
    
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goBtn.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH, 1034.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT);
    [goBtn setBackgroundColor:[UIColor colorWithRed:2.0/255.0 green:210.0/255.0 blue:121.0/255.0 alpha:1.0]];
    [goBtn setTitle:@"入驻星球" forState:UIControlStateNormal];
    [goBtn setTintColor:[UIColor whiteColor]];
    [goBtn addTarget:self action:@selector(signOver:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signOver:(UIButton *)btn
{
    PostCustomerData *pcd = [[PostCustomerData alloc] init];
    [pcd postCustomerData:self.nameTxt.text email:@"123123" region:self.distrString sex:self.sexIndex];
    [pcd release];
    
    PostPetData *ppd =[[PostPetData alloc] init];
    [ppd postPetData:self.petNameTxt.text Race:self.race Breed:self.breed Sex:self.petSexIndex Portrait:self.petPortrait Birth:self.birthday];
    [ppd release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)masterSexChoose:(UIButton *)btn
{
//    [self.view addSubview:backImg];
    
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];

    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(120.0/640.0*VIEW_FRAME_WIDTH, 288.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 630.0/1136.0*VIEW_FRAME_HEIGHT)];
    [whiteImg setBackgroundColor:[UIColor whiteColor]];
    [whiteImg setUserInteractionEnabled:YES];
    [backImg addSubview:whiteImg];
    
    UIButton *manBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    manBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [manBtn setBackgroundImage:[UIImage imageNamed:@"choose_boy.png"] forState:UIControlStateNormal];
    [manBtn addTarget:self action:@selector(chooseBoy:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:manBtn];
    
    UIButton *womanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    womanBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 338.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [womanBtn setBackgroundImage:[UIImage imageNamed:@"choose_girl.png"] forState:UIControlStateNormal];
    [womanBtn addTarget:self action:@selector(chooseGirl:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:womanBtn];
    
    [backImg release];
    [whiteImg release];
}

-(void)chooseBoy:(UIButton *)btn
{
    self.sexIndex = 1;
    UIView *backImg = [self.view viewWithTag:56];
    [self.sexChooseBtn setImage:[UIImage imageNamed:@"man.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
    
}

-(void)chooseGirl:(UIButton *)btn
{
    self.sexIndex = 0;
    UIView *backImg = [self.view viewWithTag:56];
    [self.sexChooseBtn setImage:[UIImage imageNamed:@"girl.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
    
}

-(void)choosePetSex:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];
    
    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(120.0/640.0*VIEW_FRAME_WIDTH, 288.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 630.0/1136.0*VIEW_FRAME_HEIGHT)];
    [whiteImg setBackgroundColor:[UIColor whiteColor]];
    [whiteImg setUserInteractionEnabled:YES];
    [backImg addSubview:whiteImg];
    
    UIButton *maleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    maleBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [maleBtn setBackgroundImage:[UIImage imageNamed:@"choose_tie.png"] forState:UIControlStateNormal];
    [maleBtn addTarget:self action:@selector(chooseMale:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:maleBtn];
    
    UIButton *femaleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    femaleBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 338.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [femaleBtn setBackgroundImage:[UIImage imageNamed:@"choose_flower.png"] forState:UIControlStateNormal];
    [femaleBtn addTarget:self action:@selector(chooseFemale:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:femaleBtn];
    
    [backImg release];
    [whiteImg release];
}

-(void)chooseFemale:(UIButton *)btn
{
    self.petSexIndex = 0;
    UIView *backImg = [self.view viewWithTag:56];
    [self.petSexChooseBtn setImage:[UIImage imageNamed:@"female.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
}

-(void)chooseMale:(UIButton *)btn
{
    self.petSexIndex = 1;
    UIView *backImg = [self.view viewWithTag:56];
    [self.petSexChooseBtn setImage:[UIImage imageNamed:@"male.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
}

-(void)choosePetVar:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];
    
    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(120.0/640.0*VIEW_FRAME_WIDTH, 288.0/1136.0*VIEW_FRAME_HEIGHT, 400.0/640.0*VIEW_FRAME_WIDTH, 630.0/1136.0*VIEW_FRAME_HEIGHT)];
    [whiteImg setBackgroundColor:[UIColor whiteColor]];
    [whiteImg setUserInteractionEnabled:YES];
    [backImg addSubview:whiteImg];
    
    UIButton *dogBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dogBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [dogBtn setBackgroundImage:[UIImage imageNamed:@"choose_dog.png"] forState:UIControlStateNormal];
    [dogBtn addTarget:self action:@selector(chooseDog:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:dogBtn];
    
    UIButton *catBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    catBtn.frame = CGRectMake(90.0/640.0*VIEW_FRAME_WIDTH, 338.0/1136.0*VIEW_FRAME_HEIGHT, 220.0/640.0*VIEW_FRAME_WIDTH, 220.0/1136.0*VIEW_FRAME_HEIGHT);
    [catBtn setBackgroundImage:[UIImage imageNamed:@"choose_cat.png"] forState:UIControlStateNormal];
    [catBtn addTarget:self action:@selector(chooseCat:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:catBtn];
    
    [backImg release];
    [whiteImg release];
}

-(void)chooseDog:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    self.selectedRace =@"狗";
    [self.varChooseBtn setImage:[UIImage imageNamed:@"dog_p.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
}

-(void)chooseCat:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    self.selectedRace =@"猫";
    [self.varChooseBtn setImage:[UIImage imageNamed:@"cat.png"] forState:UIControlStateNormal];
    [backImg removeFromSuperview];
}

-(void)chooseBirth:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];
    
    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 736.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 736.0/1136.0*VIEW_FRAME_HEIGHT)];
    [whiteImg setBackgroundColor:[UIColor whiteColor]];
    [whiteImg setUserInteractionEnabled:YES];
    [backImg addSubview:whiteImg];
    
    self.pick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 80.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 320.0/1136.0*VIEW_FRAME_HEIGHT)];
    pick.datePickerMode = UIDatePickerModeDate;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    dateFormatter.timeZone = sourceTimeZone;
    NSDate *minDate= [dateFormatter dateFromString:@"1980-01-01"];
    NSDate *maxDate= [dateFormatter dateFromString:@"2020-01-01"];
    
    pick.minimumDate = minDate;
    pick.maximumDate = maxDate;
    
    [pick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    [whiteImg addSubview:pick];
    
    UIImageView *wImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
    [wImg setBackgroundColor:[UIColor lightGrayColor]];
    [wImg setUserInteractionEnabled:YES];
    [whiteImg addSubview:wImg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(30.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelChoose:) forControlEvents:UIControlEventTouchUpInside];
    [wImg addSubview:cancelBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    endBtn.frame = CGRectMake(540.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [endBtn setTitle:@"完成" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endChoose:) forControlEvents:UIControlEventTouchUpInside];
    [wImg addSubview:endBtn];

    
    [dateFormatter release];
    [backImg release];
    [whiteImg release];
    [wImg release];
    [pick release];
}

-(void)endChoose:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
    [petBirthChooseBtn setTitle:birthday forState:UIControlStateNormal];
    
}

-(void)cancelChoose:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    self.birthday = nil;
    [backImg removeFromSuperview];
}

-(void)dateChanged:(id)sender{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.birthday = [dateFormatter stringFromDate:pick.date];
}

-(void)districtChoose:(UIButton *)btn
{
    UIView *backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [backImg setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
    backImg.opaque = NO;
    backImg.tag = 56;
    [self.view addSubview:backImg];
    
    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 736.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 736.0/1136.0*VIEW_FRAME_HEIGHT)];
    [whiteImg setBackgroundColor:[UIColor whiteColor]];
    [whiteImg setUserInteractionEnabled:YES];
    [backImg addSubview:whiteImg];

    self.cityPick = [[CityPickerView alloc] initWithFrame:CGRectMake(0.0, 80.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 320.0/1136.0*VIEW_FRAME_HEIGHT)];
    self.cityPick.delegate = self;
//    [cityPick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
//    NSLog(@"%@",[self.cityPick.proviceDictionary objectForKey:@"provice"]);
//    NSLog(@"%@",[self.cityPick.proviceDictionary objectForKey:@"city"]);
//    NSLog(@"%@",[self.cityPick.proviceDictionary objectForKey:@"county"]);
//    
    [whiteImg addSubview:cityPick];
    
    UIImageView *wImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
    [wImg setBackgroundColor:[UIColor lightGrayColor]];
    [wImg setUserInteractionEnabled:YES];
    [whiteImg addSubview:wImg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(30.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelChoose:) forControlEvents:UIControlEventTouchUpInside];
    [wImg addSubview:cancelBtn];

    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    endBtn.frame = CGRectMake(540.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [endBtn setTitle:@"完成" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endChooseDistrict:) forControlEvents:UIControlEventTouchUpInside];
    [wImg addSubview:endBtn];
    
    [backImg release];
    [whiteImg release];
    [wImg release];
    [cityPick release];

}

- (void) updateLabel {
//    NSLog(@"!----------%@",[self.cityPick.proviceDictionary objectForKey:@"provice"]);
//    NSLog(@"!----------%@",[self.cityPick.proviceDictionary objectForKey:@"city"]);
//    NSLog(@"!----------%@",[self.cityPick.proviceDictionary objectForKey:@"county"]);
    self.distrString = [NSString stringWithFormat:@"%@",[self.cityPick.proviceDictionary objectForKey:@"city"]];
   // NSLog(@"city=%@",self.distrString);
}

-(void)endChooseDistrict:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
    [disChooseBtn setTitle:distrString forState:UIControlStateNormal];

}
-(void)selectPet:(NSString * )pet
{
    //petFamilyName.text = pet;
    //self.selectedBreed = pet;
    NSLog(@"pet:%@",pet);
}

-(void)familyChoose:(UIButton *)btn
{
    NSString * aName = @"";
    if ([self.selectedRace isEqualToString:@"狗"]) {
        aName = @"dog";
    }
    else
        aName = @"cat";
    pets = [[PetFamily alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) name:aName];
    pets.delegate = self;
    pets.method = @selector(selectPet:);
    [self.view addSubview:pets];

//    FamiliesViewController *family = [[FamiliesViewController alloc] init];
//    [self presentViewController:family animated:NO completion:nil];
//    [family release];
}

-(void)setPhoto:(UIButton *)btn
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
    pickerImage.allowsEditing = NO;
    [self presentModalViewController:pickerImage animated:YES];
    [pickerImage release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //拍照完，或者选取照片后调用
}

-(void)cancel:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

-(void)dealloc
{
    [pets release];
    
    [distrString release];
    [cityPick release];
    [sexChooseBtn release];
    [petSexChooseBtn release];
    [varChooseBtn release];
    [petBirthChooseBtn release];
    [pick release];
    [birthday release];
    [disChooseBtn release];
    [peoBtn release];
    [petBtn release];
    [usrName release];
    [petName release];
    [breed release];
    [race release];
    [nameTxt release];
    [petNameTxt release];
    [petPortrait release];
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
