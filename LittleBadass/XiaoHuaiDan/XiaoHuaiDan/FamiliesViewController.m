//
//  FamiliesViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-1.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "FamiliesViewController.h"
#import "MainViewController.h"
#import "SignViewController.h"
#import "Table.h"
#import "PetViewController.h"

@interface FamiliesViewController ()

@end

@implementation FamiliesViewController
@synthesize sectionsArray,dogsArray,table,isFromAddingPet,petName,petSex,portraitPath,race,birthday,breed;

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
    
    self.sectionsArray = [NSMutableArray arrayWithCapacity:0];
    self.dogsArray = [NSMutableArray arrayWithCapacity:0];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 39.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"家族";
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*320.0, 53.0/1136.0*568.0, 63.0/640.0*320.0, 61.0/1136.0*568.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    [barView release];
    [titleText release];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,128.0/1136.0*VIEW_FRAME_HEIGHT, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
//    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    [table release];
    
    Table *tab = [[Table alloc] initWithFrame:CGRectMake(996.0/1136.0*VIEW_FRAME_WIDTH,128.0/1136.0*VIEW_FRAME_HEIGHT, 140.0/1136.0*VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT-128.0/1136.0*VIEW_FRAME_HEIGHT)];
    
    [self.view addSubview:tab];
    [tab release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabScrollToRow:) name:@"SCROLLTOROW"  object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabScrollToRow : (NSNotification *)noti
{
    NSUInteger ii[2] = {[[noti object] intValue], 3};
    NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
    [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)back:(UIButton *)btn
{
    if (isFromAddingPet) {
        PetViewController *pet = [[PetViewController alloc] init];
        pet.name.text = self.petName;
        pet.portrait = self.portraitPath;
        pet.selectedBreed = self.breed;
        pet.selectedRace = self.race;
        pet.birthday = self.birthday;
        pet.sexIndex = self.petSex;
        
        [self presentViewController:pet animated:YES completion:nil];
        [pet release];
        
    }else{
        SignViewController *sign = [[SignViewController alloc] init];
        [self presentViewController:sign animated:NO completion:nil];
        [sign release];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [dogsArray count];
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [sectionsArray count];
    return 26;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0/1136.0*VIEW_FRAME_HEIGHT;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *array = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    return [array objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54.0/1136.0*VIEW_FRAME_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 54.0/1136.0*VIEW_FRAME_HEIGHT;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
//    cell.textLabel.text = [dogsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SCROLLTOROW" object:nil];
    [sectionsArray release];
    [dogsArray release];
    [table release];
    [petName release];
    [portraitPath release];
    [breed release];
    [race release];
    [birthday release];
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
