//
//  ReplyChildTable.m
//  XiaoHuaiDan
//
//  Created by WongSuwy on 2014/7/28.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "ReplyChildTable.h"

@implementation ReplyChildTable
@synthesize childArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UITableView *table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = NO;
        [self addSubview:table];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.childArr count];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0/640.0*self.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell = [[UITableViewCell alloc]init];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
        UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake( 0.0/640.0*self.frame.size.width, 13.0/1136.0*self.frame.size.height, 88.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height)];
        name.text = [[self.childArr objectAtIndex:indexPath.row]objectForKey:@""];
        [name setFont:[UIFont fontWithName:@"Arial" size:11.0]];
        name.textColor = [UIColor blueColor];
        [name setEnabled:NO];
        [cell.contentView addSubview:name];
        
        UITextField *contentTxt = [[UITextField alloc] initWithFrame:CGRectMake( 98.0/640.0*self.frame.size.width, 13.0/1136.0*self.frame.size.height, 228.0/640.0*self.frame.size.width, 24.0/1136.0*self.frame.size.height)];
        contentTxt.text = [[self.childArr objectAtIndex:indexPath.row]objectForKey:@""];
        [contentTxt setFont:[UIFont fontWithName:@"Arial" size:11.0]];
        contentTxt.textColor = [UIColor lightGrayColor];
        [contentTxt setEnabled:NO];
        [cell.contentView addSubview:contentTxt];
        
        [contentTxt release];
    
        [name release];
            
            
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"REPLY" object:[self.childArr objectAtIndex:indexPath.row]];
}

-(void)dealloc
{
    [childArr release];
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
