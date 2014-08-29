//
//  ScreenView.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-29.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ScreenView.h"

@implementation ScreenView
@synthesize table,sexIndex,petSexIndex,selectedRace,selectedBreed,num,back,backView,arr,distance;
@synthesize pets;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 128.0/1136.0*frame.size.height)];
        [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
        [self addSubview:barView];
        
        UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*frame.size.width, 65.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 39.0/1136.0*frame.size.height)];
        titleText.text = @"LBS筛选";
        titleText.textColor = [UIColor whiteColor];
        [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
        titleText.textAlignment = NSTextAlignmentCenter;
        [titleText setEnabled:NO];
        [barView addSubview:titleText];
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        okBtn.frame = CGRectMake(548.0/640.0*frame.size.width, 53.0/1136.0*frame.size.height, 63.0/640.0*frame.size.width, 64.0/1136.0*frame.size.height);
        [okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(screening:) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:okBtn];
        
        [barView release];
        [titleText release];

        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 128.0/1136.0*frame.size.height, frame.size.width, frame.size.height-128.0/1136.0*frame.size.height) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = NO;//设置tableView不能滚动
        //        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:table];
         [self setExtraCellLineHidden:table];//隐藏多余的分割线
        //[table release];
        
        self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [back setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
        back.opaque = NO;
        [back setHidden:YES];
        [self addSubview:back];
        
        UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(120.0/640.0*frame.size.width, 288.0/1136.0*frame.size.height, 400.0/640.0*frame.size.width, 630.0/1136.0*frame.size.height)];
        [whiteImg setBackgroundColor:[UIColor whiteColor]];
        [whiteImg setUserInteractionEnabled:YES];
        [back addSubview:whiteImg];
        
        UIButton *dogBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        dogBtn.frame = CGRectMake(90.0/640.0*frame.size.width, 70.0/1136.0*frame.size.height, 220.0/640.0*frame.size.width, 220.0/1136.0*frame.size.height);
        [dogBtn setImage:[UIImage imageNamed:@"choose_dog.png"] forState:UIControlStateNormal];
        [dogBtn addTarget:self action:@selector(chooseDog:) forControlEvents:UIControlEventTouchUpInside];
        [whiteImg addSubview:dogBtn];
        
        UIButton *catBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        catBtn.frame = CGRectMake(90.0/640.0*frame.size.width, 338.0/1136.0*frame.size.height, 220.0/640.0*frame.size.width, 220.0/1136.0*frame.size.height);
        [catBtn setImage:[UIImage imageNamed:@"choose_cat.png"] forState:UIControlStateNormal];
        [catBtn addTarget:self action:@selector(chooseCat:) forControlEvents:UIControlEventTouchUpInside];
        [whiteImg addSubview:catBtn];
        
        [back release];
        [whiteImg release];
        
        self.arr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backView setBackgroundColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:0.5]];
        backView.opaque = NO;
        [backView setHidden:YES];
        [self addSubview:backView];
        
        UIImageView *whiteImge = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*frame.size.width, 736.0/1136.0*frame.size.height, frame.size.width, 736.0/1136.0*frame.size.height)];
        [whiteImge setBackgroundColor:[UIColor whiteColor]];
        [whiteImge setUserInteractionEnabled:YES];
        [backView addSubview:whiteImge];
        
        UIPickerView *pick = [[UIPickerView alloc] init];
        pick.showsSelectionIndicator = YES;
        pick.delegate = self;
        pick.dataSource = self;
        [whiteImge addSubview:pick];
        
        UIImageView *wImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0/640.0*frame.size.width, 0.0/1136.0*frame.size.height, frame.size.width, 80.0/1136.0*frame.size.height)];
        [wImg setBackgroundColor:[UIColor lightGrayColor]];
        [wImg setUserInteractionEnabled:YES];
        [whiteImge addSubview:wImg];

        UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        endBtn.frame = CGRectMake(540.0/640.0*frame.size.width, 25.0/1136.0*frame.size.height, 70.0/640.0*frame.size.width, 30.0/1136.0*frame.size.height);
        [endBtn setTitle:@"完成" forState:UIControlStateNormal];
        [endBtn addTarget:self action:@selector(endChoose:) forControlEvents:UIControlEventTouchUpInside];
        [wImg addSubview:endBtn];

        [backView release];
        [whiteImge release];
        [pick release];
        [wImg release];
    }
    return self;
}
//隐藏多余的分割线
-(void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView  *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    [view release];
}

-(void)screening:(UIButton *)btn
{
    [self setHidden:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MAPSHOW" object:nil];
}

-(void)endChoose:(UIButton *)btn
{
    [self.backView setHidden:YES];
    [self.table reloadData];
}
#pragma mark --pickerView
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.arr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arr objectAtIndex:row];
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.distance = [[self.arr objectAtIndex:row] intValue];
}
#pragma mark--tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0/1136.0*self.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] init];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (indexPath.row == 0) {
            UITextField *sex = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 160.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height)];
            sex.text = @"主人性别";
            sex.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [sex setEnabled:NO];
            [cell.contentView addSubview:sex];
            
            UIButton *boyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            boyBtn.frame = CGRectMake(488.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 42.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height);
            if (sexIndex == 1) {
                [boyBtn setBackgroundImage:[UIImage imageNamed:@"man_p01.png"] forState:UIControlStateNormal];
            }else{
                [boyBtn setBackgroundImage:[UIImage imageNamed:@"man_n01.png"] forState:UIControlStateNormal];
            }
            
            [boyBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
            boyBtn.tag = 76;
            [cell.contentView addSubview:boyBtn];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(550.0/640.0*self.frame.size.width, 26.0/1136.0*self.frame.size.height, 2.0/640.0*self.frame.size.width, 38.0/1136.0*self.frame.size.height)];
            [line setBackgroundColor:[UIColor lightGrayColor]];
            [cell.contentView addSubview:line];
            
            UIButton *girlBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            girlBtn.frame = CGRectMake(570.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 42.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height);
            if (sexIndex == 0) {
                [girlBtn setBackgroundImage:[UIImage imageNamed:@"girl_p01.png"] forState:UIControlStateNormal];
            }else{
                [girlBtn setBackgroundImage:[UIImage imageNamed:@"girl_n01.png"] forState:UIControlStateNormal];
            }
            
            [girlBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
            girlBtn.tag = 77;
            [cell.contentView addSubview:girlBtn];
            
        }
        if (indexPath.row == 1) {
            UITextField *raceTxt = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 160.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height)];
            raceTxt.text = @"种族";
            raceTxt.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [raceTxt setEnabled:NO];
            [cell.contentView addSubview:raceTxt];

            UIImageView *petImage = [[UIImageView alloc] initWithFrame:CGRectMake(532.0/640.0*self.frame.size.width, 26.0/1136.0*self.frame.size.height, 52.0/640.0*self.frame.size.width, 48.0/1136.0*self.frame.size.height)];
            if ([self.selectedRace isEqualToString:@"狗"]) {
                [petImage setImage:[UIImage imageNamed:@"dog_p.png"]];
            }else
            {
                [petImage setImage:[UIImage imageNamed:@"cat_p.png"]];
            }
            
            [cell.contentView addSubview:petImage];
            
            UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 16.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
            [cell.contentView addSubview:arrowImg];
            
        }
        if (indexPath.row == 2) {
            UITextField *sex = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 160.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height)];
            sex.text = @"家族";
            sex.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [sex setEnabled:NO];
            [cell.contentView addSubview:sex];
            
            breed = [[UITextField alloc] initWithFrame:CGRectMake(332.0/640.0*self.frame.size.width, 26.0/1136.0*self.frame.size.height, 252.0/640.0*self.frame.size.width, 48.0/1136.0*self.frame.size.height)];
            breed.text = self.selectedBreed;
            breed.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            breed.textAlignment = NSTextAlignmentRight;
            [breed setEnabled:NO];
            [cell.contentView addSubview:breed];
            
            UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 16.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
            [cell.contentView addSubview:arrowImg];
            
        }
        if (indexPath.row == 3) {
            UITextField *sex = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 160.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height)];
            sex.text = @"宠物性别";
            sex.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [sex setEnabled:NO];
            [cell.contentView addSubview:sex];
            
            UIButton *maleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            maleBtn.frame = CGRectMake(508.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 22.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height);
            if (sexIndex == 1) {
                [maleBtn setBackgroundImage:[UIImage imageNamed:@"tie_p01.png"] forState:UIControlStateNormal];
            }else{
                [maleBtn setBackgroundImage:[UIImage imageNamed:@"tie_01.png"] forState:UIControlStateNormal];
            }
            
            [maleBtn addTarget:self action:@selector(selectPetSex:) forControlEvents:UIControlEventTouchUpInside];
            maleBtn.tag = 78;
            [cell.contentView addSubview:maleBtn];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(550.0/640.0*self.frame.size.width, 26.0/1136.0*self.frame.size.height, 2.0/640.0*self.frame.size.width, 38.0/1136.0*self.frame.size.height)];
            [line setBackgroundColor:[UIColor lightGrayColor]];
            [cell.contentView addSubview:line];
            
            UIButton *femaleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            femaleBtn.frame = CGRectMake(570.0/640.0*self.frame.size.width, 30.0/1136.0*self.frame.size.height, 44.0/640.0*self.frame.size.width, 25.0/1136.0*self.frame.size.height);
            if (sexIndex == 0) {
                [femaleBtn setBackgroundImage:[UIImage imageNamed:@"bowknot_p03.png"] forState:UIControlStateNormal];
            }else{
                [femaleBtn setBackgroundImage:[UIImage imageNamed:@"bowknot_n03.png"] forState:UIControlStateNormal];
            }
            
            [femaleBtn addTarget:self action:@selector(selectPetSex:) forControlEvents:UIControlEventTouchUpInside];
            femaleBtn.tag = 79;
            [cell.contentView addSubview:femaleBtn];
            
        }
        if (indexPath.row == 4) {
            UITextField *dist = [[UITextField alloc] initWithFrame:CGRectMake( 30.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height, 160.0/640.0*self.frame.size.width, 42.0/1136.0*self.frame.size.height)];
            dist.text = @"距离";
            dist.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [dist setEnabled:NO];
            [cell.contentView addSubview:dist];
            
            UITextField *number = [[UITextField alloc] initWithFrame:CGRectMake(494.0/640.0*self.frame.size.width, 26.0/1136.0*self.frame.size.height, 100.0/640.0*self.frame.size.width, 48.0/1136.0*self.frame.size.height)];
            number.text = [NSString stringWithFormat:@"%dKM",self.distance];
            number.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
            [number setEnabled:NO];
            [cell.contentView addSubview:number];
            
            UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake( 604.0/640.0*self.frame.size.width, 32.0/1136.0*self.frame.size.height, 16.0/640.0*self.frame.size.width, 28.0/1136.0*self.frame.size.height)];
            [arrowImg setImage:[UIImage imageNamed:@"right_arrow.png"]];
            [cell.contentView addSubview:arrowImg];
            
        }

        
    }
    
    return cell;
}
-(void)selectPet:(NSString * )pet
{
    breed.text = pet;
    self.selectedBreed = pet;
    NSLog(@"pet:%@",pet);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.back setHidden:NO];
    }
    if (indexPath.row ==2) {
        NSString * aName = @"";
        if ([self.selectedRace isEqualToString:@"狗"]) {
            aName = @"dog";
        }
        else
            aName = @"cat";
        pets = [[PetFamily alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) name:aName];
        pets.delegate = self;
        pets.method = @selector(selectPet:);
        [self addSubview:pets];
    }
    if (indexPath.row == 4) {
        [self.backView setHidden:NO];
    }
    
}

-(void)selectPetSex:(UIButton *)btn
{
    if (btn.tag == 78) {
        [btn setBackgroundImage:[UIImage imageNamed:@"tie_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self viewWithTag:79];
        [button setBackgroundImage:[UIImage imageNamed:@"bowknot_n03.png"] forState:UIControlStateNormal];
        self.sexIndex = 1;
        
    }
    if (btn.tag == 79) {
        [btn setBackgroundImage:[UIImage imageNamed:@"bowknot_p03.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self viewWithTag:78];
        [button setBackgroundImage:[UIImage imageNamed:@"tie_01.png"] forState:UIControlStateNormal];
        self.sexIndex = 0;
    }
}

-(void)selectSex:(UIButton *)btn
{
    if (btn.tag == 76) {
        [btn setBackgroundImage:[UIImage imageNamed:@"man_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self viewWithTag:77];
        [button setBackgroundImage:[UIImage imageNamed:@"girl_n01.png"] forState:UIControlStateNormal];
        self.petSexIndex = 1;
        
    }
    if (btn.tag == 77) {
        [btn setBackgroundImage:[UIImage imageNamed:@"girl_p01.png"] forState:UIControlStateNormal];
        
        UIButton *button = (UIButton *)[self viewWithTag:76];
        [button setBackgroundImage:[UIImage imageNamed:@"man_n01.png"] forState:UIControlStateNormal];
        self.petSexIndex = 0;
    }
}

-(void)chooseDog:(UIButton *)btn
{
    self.selectedRace = @"狗";
    [self.back setHidden:YES];
    [self.table reloadData];
}

-(void)chooseCat:(UIButton *)btn
{
    self.selectedRace = @"猫";
    [self.back setHidden:YES];
    [self.table reloadData];
}

-(void)dealloc
{
    [table release];
    [breed release];
    
    [selectedRace release];
    [selectedBreed release];
    [num release];
    [back release];
    [backView release];
    [arr release];
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
