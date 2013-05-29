//
//  SecondViewController.h
//  TabbarTimer
//
//  Created by Yohei Yamaguchi on 2013/05/15.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)tapStart:(id)sender;
- (IBAction)tapStop:(id)sender;
- (IBAction)tapClear:(id)sender;
@end
