//
//  StudyViewController.m
//  Janken
//
//  Created by Yohei Yamaguchi on 2013/05/03.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyViewController.h"

@implementation StudyViewController

typedef enum HandTypes : NSUInteger {
    kHandRock,
    kHandScissor,
    kHandPaper,
} HandTypes;

typedef enum ResultTypes : NSUInteger {
    kResultWin,
    kResultLose,
    kResultEven,
} ResultTypes;

NSString *HandNames[3] = {@"Rock", @"Scissor", @"Paper"};
NSString *ResultNames[3] = {@"You Win!", @"You Lose...", @"Even! Play again!"};

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label_opponent.text = @"";
    self.label_result.text   = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HandTypes)generateOpponentHand
{
    srand(time(nil));
    NSInteger result = rand() % 3;
    HandTypes hand;
    if (result == 0) {
        hand = kHandRock;
    } else if (result == 1) {
        hand = kHandScissor;
    } else {
        hand = kHandPaper;
    }
    return hand;
}

- (ResultTypes)calculateResultType:(HandTypes)myHand withOpponentHand:(HandTypes)opponentHand
{
    ResultTypes ret;
    switch (myHand) {
        case kHandPaper:
            switch (opponentHand) {
                case kHandPaper:
                    ret = kResultEven;
                    break;
                case kHandRock:
                    ret = kResultWin;
                    break;
                case kHandScissor:
                    ret = kResultLose;
                    break;
            }
            break;
        case kHandRock:
            switch (opponentHand) {
                case kHandRock:
                    ret = kResultEven;
                    break;
                case kHandScissor:
                    ret = kResultWin;
                    break;
                case kHandPaper:
                    ret = kResultLose;
                    break;
            }
            break;
        case kHandScissor:
            switch (opponentHand) {
                case kHandScissor:
                    ret = kResultEven;
                    break;
                case kHandPaper:
                    ret = kResultWin;
                    break;
                case kHandRock:
                    ret = kResultLose;
                    break;
            }
            break;
    }
    return ret;
}

- (void)setupBeforePlay
{
    self.label_ready.text = @"Rock, Paper, Scissor...!";
    self.button_play.hidden = NO;
}

- (void)setHiddenTypeOfOtherButtons:(HandTypes)myHand withValue:(BOOL)value
{
    if (myHand == kHandRock) {
        self.button_paper.hidden = value;
        self.button_scissor.hidden = value;
    } else if (myHand == kHandPaper) {
        self.button_scissor.hidden = value;
        self.button_rock.hidden = value;
    } else {
        self.button_rock.hidden = value;
        self.button_paper.hidden = value;
    }
}

- (void)battle:(HandTypes)myHand withOpponentHand:(HandTypes)opponentHand
{
    ResultTypes result = [self calculateResultType:myHand withOpponentHand:opponentHand];
    self.label_result.text = ResultNames[result];
    if (result == kResultEven) {
        [self setHiddenTypeOfOtherButtons:myHand withValue:NO];
        self.button_play.hidden = YES;
    } else {
        self.button_paper.enabled = NO;
    }
}

- (IBAction)button_paper_down:(id)sender
{
    [self button_down_template:sender withMyHand:kHandPaper];
}

- (IBAction)button_scissor_down:(id)sender
{
    [self button_down_template:sender withMyHand:kHandScissor];
}

- (IBAction)button_rock_down:(id)sender
{
    [self button_down_template:sender withMyHand:kHandRock];
}

- (void)button_down_template:(id)sender withMyHand:(HandTypes)myHand
{
    [self setupBeforePlay];
    [self setHiddenTypeOfOtherButtons:myHand withValue:YES];
    
    HandTypes opponentHand = [self generateOpponentHand];
    self.label_opponent.text = HandNames[opponentHand];
    
    [self battle:myHand withOpponentHand:opponentHand];
}

- (IBAction)button_play_down:(id)sender
{
    self.button_paper.enabled = YES;
    self.button_paper.hidden = NO;
    self.button_rock.enabled = YES;
    self.button_rock.hidden = NO;
    self.button_scissor.enabled = YES;
    self.button_scissor.hidden = NO;
    self.button_play.enabled = NO;
    self.label_ready.text = @"ready ...";
    self.label_result.text = @"";
    self.label_opponent.text = @"";
}


@end
