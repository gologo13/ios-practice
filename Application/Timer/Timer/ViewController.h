//
//  ViewController.h
//  Timer
//
//  Created by Yohei Yamaguchi on 2013/05/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
- (void)onTimer:(NSTimer*)timer;
- (IBAction)tapStart:(id)sender;
- (IBAction)tapStop:(id)sender;
- (IBAction)tapClear:(id)sender;
@end
