//
//  FlipViewController.m
//  Heart
//
//  Created by Yohei Yamaguchi on 2013/06/23.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "FlipViewController.h"

@interface FlipViewController ()
@property (nonatomic, strong) UIButton *flipButton;
@end

@implementation FlipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHue:(float)(rand() % 100) / 100.0 saturation:1 brightness:1 alpha:1];
    self.flipButton = [UIButton buttonWithType: UIButtonTypeInfoLight];
    [self.view addSubview: self.flipButton];
    self.flipButton.frame = CGRectOffset(self.flipButton.frame, self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.flipButton addTarget:self action:@selector(didFlipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
    [UIView animateWithDuration:2 animations:^(void) {
        self.flipButton.center = CGPointMake(self.flipButton.center.x + 100, self.flipButton.center.y);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"viewWillDisappear");
    [UIView animateWithDuration:2 animations:^(void) {
        self.flipButton.center = CGPointMake(self.flipButton.center.x - 100, self.flipButton.center.y);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFlipButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    FlipViewController *flipViewController = [[FlipViewController alloc] init];
    flipViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical; // 下からにゅっと出現
    [self presentViewController:flipViewController 	animated:YES completion:NULL];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
