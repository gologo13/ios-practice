//
//  ViewController.m
//  Timer
//
//  Created by Yohei Yamaguchi on 2013/05/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSDate *startDate;
BOOL contiueCount = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTimer:(NSTimer *)timer
{
    if (contiueCount) {
        NSDate *now = [NSDate date];
        self.label.text = [NSString stringWithFormat:@"%.3f", [now timeIntervalSinceDate:startDate]];
    }
}

- (IBAction)tapStart:(id)sender
{
    contiueCount = YES;
    startDate = [NSDate date];
}

- (IBAction)tapStop:(id)sender
{
    contiueCount = FALSE;
}

- (IBAction)tapClear:(id)sender
{
    contiueCount = FALSE;
    self.label.text = @"0.000";
}

@end