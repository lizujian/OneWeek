//
//  ViewController.m
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-8.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import "ViewController.h"
#import "viewCell.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController

@synthesize circle_view = _circle_view;



- (IBAction)pressed:(id)sender
{
    [_circle_view reloadData];
}

#pragma mark -
#pragma mark - 初始化

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        _icon_array = [[NSMutableArray alloc] init];
//        [_icon_array addObject:[UIImage imageNamed:@"1.png"]];
//        [_icon_array addObject:[UIImage imageNamed:@"2.png"]];
//        [_icon_array addObject:[UIImage imageNamed:@"3.png"]];
//        [_icon_array addObject:[UIImage imageNamed:@"4.png"]];
//        [_icon_array addObject:[UIImage imageNamed:@"5.png"]];
//        [_icon_array addObject:[UIImage imageNamed:@"6.png"]];
        
        [_icon_array addObject:[UIImage imageNamed:@"according_blasting_a.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"kitten_star_a.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"spitslot_a.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"bowwow_a.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"feed.png"]];
        
    }
    
    return self;
}

#pragma mark -
#pragma mark - view 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _circle_view.circle_view_data_source = self;
    _circle_view.circle_view_delegate    = self;
    _circle_view.show_circle_style       = SChShowCircleWinding;
    [_circle_view reloadData];
    _circle_view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image.png"]];
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - SCHCircleViewDataSource


- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    return CGPointMake(160.0f, 160.0f);
}

- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view
{
    return _icon_array.count;
}

- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell
{
    viewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"viewCell" owner:nil options:nil] lastObject];
    
    [cell.image_view setImage:[_icon_array objectAtIndex:index_circle_cell]];
    
    return cell;
}

#pragma mark - 
#pragma mark - SCHCircleViewDelegate
- (void)touchEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index
{
    NSLog(@"%d",index);
//    if (index == 0) {
//        PostViewController *pvc = [[PostViewController alloc] init];
//        [self presentViewController:pvc animated:YES completion:nil];
//        
//        [pvc release];
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOTO" object:[NSString stringWithFormat: @"%d", index]];
}

#pragma mark -
#pragma mark - dealloc 
- (void)dealloc
{
    [_icon_array  release], _icon_array  = nil;
    
    [_circle_view release], _circle_view = nil;
    
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
