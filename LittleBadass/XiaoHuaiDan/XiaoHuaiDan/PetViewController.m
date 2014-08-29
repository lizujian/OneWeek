//
//  PetViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PetViewController.h"
#import "MainViewController.h"
#import "FamiliesViewController.h"
#import "PostPetData.h"
#import "PetFamily.h"
@interface PetViewController ()

@end

@implementation PetViewController
@synthesize table,name,sexIndex,selectedBreed,selectedRace,pick,birthday,portrait,petName,editBack,petBtn,isEdit,fileData,img,filePath,pets;

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
    [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(261.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"宠物档案";
    titleText.textColor = [UIColor whiteColor];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    okBtn.frame = CGRectMake(548.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 64.0/1136.0*VIEW_FRAME_HEIGHT);
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(finishAdd:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:okBtn];
    
    [barView release];
    [titleText release];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 600.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.scrollEnabled = NO;
    //    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    self.editBack = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*VIEW_FRAME_WIDTH, 0.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT)];
    [editBack setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
    [editBack setUserInteractionEnabled:YES];
    [editBack setHidden:YES];
    [self.view addSubview:editBack];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(30.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelEdit:) forControlEvents:UIControlEventTouchUpInside];
    [editBack addSubview:cancelBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    endBtn.frame = CGRectMake(540.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT, 70.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT);
    [endBtn setTitle:@"完成" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventTouchUpInside];
    [editBack addSubview:endBtn];
    
    [editBack release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBackPetView:) name:@"GOBackPet" object:nil];


}
-(void)goBackPetView:(UIButton *)btn
{
    [self.pets removeFromSuperview];
    //[self.view addSubview:<#(UIView *)#>];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelEdit:(UIButton *)btn
{
    [self.name resignFirstResponder];
    [editBack setHidden:YES];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
    NSLog(@"%f",height);

    
    [self.editBack setFrame:CGRectMake(0, VIEW_FRAME_HEIGHT-70.0/1136.0*VIEW_FRAME_HEIGHT-height, VIEW_FRAME_WIDTH, 70.0/1136.0*VIEW_FRAME_HEIGHT)];
    [editBack setHidden:NO];
    
    CATransition* transition = [CATransition animation];
    [transition setDuration:0.48];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [editBack.layer addAnimation:transition forKey:kCATransition];
}

-(void)endEdit:(UIButton *)btn
{
    if (self.name.text == nil || self.name.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"填写错误" message:@"爱称不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        [self.name resignFirstResponder];
        self.petName = self.name.text;
        [editBack setHidden:YES];
    }
}

-(void)finishAdd:(UIButton *)btn
{
    //  [ppd postPetData:self.petName Race:self.selectedRace Breed:self.selectedBreed Sex:self.sexIndex Portrait:self.filePath Birth:self.birthday :main.per];
    //self.selectedBreed = @"比熊";
    NSLog(@"headImage:%@",self.filePath);
    NSLog(@"name:%@",self.petName);
    NSLog(@"breed:%@",self.selectedRace);
    NSLog(@"family:%@",self.selectedBreed);
    NSLog(@"sex:%d",self.sexIndex);
    NSLog(@"birth:%@",self.birthday);
    if (self.petName == nil || self.petName == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"填写错误" message:@"爱称不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    if (self.selectedRace == nil || self.selectedRace == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"种族没选择。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    if (self.selectedBreed == nil || self.selectedBreed == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"家族没选择。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }if (self.birthday == nil || self.birthday.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择出生日期。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        
        MainViewController *main = [[MainViewController alloc] init];
        [main showPersonalCenter:btn];
        [main.userBtn setBackgroundImage:[UIImage imageNamed:@"gata_press.png"] forState:UIControlStateNormal];
        [main.lbsBtn setBackgroundImage:[UIImage imageNamed:@"location_noimal.png"] forState:UIControlStateNormal];
        [main.mainpageBtn setBackgroundImage:[UIImage imageNamed:@"homepage_normal.png"] forState:UIControlStateNormal];
        
        PostPetData *ppd = [[PostPetData alloc] init];
        [ppd postPetData:self.petName Race:self.selectedRace Breed:self.selectedBreed Sex:self.sexIndex Portrait:self.filePath Birth:self.birthday :main.per];
        [ppd release];
        
        [self presentViewController:main animated:NO completion:nil];
        [main release];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.name resignFirstResponder];
//    self.petName = textField.text;
    [self.editBack setHidden: YES];
    return YES;
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

#pragma mark --tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
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
    
    static NSString *CellIdentifier = @"CellIdentifier";
    NSArray * dataArray = [NSArray arrayWithObjects:@"头像",@"爱称",@"性别",@"种族",@"家族",@"出生日期", nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];

        if (indexPath.row == 0) {
            //宠物头像
            self.petBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            petBtn.frame = CGRectMake( 508.0/640.0*VIEW_FRAME_WIDTH, 22.0/1136.0*VIEW_FRAME_HEIGHT, 106.0/640.0*VIEW_FRAME_WIDTH, 106.0/1136.0*VIEW_FRAME_HEIGHT);
            if (isEdit) {
                [petBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.portrait]]] forState:UIControlStateNormal];
            }else{
                [petBtn setBackgroundImage:[UIImage imageNamed:@"pet_avatar.png"] forState:UIControlStateNormal];
            }
            //[ppd postPetData:self.petName Race:self.selectedRace Breed:self.selectedBreed Sex:self.sexIndex Portrait:self.portrait Birth:self.birthday :main.per];
            [petBtn addTarget:self action:@selector(setPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:petBtn];
            
        }
        if(indexPath.row == 1)
        {
            //宠物名字
            self.name = [[UITextField alloc] initWithFrame:CGRectMake( 400.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT, 200.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT)];
            name.placeholder = @"请在此输入爱称";
            name.text = self.petName;
            name.textAlignment = UITextAlignmentRight;
            name.clearButtonMode = UITextFieldViewModeWhileEditing;
            [name setFont:[UIFont fontWithName:@"Arial" size:14.0]];
            name.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            name.delegate = self;
            [cell.contentView addSubview:name];
            
            
        }
        if (indexPath.row == 2)
        {
            //性别
            UIButton *maleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            maleBtn.frame = CGRectMake(508.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT, 22.0/640.0*VIEW_FRAME_WIDTH, 42.0/1136.0*VIEW_FRAME_HEIGHT);
            if (self.sexIndex == 1) {
                [maleBtn setBackgroundImage:[UIImage imageNamed:@"tie_p01.png"] forState:UIControlStateNormal];
            }else{
                [maleBtn setBackgroundImage:[UIImage imageNamed:@"tie_01.png"] forState:UIControlStateNormal];
                //[ppd postPetData:self.petName Race:self.selectedRace Breed:self.selectedBreed Sex:self.sexIndex Portrait:self.portrait Birth:self.birthday :main.per];
                self.sexIndex = 0;
            }
            [maleBtn addTarget:self action:@selector(selectPetSex:) forControlEvents:UIControlEventTouchUpInside];
            maleBtn.tag = 78;
            [cell.contentView addSubview:maleBtn];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(550.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT, 2.0/640.0*VIEW_FRAME_WIDTH, 38.0/1136.0*VIEW_FRAME_HEIGHT)];
            [line setBackgroundColor:[UIColor lightGrayColor]];
            [cell.contentView addSubview:line];
            
            UIButton *femaleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            femaleBtn.frame = CGRectMake(570.0/640.0*VIEW_FRAME_WIDTH, 30.0/1136.0*VIEW_FRAME_HEIGHT, 44.0/640.0*VIEW_FRAME_WIDTH, 25.0/1136.0*VIEW_FRAME_HEIGHT);
            if (self.sexIndex == 0) {
                [femaleBtn setBackgroundImage:[UIImage imageNamed:@"bowknot_p03.png"] forState:UIControlStateNormal];
            }else{
                [femaleBtn setBackgroundImage:[UIImage imageNamed:@"bowknot_n03.png"] forState:UIControlStateNormal];
            }
            [femaleBtn addTarget:self action:@selector(selectPetSex:) forControlEvents:UIControlEventTouchUpInside];
            femaleBtn.tag = 79;
            [cell.contentView addSubview:femaleBtn];

        }
        if(indexPath.row == 3){
            //宠物种族
          petImage = [[UIImageView alloc] initWithFrame:CGRectMake(532.0/640.0*VIEW_FRAME_WIDTH, 26.0/1136.0*VIEW_FRAME_HEIGHT, 52.0/640.0*VIEW_FRAME_WIDTH, 48.0/1136.0*VIEW_FRAME_HEIGHT)];
            if ([self.selectedRace isEqualToString:@"狗"]) {
                [petImage setImage:[UIImage imageNamed:@"dog_p.png"]];
            }else
            {
                [petImage setImage:[UIImage imageNamed:@"cat_p.png"]];
                self.selectedRace =@"猫";
            }
            
            [cell.contentView addSubview:petImage];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 4)
        {
            //宠物家族
            petFamilyName =  [[UITextField alloc] initWithFrame:CGRectMake( 400.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT)];
            petFamilyName.textColor = [UIColor grayColor];
            petFamilyName.font = [UIFont systemFontOfSize:14];
            petFamilyName.textAlignment = UITextAlignmentRight;
            petFamilyName.text = self.selectedBreed;
            [cell.contentView addSubview:petFamilyName];
            petFamilyName.enabled = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 5)
        {
            //出生日期
           birthdayText = [[UITextField alloc] initWithFrame:CGRectMake( 400.0/640.0*VIEW_FRAME_WIDTH, 24.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 32.0/1136.0*VIEW_FRAME_HEIGHT)];
            birthdayText.text = self.birthday;
            birthdayText.enabled= NO;
            birthdayText.textColor = [UIColor grayColor];
            birthdayText.font = [UIFont systemFontOfSize:14];
            birthdayText.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:birthdayText];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
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
    if (indexPath.row == 4) {
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
    }
    if (indexPath.row == 5) {
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
        //系统当前时间
        NSString * date = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *maxDate= [dateFormatter dateFromString:date];
        
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
}

-(void)selectPet:(NSString * )pet
{
    petFamilyName.text = pet;
    self.selectedBreed = pet;
    NSLog(@"pet:%@",pet);
}

-(void)selectPetSex:(UIButton *)btn
{
    if (btn.tag == 78) {
        [btn setBackgroundImage:[UIImage imageNamed:@"tie_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:79];
        [button setBackgroundImage:[UIImage imageNamed:@"bowknot_n03.png"] forState:UIControlStateNormal];
        self.sexIndex = 1;
        
    }
    if (btn.tag == 79) {
        [btn setBackgroundImage:[UIImage imageNamed:@"bowknot_p03.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:78];
        [button setBackgroundImage:[UIImage imageNamed:@"tie_01.png"] forState:UIControlStateNormal];
        self.sexIndex = 0;
    }
}

-(void)chooseDog:(UIButton *)btn
{
    self.selectedRace = @"狗";
    UIView *back = [self.view viewWithTag:56];
    [back removeFromSuperview];
    [petImage setImage:[UIImage imageNamed:@"dog_p.png"]];
    //[self.table reloadData];
}

-(void)chooseCat:(UIButton *)btn
{
    self.selectedRace = @"猫";
    UIView *back = [self.view viewWithTag:56];
    [back removeFromSuperview];
    [petImage setImage:[UIImage imageNamed:@"cat_p.png"]];
   // [self.table reloadData];
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
    NSString *type = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"type:%@",type);
    self.img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    CGSize imagesize = img.size;
    imagesize.height =626;
    imagesize.width =413;
    
    if (UIImagePNGRepresentation(img) == nil)
    {
        fileData = UIImageJPEGRepresentation(img, 0.0);
    }
    else
    {
        fileData = UIImagePNGRepresentation(img);

    }

    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:self.fileData attributes:nil];

    //得到选择后沙盒中图片的完整路径
//        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    self.filePath = [NSString stringWithFormat:@"%@/image.png",DocumentsPath];

    [self.petBtn setBackgroundImage:self.img forState:UIControlStateNormal];

    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];

    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

//对图片尺寸进行压缩--

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
    
}

-(void)cancel:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
}

-(void)endChoose:(UIButton *)btn
{
    UIView *backImg = [self.view viewWithTag:56];
    [backImg removeFromSuperview];
   // [self.table reloadData];
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
    birthdayText.text = self.birthday;
  //  NSLog(@"birthday:%@",self.birthday);
}

-(void)dealloc
{
    [table release];
    [name release];
    [pick release];
    [portrait release];
    [birthday release];
    [selectedBreed release];
    [selectedRace release];
    [petName release];
    [petBtn release];
    [fileData release];
    [img release];
    [filePath release];
    [petImage release];
    [birthdayText release];
    [petFamilyName release];
       [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOBackPet" object:nil];
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
