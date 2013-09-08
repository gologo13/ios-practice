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
    self.navigationItem.title = @"Heart Mark";
    self.navigationItem.backBarButtonItem = [UIBarButtonItem new];
    self.navigationItem.backBarButtonItem.image = [HeartView heartIcon];
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
    [self.navigationController pushViewController:flipViewController animated:YES];
    /*
     camera
     
    UIImagePickerController *picker = [UIImagePickerController new];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }˙
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
    */
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

/*
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
 */

@end
