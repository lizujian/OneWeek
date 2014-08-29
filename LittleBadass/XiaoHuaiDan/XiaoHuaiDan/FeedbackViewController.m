//
//  FeedbackViewController.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-30.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "Feedback.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize feedback;

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
    
    [self.view setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_WIDTH, 128.0/1136.0*VIEW_FRAME_HEIGHT)];
    [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [self.view addSubview:barView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(29.0/640.0*VIEW_FRAME_WIDTH, 53.0/1136.0*VIEW_FRAME_HEIGHT, 63.0/640.0*VIEW_FRAME_WIDTH, 61.0/1136.0*VIEW_FRAME_HEIGHT);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"reply_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToSet:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:backBtn];
    
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(261.0/640.0*VIEW_FRAME_WIDTH, 65.0/1136.0*VIEW_FRAME_HEIGHT, 180.0/640.0*VIEW_FRAME_WIDTH, 37.0/1136.0*VIEW_FRAME_HEIGHT)];
    titleText.text = @"反馈意见";
    titleText.textColor = [UIColor whiteColor];
    [titleText setEnabled:NO];
    [barView addSubview:titleText];
    
    [barView release];
    [titleText release];
  
    self.feedback = [[UITextView alloc] initWithFrame:CGRectMake(20.0/640.0*VIEW_FRAME_WIDTH, 158.0/1136.0*VIEW_FRAME_HEIGHT, 600.0/640.0*VIEW_FRAME_WIDTH, 420.0/1136.0*VIEW_FRAME_HEIGHT)];
    [feedback setBackgroundColor:[UIColor whiteColor]];
    feedback.delegate = self;

    [self.view addSubview:feedback];
    
    [feedback release];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sendBtn.frame = CGRectMake(64.0/640.0*VIEW_FRAME_WIDTH,638.0/1136.0*VIEW_FRAME_HEIGHT, 520.0/640.0*VIEW_FRAME_WIDTH, 80.0/1136.0*VIEW_FRAME_HEIGHT);
    [sendBtn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:218.0/255.0 blue:125.0/255.0 alpha:1.0]];
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [feedback resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)sendFeedback:(UIButton *)btn
{
    Feedback *fb = [[Feedback alloc] init];
    [fb feedback:self.feedback.text];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"建议发送成功" message:@"感谢您的建议！问题已经提交给后台，我们将会尽快处理。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
    [alert release];
    
    [feedback resignFirstResponder];

    [fb release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SettingViewController *set = [[SettingViewController alloc] init];
    [self presentViewController:set animated:YES completion:nil];
    [set release];
}

-(void)backToSet:(UIButton *)btn
{
    SettingViewController *set = [[SettingViewController alloc] init];
    [self presentViewController:set animated:YES completion:nil];
    [set release];
}

-(void)dealloc
{
    [feedback release];
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
