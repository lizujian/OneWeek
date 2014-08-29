//
//  FirstTableViewCell.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-5-14.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "FirstTableViewCell.h"


@implementation FirstTableViewCell
@synthesize vc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.vc = [[ViewController alloc] initWithNibName:@"circleView" bundle:nil] ;
        [[self contentView]addSubview:vc.view];
        [vc release];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [vc release];
    [super dealloc];
}

@end
