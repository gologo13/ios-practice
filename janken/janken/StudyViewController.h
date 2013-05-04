//
//  StudyViewController.h
//  Janken
//
//  Created by Yohei Yamaguchi on 2013/05/03.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label_ready;
@property (weak, nonatomic) IBOutlet UIImageView *label_opponent;
@property (weak, nonatomic) IBOutlet UILabel *label_result;
@property (weak, nonatomic) IBOutlet UIButton *button_rock;
@property (weak, nonatomic) IBOutlet UIButton *button_scissor;
@property (weak, nonatomic) IBOutlet UIButton *button_paper;
@property (weak, nonatomic) IBOutlet UIButton *button_play;

- (IBAction)button_rock_down:(id)sender;
- (IBAction)button_scissor_down:(id)sender;
- (IBAction)button_paper_down:(id)sender;
- (IBAction)button_play_down:(id)sender;

@end
