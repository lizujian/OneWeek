//
//  MainViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-5-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "FotoWallViewController.h"
#import "LoginViewController.h"
#import "GetEssencePost.h"
#import "GetMederatorPost.h"
#import "PersonalPostViewController.h"
#import "FansViewController.h"
#import "AttentionViewController.h"
#import "CollectedSectionViewController.h"
#import "SettingViewController.h"
#import "PetViewController.h"
#import "PostUserPortrait.h"
#import "PersonalInfoViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize footView,imgview,main,per,mainpageBtn,lbsBtn,userBtn,map;

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
    
    self.main = [[MainPageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [self.view addSubview:main];
    [main release];
    
    NSLog(@"----mainpage");
    
    self.footView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red.png"]];
    self.footView.frame = CGRectMake(0, 524.0/568.0*VIEW_FRAME_HEIGHT,VIEW_FRAME_WIDTH, 52.0/568.0*VIEW_FRAME_HEIGHT);
    [self.footView setUserInteractionEnabled:YES];
    [self.view addSubview:self.footView];
    
    self.mainpageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    mainpageBtn.frame = CGRectMake(90.0/320.0*VIEW_FRAME_WIDTH, 10/568.0*VIEW_FRAME_HEIGHT, 46.0/640.0*VIEW_FRAME_WIDTH, 44.0/1136.0*VIEW_FRAME_HEIGHT);
    [mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_press.png"] forState:UIControlStateNormal];
    [mainpageBtn addTarget:self action:@selector(showMainPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:mainpageBtn];
    
    self.lbsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    lbsBtn.frame = CGRectMake(145.0/320.0*VIEW_FRAME_WIDTH, 10.0/568.0*VIEW_FRAME_HEIGHT, 40.0/640.0*VIEW_FRAME_WIDTH, 47.0/1136.0*VIEW_FRAME_HEIGHT);
    [lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
    [lbsBtn addTarget:self action:@selector(showLBS:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:lbsBtn];
    //http://blog.csdn.net/orietech/article/details/6645717   自定义大头针view
    
    self.userBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    userBtn.frame = CGRectMake(200.0/320.0*VIEW_FRAME_WIDTH, 10.0/568.0*VIEW_FRAME_HEIGHT, 40.0/640.0*VIEW_FRAME_WIDTH, 45.0/1136.0*VIEW_FRAME_HEIGHT);
    [userBtn setBackgroundImage:[UIImage imageNamed:@"gata_normal.png"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(showPersonalCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:userBtn];
    
    [footView release];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToOtherPage:) name:@"GOTO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(footViewHide:) name:@"FOOTHIDEORNOT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSection:) name:@"SECTIONCHOOSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPost:) name:@"GOTPOST"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPet:) name:@"ADDPET"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editPet:) name:@"EDITPET"  object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToLibrary:) name:@"GOTOLIBRARY"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCamera:) name:@"GOTOCAMERA"  object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToPersonalInfo:) name:@"GOTOPERSONALINFO"  object:nil];

    NSLog(@"path:%@",NSHomeDirectory());
//测试上传图片
//    PostUserPortrait *kk = [[PostUserPortrait alloc] init];
//    PostPetPortrait *ppp = [[PostPetPortrait alloc] init];
//    [kk postUserPortrait: [NSString stringWithFormat:@"%@/qqlogo.png",NSHomeDirectory()]];
//    [ppp postPetPortrait:[NSString stringWithFormat:@"%@/qqlogo.png",NSHomeDirectory()] PetId:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goToOtherPage : (NSNotification *)noti
{
    NSLog(@"-----%@",[noti object]);
    
//    GetMederatorPost *gmp = [[GetMederatorPost alloc] init];
    
    PostViewController *pvc = [[PostViewController alloc] init];
    
    if ([[noti object] isEqualToString:@"0"]) {
        
        pvc.titleName = @"爆照星";
        pvc.moderatorsId = 1;
        
    }else if([[noti object] isEqualToString:@"1"]){
        
        pvc.titleName = @"喵喵星";
        pvc.moderatorsId = 2;
        
    }else if([[noti object] isEqualToString:@"2"]){
        
        pvc.titleName = @"吐槽星";
        pvc.moderatorsId = 3;
        
    }else if([[noti object] isEqualToString:@"3"]){
        
        pvc.titleName = @"汪汪星";
        pvc.moderatorsId = 4;
        
    }else{
        
        pvc.titleName = @"代养星";
        pvc.moderatorsId = 5;
        
    }
    
//    [gmp getMederatorPost];
    
    [self presentViewController:pvc animated:YES completion:nil];
    [pvc release];
    
}
//下拉过程种，tabbar暂时隐藏
-(void)footViewHide:(NSNotification *)noti
{
    if ([[noti object]isEqualToString:@"YES"]) {
        [self.footView setHidden:YES];
    }else
        [self.footView setHidden:NO];
    
}

-(void)showMainPage:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"homepage_press.png"] forState:UIControlStateNormal];
    [lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"gata_normal.png"] forState:UIControlStateNormal];
    self.main = [[MainPageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    
    [map removeFromSuperview];
    [self.per removeFromSuperview];
    [self.footView removeFromSuperview];
    [self.view addSubview:main];
    [self.view addSubview:self.footView];
    
    [main release];
}

-(void)showLBS:(UIButton *)btn
{
    [mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
    [lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_press.png"] forState:UIControlStateNormal];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"gata_normal.png"] forState:UIControlStateNormal];
    self.map = [[MapView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    
    [self.per removeFromSuperview];
    [self.main removeFromSuperview];
    [self.footView removeFromSuperview];
    [self.view addSubview:map];
    [self.view addSubview:self.footView];
    [map release];
}

-(void)showPersonalCenter:(UIButton *)btn
{
    [userBtn setBackgroundImage:[UIImage imageNamed:@"gata_press.png"] forState:UIControlStateNormal];
    [lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
    [mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
    self.per = [[PersonalCenterView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [self.main removeFromSuperview];
    [self.footView removeFromSuperview];
    [self.view addSubview:per];
    [self.view addSubview:self.footView];
    [per release];
    
    
}

-(void)goToSection:(NSNotification *)noti
{
    if ([[noti object]isEqualToString:@"0"]) {
        PersonalPostViewController *ppvc = [[PersonalPostViewController alloc] init];
        ppvc.isFromeMainPage = YES;
        [self presentViewController:ppvc animated:NO completion:nil];
        [ppvc release];
    }
    if ([[noti object]isEqualToString:@"1"]) {
        FansViewController *fans = [[FansViewController alloc] init];
        fans.isFromeMainPage = YES;
        [self presentViewController:fans animated:NO completion:nil];
        [fans release];
    }
    if ([[noti object]isEqualToString:@"2"]) {
        AttentionViewController *att = [[AttentionViewController alloc] init];
        att.isFromeMainPage = YES;
        [self presentViewController:att animated:NO completion:nil];
        [att release];
    }
    if ([[noti object]isEqualToString:@"3"]) {
        FotoWallViewController *foto = [[FotoWallViewController alloc] init];
        foto.isFromeMainPage = YES;
        [self presentViewController:foto animated:NO completion:nil];
        [foto release];
    }
    if ([[noti object]isEqualToString:@"4"]) {
        CollectedSectionViewController *coll = [[CollectedSectionViewController alloc] init];
        coll.isFromeMainPage = YES;
        [self presentViewController:coll animated:NO completion:nil];
        [coll release];
    }
    if ([[noti object]isEqualToString:@"5"]) {
        SettingViewController *set = [[SettingViewController alloc] init];
//        coll.isFromeMainPage = YES;
        [self presentViewController:set animated:NO completion:nil];
        [set release];
    }
}
#pragma mark -- photo choose
//旋转图片
-(UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}


//选择图片后，替换原来的图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //选择的图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * RotateImage = [[[UIImage alloc] init] autorelease];
    [self.main removeFromSuperview];
    [self.footView removeFromSuperview];
    self.per = [[PersonalCenterView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT)];
    [self.view addSubview:per];
    [self.view addSubview:self.footView];
    RotateImage = [self rotateImage:image];
    if(image !=nil){
        self.per.backGroundImg = RotateImage;
        self.per.bgChanged = YES;
    }
    //关闭系统相册
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//点击取消按钮执行的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭系统相册
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)goToLibrary:(NSNotification *)noti
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing =YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];

}
-(void)goToCamera:(NSNotification *)nofi
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing =YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
}
-(void)goToPersonalInfo:(NSNotification *)noti
{
    PersonalInfoViewController * personalInfo = [[PersonalInfoViewController alloc] init];
    personalInfo.userId = [[noti object] intValue];
    personalInfo.isFromMain = YES;
    [self presentModalViewController:personalInfo animated:YES];
    [personalInfo release];
}
-(void)addPet:(NSNotification *)noti
{
    PetViewController *addPet = [[PetViewController alloc] init];
    [self presentViewController:addPet animated:YES completion:nil];
    [addPet release];
}

-(void)editPet:(NSNotification *)noti
{
    
    PetViewController *editPet = [[PetViewController alloc] init];
    editPet.portrait = [[noti object] objectForKey:@"portrait"];
    editPet.petName = [[noti object] objectForKey:@"name"];
    editPet.sexIndex = [[[noti object] objectForKey:@"sex"] intValue];
    editPet.selectedRace = [[noti object] objectForKey:@"race"];
    editPet.selectedBreed = [[noti object] objectForKey:@"breed"];
    editPet.birthday = [[noti object] objectForKey:@"birthday"];
    NSLog(@"headImage=%@",editPet.portrait);
    NSLog(@"namee=%@",editPet.petName);
    NSLog(@"sex=%d",editPet.sexIndex);
    NSLog(@"selectedRace=%@",editPet.selectedRace);
    NSLog(@"selectedBreed=%@",editPet.selectedBreed);
    NSLog(@"birdthday=%@",editPet.birthday);



    editPet.isEdit = YES;
    [self presentViewController:editPet animated:YES completion:nil];
    [editPet release];
}

-(void)getPost:(NSNotification *)noti
{
    self.main.postDic = [NSMutableDictionary dictionaryWithDictionary:[noti object]];
}

-(void)dealloc
{
    [map release];
    [footView release];
    [per release];
    [main release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FOOTHIDEORNOT" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTPOST" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SECTIONCHOOSE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ADDPET" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DELETEPET" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOLIBRARY"  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOCAMERA"  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOPERSONALINFO" object:nil];

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
