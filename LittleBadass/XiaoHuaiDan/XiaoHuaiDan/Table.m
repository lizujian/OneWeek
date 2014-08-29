//
//  Table.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-1.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "Table.h"

@implementation Table
@synthesize array;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.array = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, frame.size.height) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [table setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.1]];
        
        [self addSubview:table];
        
        [table release];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 26;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height/26.0;
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
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:8.0];
    [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLLTOROW" object:[NSString stringWithFormat:@"%d",indexPath.row]];
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
