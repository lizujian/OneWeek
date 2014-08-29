//
//  PersonalCenterView.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/6/28.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PersonalCenterView.h"
#import "GetUserInfo.h"
#import "PetViewController.h"
#import "DeletePet.h"
#import "UIImageView+WebCache.h"
#import "PostBackgroundImg.h"
@implementation PersonalCenterView
@synthesize sv,userInfoDic,petsArr;
@synthesize backGroundImg;
@synthesize bgChanged;
-(void)drawRect:(CGRect)rect
{
    CGRect frame = rect;
    
    GetUserInfo *gui = [[GetUserInfo alloc] init];
    gui.userDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [gui getUserInfo:0];
    
    self.userInfoDic = [NSMutableDictionary dictionaryWithDictionary:gui.userDataDic];
   // NSLog(@"===========userInfoDic==========:%@",self.userInfoDic);
    self.petsArr = [NSMutableArray arrayWithArray:[self.userInfoDic objectForKey:@"pets"]];
    [gui release];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 128.0/1136.0*frame.size.height)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*frame.size.width, 65.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 39.0/1136.0*frame.size.height)];
    titleText.text = @"个人中心";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    [barView release];
    [titleText release];
    
    //个人信息的背景图片
   background = [[UIImageView alloc] initWithFrame:CGRectMake( 0.0/640.0*frame.size.width, 128.0/1136.0*frame.size.height, 640.0/640.0*frame.size.width, 540.0/1136.0*frame.size.height)];
    //如果调用了主页的方法替换了图片的话就替换背景图片
    if (bgChanged ==YES) {
        [background setImage:self.backGroundImg];
        NSData * imageData = UIImagePNGRepresentation(self.backGroundImg);
        
        NSString * temPath =[NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
        //NSLog(@"temPath%@",temPath);
        NSString * userIconPath = [[NSString  alloc ]initWithFormat:@"%@/%@",temPath,@"backgroundImg.png"];
         NSLog(@"temPath%@",userIconPath);
        BOOL result = [imageData writeToFile:userIconPath atomically:YES];
        if (result ==YES) {
            NSLog(@"图片已保存");
        }
        else{
            NSLog(@"图片存储失败");
        }
        PostBackgroundImg * postImg = [[PostBackgroundImg alloc] init];
        NSLog(@"%@",userIconPath);
        [postImg postBackgroundImage:userIconPath];
        [userIconPath release];
      //  bgChanged = NO;
        
    }else{
        [background setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userInfoDic objectForKey:@"backdrop"]]]]];
    }
    //设置背景图片可点击替换
    [background setUserInteractionEnabled:YES];
    [self addSubview:background];
    
    //个人中心头像
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 224.0/640.0*frame.size.width, 165.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 180.0/1136.0*frame.size.height)];
    headImg.layer.cornerRadius = headImg.bounds.size.width/2;
    [headImg.layer setBorderWidth:2];
    [headImg.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    headImg.layer.masksToBounds = YES;
//    [headImg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userInfoDic objectForKey:@"portrait"]]]]];
    [headImg setImageWithURL:[NSURL URLWithString:[self.userInfoDic objectForKey:@"portrait"]] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    [background addSubview:headImg];
    
    //用户名字
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(headImg.frame.origin.x,headImg.frame.origin.y+headImg.frame.size.height-5,headImg.frame.size.width,30)];
    nameText.text = [self.userInfoDic objectForKey:@"name"];
    nameText.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    nameText.textAlignment = UITextAlignmentCenter;
    
    [nameText setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    [nameText setEnabled:NO];
    [background addSubview:nameText];
    
    //个人信息栏
    UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake( 225.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 35.0/1136.0*frame.size.height)];
    [sexImg setImage:[UIImage imageNamed:@"girl_02.png"]];
    [background addSubview:sexImg];
    
    UILabel *sexLbl = [[UILabel alloc] initWithFrame:CGRectMake( 255.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 74.0/640.0*frame.size.width, 35.0/1136.0*frame.size.height)];
    if ([[self.userInfoDic objectForKey:@"sex"] isEqualToString:@"0"]) {
        sexLbl.text = @"妹子";
        [sexImg setImage:[UIImage imageNamed:@"girl_02.png"]];

    }else{
        sexLbl.text = @"帅哥";
        [sexImg setImage:[UIImage imageNamed:@"boy.png"]];

    }
    
    sexLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    sexLbl.textColor = [UIColor whiteColor];
    [background addSubview:sexLbl];
    
    UIImageView *locImg = [[UIImageView alloc] initWithFrame:CGRectMake( 334.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 28.0/640.0*frame.size.width, 35.0/1136.0*frame.size.height)];
    [locImg setImage:[UIImage imageNamed:@"pin.png"]];
    [background addSubview:locImg];
    
    UILabel *locLbl = [[UILabel alloc] initWithFrame:CGRectMake( 358.0/640.0*frame.size.width, 407.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, 94.0/640.0*frame.size.width, 30.0/1136.0*frame.size.height)];
    locLbl.text = [self.userInfoDic objectForKey:@"region"];
    locLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
    locLbl.textColor = [UIColor whiteColor];
    [background addSubview:locLbl];
    locLbl.textAlignment = UITextAlignmentCenter;
    
    [headImg release];
    [nameText release];
    [sexImg release];
    [sexLbl release];
    [locImg release];
    [locLbl release];
    
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake( 0.0/640.0*frame.size.width, 452.0/1136.0*frame.size.height-128.0/1136.0*frame.size.height, frame.size.width, 188.0/1136.0*frame.size.height)];
    sv.delegate = self;
    sv.showsHorizontalScrollIndicator = NO;
    sv.contentSize = CGSizeMake(364.0/640.0*frame.size.width*[[self.userInfoDic objectForKey:@"pets"] count]+114.0/640.0*self.frame.size.width, 170.0/1136.0*frame.size.height);
    sv.tag = 10;
    sv.pagingEnabled = NO;
    sv.bounces = NO;
    [sv setUserInteractionEnabled:YES];
    //        sv.contentOffset = CGPointMake(344.0/640.0*frame.size.width, 0);
    //        [sv setBackgroundColor:[UIColor whiteColor]];
    [background addSubview:sv];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGestures:)];
    /* numberOfTouchesRequired这个属性保存了有多少个手指点击了屏幕,因此你要确保你每次的点击手指数目是一样的,默认值是为 0. */
    longPressGestureRecognizer.numberOfTouchesRequired = 1;
    /* Maximum 100 pixels of movement allowed before the gesture is recognized */
    /*最大100像素的运动是手势识别所允许的*/
    longPressGestureRecognizer.allowableMovement = 0.0f;
    /*这个参数表示,两次点击之间间隔的时间长度。*/
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    [self.sv addGestureRecognizer:longPressGestureRecognizer];
    
    UITapGestureRecognizer* singleTapRecognizer;
    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    [self.sv addGestureRecognizer:singleTapRecognizer];
    
    for (int i = 0; i <= [[self.userInfoDic objectForKey:@"pets"] count]+1; i++) {
        
        if (i < [[self.userInfoDic objectForKey:@"pets"] count]) {
            //宠物栏
    
            UIImageView *petInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake(364.0/640.0*frame.size.width*i, 18.0/1136.0*frame.size.height, 344.0/640.0*frame.size.width, 170.0/1136.0*frame.size.height)];
            [petInfoImg setImage:[UIImage imageNamed:@"stamp_type.png"]];
            [petInfoImg setUserInteractionEnabled:YES];
            petInfoImg.tag = i;
            [self.sv addSubview:petInfoImg];
            
            //删除按钮，长按
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            deleteBtn.frame = CGRectMake(0.0/640.0*self.frame.size.width, 0, 36.0/640.0*self.frame.size.width, 36.0/1136.0*self.frame.size.height);
            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delelte_icon.png"] forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deletePet:) forControlEvents:UIControlEventTouchUpInside];
            [deleteBtn setHidden:YES];
            deleteBtn.tag = 20 + i ;
            [petInfoImg addSubview:deleteBtn];
            
            //编辑按钮
            UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            editBtn.frame = CGRectMake(281.0/640.0*self.frame.size.width, 21.0/1136.0*self.frame.size.height, 32.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height);
            [editBtn setBackgroundImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
            [editBtn addTarget:self action:@selector(editPet:) forControlEvents:UIControlEventTouchUpInside];
            editBtn.tag = 90 + i ;
            [petInfoImg addSubview:editBtn];
            
             //宠物头像
            UIImageView *petImg = [[UIImageView alloc] initWithFrame:CGRectMake( 32.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height,116.0/640.0*frame.size.width, 116.0/1136.0*frame.size.height)];
            NSURL *url = [NSURL URLWithString:[[self.petsArr objectAtIndex:i] objectForKey:@"portrait"]];
            [petImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"wait.png"]];
         //   [petImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"wait.png"]];
            petImg.layer.cornerRadius = petImg.bounds.size.width/2;
            [petImg.layer setBorderWidth:2];
            [petImg.layer setBorderColor:[[UIColor grayColor] CGColor]];
            petImg.layer.masksToBounds = YES;
            [petInfoImg addSubview:petImg];
            
            //宠物名字
            UILabel *pNameLbl = [[UILabel alloc] initWithFrame:CGRectMake( 157.0/640.0*frame.size.width, 37.0/1136.0*frame.size.height, 120.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height)];
            pNameLbl.text = [[self.petsArr objectAtIndex:i] objectForKey:@"name"];
            pNameLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0];
            pNameLbl.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [petInfoImg addSubview:pNameLbl];
            
            //宠物种族
            UILabel *pVarietiesLbl = [[UILabel alloc] initWithFrame:CGRectMake( 160.0/640.0*frame.size.width, 77.0/1136.0*frame.size.height, 108.0/640.0*frame.size.width, 26.0/1136.0*frame.size.height)];
            pVarietiesLbl.text = [[self.petsArr objectAtIndex:i] objectForKey:@"breed"];
            pVarietiesLbl.font = [UIFont fontWithName:@"Arial" size:11.0];
            pVarietiesLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            [petInfoImg addSubview:pVarietiesLbl];
            
            //宠物出生日期
            UILabel *birthLbl = [[UILabel alloc] initWithFrame:CGRectMake( 158.0/640.0*frame.size.width, 111.0/1136.0*frame.size.height, 105.0/640.0*frame.size.width, 20.0/1136.0*frame.size.height)];
            birthLbl.text = [[self.petsArr objectAtIndex:i] objectForKey:@"birthday"];
            birthLbl.font = [UIFont fontWithName:@"Arial" size:10.0];
            birthLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            [petInfoImg addSubview:birthLbl];
            
            //宠物脚印
            UIImageView *postImg = [[UIImageView alloc] initWithFrame:CGRectMake( 252.0/640.0*frame.size.width, 98.0/1136.0*frame.size.height, 84.0/640.0*frame.size.width, 60.0/1136.0*frame.size.height)];
            [postImg setImage:[UIImage imageNamed:@"postmark.png"]];
            [petInfoImg addSubview:postImg];
            
            [petInfoImg release];
            [petImg release];
            [pNameLbl release];
            [pVarietiesLbl release];
            [birthLbl release];
            [postImg release];
            
        }else if (i == [[self.userInfoDic objectForKey:@"pets"] count]+1){
            
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            addBtn.frame = CGRectMake(364.0/640.0*self.frame.size.width*[self.petsArr count], 78.0/1136.0*self.frame.size.height, 54.0/640.0*self.frame.size.width,54.0/1136.0*self.frame.size.height);
            [addBtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addPet:) forControlEvents:UIControlEventTouchUpInside];
            addBtn.tag = 20 + i ;
            [self.sv addSubview:addBtn];
            
        }
        
    }
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 668.0/1136.0*frame.size.height, frame.size.width, frame.size.height-668.0/1136.0*frame.size.height) style:UITableViewStylePlain];//-90.0/1136.0*self.frame.size.height
    table.dataSource = self;
    table.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [self addSubview:table];
    
    [table release];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击任意位置
    UITouch * touch = [touches anyObject];
    //获取点击的视图
    UIView * touchView = [touch view];
    //判断获得的视图是否是图片视图，如果是，选择图片
    if(touchView == background){
        [self chooseImage];
        
    }
}

#pragma mark --choose pic
-(void)chooseImage
{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择相册图片",@"选择相机图片", nil];
    [sheet showInView:self];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTOLIBRARY" object:nil];
   // [self presentViewController:picker animated:YES completion:nil];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTOCAMERA" object:nil];

        //[self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil  message:@"该设备无摄像头" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
}
/*
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
    if(image !=nil){
        background.image = RotateImage;//替换
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
*/
-(void)refrshUserCentrer:(NSMutableDictionary *)value
{
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma  mark --tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0/1136.0*self.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * imageArray = [NSArray  arrayWithObjects:@"post_icon.png",@"fans.png",@"attention.png",@"photoicon.png",@"collection.png",@"setting.png",nil];
    NSArray *array = [NSArray arrayWithObjects:@"帖子",@"粉丝",@"关注",@"相册",@"收藏",@"设置", nil];
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    if (indexPath.row ==6) {
//        cell.imageView.image =nil;
//        cell.textLabel.text=nil;
//    }
//    else{
//        cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
//        cell.textLabel.text = [array objectAtIndex:indexPath.row];
//        cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];
//    }
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake( 480.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 100.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            numLbl.text = [self.userInfoDic objectForKey:@"postNum"];
            numLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
            numLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            numLbl.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:numLbl];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if(indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake( 480.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 100.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            numLbl.text = [self.userInfoDic objectForKey:@"fans"];
            numLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
            numLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            numLbl.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:numLbl];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        else if(indexPath.row == 2)
        {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake( 480.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 100.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            numLbl.text = [self.userInfoDic objectForKey:@"focus"];
            numLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
            numLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            numLbl.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:numLbl];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        else if(indexPath.row == 3)
        {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(indexPath.row == 4)
        {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake( 480.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 100.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            numLbl.text = [self.userInfoDic objectForKey:@"collectNum"];
            numLbl.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0];
            numLbl.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
            numLbl.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:numLbl];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        else if(indexPath.row == 5)
        {
            cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName: @"Arial-BoldItalicMT" size:14.0];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SECTIONCHOOSE" object:[NSString stringWithFormat:@"%d",indexPath.row]];
}

-(void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    for (int i = 0; i < [self.petsArr count]; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:20+i];
        [btn setHidden:NO];
    }
    NSLog(@"self.pets:%d,%@",[self.petsArr count],self.petsArr);
}

-(void)singleTap:(UILongPressGestureRecognizer *)paramSender{
    for (int i = 0; i < [[self.userInfoDic objectForKey:@"pets"] count]; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:20+i];
        [btn setHidden:YES];
    }
}

-(void)addPet:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDPET" object:nil];
}


-(void)deletePet:(UIButton *)btn
{
    NSLog(@"delete，btn.tag:%d",btn.tag);
    
    DeletePet *dp = [[DeletePet alloc] init];
    [dp deletePet:[[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-20] objectForKey:@"id"] intValue]];
    [dp release];
    
    
    
    [petsArr removeObjectAtIndex:btn.tag-20];
 
    for (UIView *view in self.sv.subviews) {
        if (view.tag == btn.tag-20) {
            [view removeFromSuperview];
        }
        if (view.tag > btn.tag-20) {
            view.frame = CGRectMake(view.frame.origin.x-364.0/640.0*self.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
    }
    
    self.sv.contentSize = CGSizeMake(364.0/640.0*self.frame.size.width*([[self.userInfoDic objectForKey:@"pets"] count]-1)+114.0/640.0*self.frame.size.width, 170.0/1136.0*self.frame.size.height);
    
}

-(void)editPet:(UIButton *)btn
{
    NSLog(@"edit,btn.tag:%d",btn.tag);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"portrait"] forKey:@"portrait"];
    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"name"] forKey:@"name"];
    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"sex"] forKey:@"sex"];
    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"race"] forKey:@"race"];

    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"breed"] forKey:@"breed"];
    [dic setObject:[[[self.userInfoDic objectForKey:@"pets"] objectAtIndex:btn.tag-90] objectForKey:@"birthday"] forKey:@"birthday"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EDITPET" object:dic];
}

-(void)dealloc
{
    [background release];

    [userInfoDic release];
    [sv release];
    [petsArr release];
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
