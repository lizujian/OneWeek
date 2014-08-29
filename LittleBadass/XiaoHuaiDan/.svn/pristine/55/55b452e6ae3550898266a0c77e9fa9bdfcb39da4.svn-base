//
//  MainPageCell.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-5-15.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MainPageCell.h"
#import "MainViewController.h"

@implementation MainPageCell
@synthesize sideView,sectionImgView,conView,titleText,contentText,userImgView,userNameText,numText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.sideView = [[UIView alloc] initWithFrame:CGRectMake(18.0/640.0*320.0, 10.0/1136.0*568.0, 50.0/640.0*320.0, 180.0/1136.0*568.0)];
//        [self.sideView setBackgroundColor:circleColorPattern];
//        [self addSubview:self.sideView];
        
        self.conView = [[UIImageView alloc] initWithFrame:CGRectMake(86.0/640.0*320.0, 10.0/1136.0*568.0, 534.0/640.0*320.0, 180.0/1136.0*568.0)];
        [self.conView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.conView];
        
        UIImageView *footZer = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 5.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footZer setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footZer];
        
        self.sectionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(18.0/640.0*320.0, 10.0/1136.0*568.0, 50.0/640.0*320.0, 50.0/1136.0*568.0)];
        [self addSubview:self.sectionImgView];
//        [self addSubview:self.sectionImgView];
        
        UIImageView *footOne = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 60.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footOne setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footOne];
        UIImageView *footTwo = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 86.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footTwo setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footTwo];
        UIImageView *footThr = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 112.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footThr setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footThr];
        UIImageView *footFou = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 138.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footFou setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footFou];
        UIImageView *footFiv = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 164.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footFiv setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footFiv];
        UIImageView *footSix = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 73.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footSix setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footSix];
        UIImageView *footSev = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 99.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footSev setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footSev];
        UIImageView *footEig = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 125.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footEig setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footEig];
        UIImageView *footNin = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 151.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footNin setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footNin];
        UIImageView *footTen = [[UIImageView alloc] initWithFrame:CGRectMake(45.0/640.0*320.0, 177.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footTen setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footTen];
        UIImageView *footEle = [[UIImageView alloc] initWithFrame:CGRectMake(27.0/640.0*320.0, 190.0/1136.0*568.0, 13.0/640.0*320.0, 13.0/1136.0*568.0)];
        [footEle setImage:[UIImage imageNamed:@"footprint.png"]];
        [self addSubview:footEle];
                
        self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(107.0/640.0*320.0, 21.0/1136.0*568.0, 460.0/640.0*320.0, 25.0/1136.0*568.0)];
        self.titleText.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.titleText.textColor = [UIColor colorWithRed:103.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0];
        [self.titleText setEnabled:NO];
        [self addSubview:self.titleText];
        
        self.contentText = [[UITextView alloc] initWithFrame:CGRectMake(108.0/640.0*320.0, 62.0/1136.0*568.0, 490.0/640.0*320.0, 52.0/1136.0*568.0)];
        self.contentText.font = [UIFont fontWithName:@"Helvetica" size:11];
        self.contentText.textColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0];
        [self.contentText setBackgroundColor:[UIColor clearColor]];
        [contentText setEditable:NO];
        [contentText setScrollEnabled:NO];
        [self addSubview:self.contentText];
        
        self.userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(107.0/640.0*320.0, 121.0/1136.0*568.0, 57.0/640.0*320.0, 59.0/1136.0*568.0)];
        userImgView.layer.cornerRadius = 5;//设置那个圆角的有多圆
        userImgView.layer.masksToBounds = YES;        
        [self addSubview:self.userImgView];
        
        self.userNameText = [[UITextField alloc] initWithFrame:CGRectMake(170.0/640.0*320.0, 138.0/1136.0*568.0, 86.0/640.0*320.0, 26.0/1136.0*568.0)];
        self.userNameText.font = [UIFont fontWithName:@"Helvetica" size:13];
        self.userNameText.textColor = [UIColor colorWithRed:114.0/255.0 green:194.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self.userNameText setEnabled:NO];
        [self addSubview:self.userNameText];
        
        self.numText = [[UITextField alloc] initWithFrame:CGRectMake(465.0/640.0*320.0, 160.0/1136.0*568.0, 131.0/640.0*320.0, 23.0/1136.0*568.0)];
        self.numText.font = [UIFont fontWithName:@"Helvetica" size:9];
        self.numText.textColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0];
        [self.numText setEnabled:NO];
        [self addSubview:self.numText];
        
        [sideView release];
        [sectionImgView release];
        [conView release];
        [titleText release];
        [contentText release];
        [userImgView release];
        [userNameText release];
        [numText release];
        
        [footZer release];
        [footOne release];
        [footTwo release];
        [footThr release];
        [footFou release];
        [footFiv release];
        [footSix release];
        [footSev release];
        [footEig release];
        [footNin release];
        [footTen release];
        [footEle release];
      
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
    [sectionImgView release];
    [conView release];
    [titleText release];
    [contentText release];
    [userImgView release];
    [userNameText release];
    [numText release];
    [super dealloc];
}
@end
