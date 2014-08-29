//
//  SettingViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "SettingViewController.h"
#import "MainViewController.h"
#import "LogOut.h"
#import "GetUserInfo.h"
#import "ThirdPlatformViewController.h"
#import "FeedbackViewController.h"
#import "PostCustomerData.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize sexIndex,cityPick,loc,peoName,imageUrl;

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
    
    GetUserInfo *gui = [[GetUserInfo alloc] init];
    gui.userDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [gui getUserInfo:0];
    
    NSLog(@"===========userInfoDic==========:%@",gui.userDataDic);
    
    self.imageUrl = [gui.userDataDic objectForKey:@"portrait"];
    self.peoName = [gui.userDataDic objectForKey:@"name"];
    self.sexIndex = [[gui.userDataDic objectForKey:@"sex"] intValue];
    self.loc = [gui.userDataDic objectForKey:@"region"];
    
    [gui release];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 61.0/1136.0*VIEW_FRAME_HEIGHT);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(261.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 106.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"设置";
    titleText.textColor = [UIColor whiteColor];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    [barView release];
    [titleText release];
    dataArray = [[NSMutableArray alloc] initWithObjects:@"头像",@"昵称",@"性别",@"地区",@"第三方账号",@"反馈意见",@"版本升级",@"关于宠物星球",nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 780.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.scrollEnabled = NO;
    //    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    [self setExtraCellLineHidden:myTableView];//隐藏多余的分割线

    //保存修改信息
    UIButton *saveInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    saveInfo.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH,920.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT);
    [saveInfo setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [saveInfo setTitle:@"保 存 信 息" forState:UIControlStateNormal];
    saveInfo.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveInfo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveInfo addTarget:self action:@selector(clickSaveInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveInfo];
    
    //退出登录
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    logOutBtn.frame = CGRectMake(60.0/640.0*VIEW_FRAME_WIDTH,1020.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT);
    [logOutBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [logOutBtn setTitle:@"退 出 登 录" forState:UIControlStateNormal];
    logOutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // [logOutBtn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];}
//隐藏多余的分割线
-(void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView  *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    [view release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logOut:(UIButton *)btn
{
//    LogOut *lout = [[LogOut alloc] init];
//    [lout logOut];
//    [lout release];
    
    self.imageUrl = nil;
    self.peoName = nil;
    self.sexIndex = 0;
    self.loc = nil;
    [myTableView reloadData];
}

-(void)selectSex:(UIButton *)btn
{
    if (btn.tag == 58) {
        [btn setBackgroundImage:[UIImage imageNamed:@"man_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:57];
        [button setBackgroundImage:[UIImage imageNamed:@"girl_n01.png"] forState:UIControlStateNormal];
        self.sexIndex = 1;
        
    }
    if (btn.tag == 57) {
        [btn setBackgroundImage:[UIImage imageNamed:@"girl_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:58];
        [button setBackgroundImage:[UIImage imageNamed:@"man_n01.png"] forState:UIControlStateNormal];
        self.sexIndex = 0;
    }
}

-(void)backToMain:(UIButton *)btn
{
    MainViewController *main = [[MainViewController alloc] init];
    [main showPersonalCenter:btn];
    [main.userBtn setBackgroundImage:[UIImage imageNamed:@"gata_press.png"] forState:UIControlStateNormal];
    [main.lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
    [main.mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
    [self presentViewController:main animated:NO completion:nil];
    [main release];
}
-(void)clickSaveInfo:(UIButton *)btn
{
//    NSLog(@"name:%@",self.peoName);
//    NSLog(@"sex:%d",self.sexIndex);
//    NSLog(@"loc:%@",self.loc);
    PostCustomerData * postData = [[PostCustomerData alloc] init];
    if (iconISchanged ==YES) {//更换过头像
        [postData postUserPortrait:userIconPath];
    }
    //传输文字信息
    [postData postCustomerData:self.peoName email:nil region:self.loc sex:self.sexIndex];
    
}

#pragma mark --textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.peoName = textField.text;
}
-(void)resignAllFirstresponder:(UIView *)view
{
    for(UIView * subView in view.subviews){
        if([subView isKindOfClass:[UITextField class]]){
            [subView resignFirstResponder];
        }
        else{
            [self resignAllFirstresponder:subView];
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignAllFirstresponder:self.view];
}
#pragma mark--choose photo

-(void)chooseImage
{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择相册图片",@"选择相机图片", nil];
    [sheet showInView:self.view];
    [sheet release];
    
}
//选择相册中的图片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self localPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
        default:
            break;
    }
}
//相册
-(void)localPhoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}
//相机
-(void)takePhoto
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
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil  message:@"该设备无摄像头" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
}
//把图片转换成二进制
-(NSData *)convertToData:(UIImage *)image
{
    NSData * data = UIImagePNGRepresentation(image);
    if(data ==nil){
        data = UIImageJPEGRepresentation(image, 1.0f);
    }
    return data;
}
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
    RotateImage = [self rotateImage:image];
    //UIImage *UIRotateImage = [self rotateImage:image];
    if(image !=nil){
        headImage.image = RotateImage;//替换
        iconISchanged = YES;
        NSData * imageData = UIImagePNGRepresentation(RotateImage);
        
        NSString * temPath =[NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
        //NSLog(@"temPath%@",temPath);
        userIconPath = [[NSString  alloc ]initWithFormat:@"%@/%@",temPath,@"userIcon.png"];
       // NSLog(@"temPath%@",userIconPath);
        BOOL result = [imageData writeToFile:userIconPath atomically:YES];
        
        if (result ==YES) {
            NSLog(@"图片已保存");
        }
        else{
            NSLog(@"图片存储失败");
        }
        
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


#pragma mark --myTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = 0.0;
    if (indexPath.row == 0) {
        cellHeight = 150.0/1136.0*VIEW_FRAME_HEIGHT;
    }else{
            cellHeight = 90.0/1136.0*VIEW_FRAME_HEIGHT;
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellID =@"mycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(nil ==cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor =[UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];

    if (indexPath.row ==0) {
       headImage = [[UIImageView alloc] initWithFrame:CGRectMake( 508.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 106.0/640.0*VIEW_FRAME_WIDTH, 106.0/1136.0*VIEW_FRAME_HEIGHT)];
        [headImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]]]];
        headImage.layer.cornerRadius = 5;
        headImage.layer.masksToBounds = YES;
        [cell.contentView addSubview:headImage];
    }
    if (indexPath.row ==1) {
        UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake( 400.0/640.0*VIEW_FRAME_WIDTH, 12.0/1136.0*VIEW_FRAME_HEIGHT, 216.0/640.0*VIEW_FRAME_WIDTH, 60.0/1136.0*VIEW_FRAME_HEIGHT)];
        name.delegate = self;
        name.borderStyle = UITextBorderStyleNone;
        name.textAlignment = NSTextAlignmentRight;
        name.clearButtonMode = UITextFieldViewModeWhileEditing;
        name.text = self.peoName;
        [name setFont:[UIFont fontWithName:@"Arial" size:16.0]];
        name.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        [cell.contentView addSubview:name];
        [name release];

    }
    if (indexPath.row==2) {
        UIButton *boyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        boyBtn.frame = CGRectMake(488.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT, 42.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT);
        if (sexIndex == 1)
        {
            [boyBtn setBackgroundImage:[UIImage imageNamed:@"man_p01.png"] forState:UIControlStateNormal];
        }
        else
        {
            [boyBtn setBackgroundImage:[UIImage imageNamed:@"man_n01.png"] forState:UIControlStateNormal];
        }
        
        [boyBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
        boyBtn.tag = 58;
        [cell.contentView addSubview:boyBtn];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(550.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT, 2.0/640.0*VIEW_FRAME_WIDTH, 38.0/1136.0*VIEW_FRAME_HEIGHT)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:line];
        
        UIButton *girlBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        girlBtn.frame = CGRectMake(570.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT, 42.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT);
        if (sexIndex == 0)
        {
            [girlBtn setBackgroundImage:[UIImage imageNamed:@"girl_p01.png"] forState:UIControlStateNormal];
        }
        else
        {
            [girlBtn setBackgroundImage:[UIImage imageNamed:@"girl_n01.png"] forState:UIControlStateNormal];
        }
        
        [girlBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
        girlBtn.tag = 57;
        [cell.contentView addSubview:girlBtn];

    }
    if (indexPath.row ==3) {
        
        location = [[UITextField alloc] initWithFrame:CGRectMake( 326.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 320.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
        location.text = self.loc;
        location.textAlignment = UITextAlignmentCenter;
        
        location.enabled = NO;
        //NSLog(@"loc=%@",self.loc);
        [location setFont:[UIFont fontWithName:@"Arial" size:14.0]];
        location.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        [cell.contentView addSubview:location];
            
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 16.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
        [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
        [cell.contentView addSubview:arrowImg];
        [arrowImg release];

        }
    if(indexPath.row == 4){
            UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 16.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
            [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
            [cell.contentView addSubview:arrowImg];
            [arrowImg release];
            }
    if(indexPath.row == 5){
            
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 16.0/640.0*VIEW_FRAME_WIDTH, 28.0/1136.0*VIEW_FRAME_HEIGHT)];
            [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
            [cell.contentView addSubview:arrowImg];
            [arrowImg release];
            
        }
    if(indexPath.row == 6){
            UITextField *version = [[UITextField alloc] initWithFrame:CGRectMake( 526.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 86.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
            version.text = @"1.0版";
            [version setFont:[UIFont fontWithName:@"Arial" size:14.0]];
            version.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            [version setEnabled:NO];
            [cell.contentView addSubview:version];
            
            [version release];
        }
        if(indexPath.row == 7){
            
        }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self chooseImage];
    }
    if (indexPath.row == 3) {
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
        [whiteImg addSubview:cityPick];
        
        UIImageView *wImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
        [wImg setBackgroundColor:[UIColor lightGrayColor]];
        [wImg setUserInteractionEnabled:YES];
        [whiteImg addSubview:wImg];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelBtn.frame = CGRectMake(30.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
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
    if (indexPath.row == 4) {
        ThirdPlatformViewController *third = [[ThirdPlatformViewController alloc] init];
        [self presentViewController:third animated:YES completion:nil];
        [third release];
    }
    if (indexPath.row == 5) {
        FeedbackViewController *feedback = [[FeedbackViewController alloc] init];
        [self presentViewController:feedback animated:YES completion:nil];
        [feedback release];
    }
}
- (void) updateLabel {
      self.loc = [NSString stringWithFormat:@"%@",[self.cityPick.proviceDictionary objectForKey:@"city"]];
    NSLog(@"city=%@\n",self.loc);
}

-(void)endChooseDistrict:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
    location.text = self.loc;
    
    //[myTableView reloadData];
}

-(void)cancel:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

-(void)dealloc
{
    [loc release];
    [location release];

    [headImage release];
    [dataArray release];
    [myTableView release];
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
