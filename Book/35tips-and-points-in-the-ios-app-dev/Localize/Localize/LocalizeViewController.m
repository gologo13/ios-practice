//
//  LocalizeViewController.m
//  Localize
//
//  Created by Yohei Yamaguchi on 2013/08/26.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "LocalizeViewController.h"

@interface LocalizeViewController ()

@end

@implementation LocalizeViewController

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
    UIImage *image = [UIImage imageNamed:@"frog.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

@end
