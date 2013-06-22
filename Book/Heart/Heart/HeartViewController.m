//
//  HeartViewController.m
//  Heart
//
//  Created by Yohei Yamaguchi on 2013/06/20.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "HeartViewController.h"
#import "HeartView.h"
#import "FlipViewController.h"

@interface HeartViewController ()

@end

@implementation HeartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor orangeColor];
    HeartView *heartView = [[HeartView alloc] initWithFrame:CGRectInset(self.view.bounds, 44, 44)];
    heartView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:heartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    FlipViewController *flipViewController = [[FlipViewController alloc] init];
    flipViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical; // 下からにゅっと出現
    //flipViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve; //フェードアウトとフェードイン
    //flipViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; // 畳返し
    //flipViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl; // ページめくり
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
