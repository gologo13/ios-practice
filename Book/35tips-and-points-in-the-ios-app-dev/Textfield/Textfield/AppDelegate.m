//
//  AppDelegate.m
//  Textfield
//
//  Created by Yohei Yamaguchi on 2013/07/01.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"

#define TEXTFIELD_HEIGHT 46

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // textfield
    CGRect textFieldFrame = [UIScreen mainScreen].applicationFrame;
    textFieldFrame.origin.y = textFieldFrame.origin.y + textFieldFrame.size.height - 300;
    textFieldFrame.size.height = TEXTFIELD_HEIGHT;
    self.textField = [[UITextField alloc] initWithFrame:CGRectInset(textFieldFrame, 4, 8)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    
    // button
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = CGRectMake(textFieldFrame.origin.x, textFieldFrame.origin.y - 40, 100, 40);
    [self.button setTitle:@"入力終了" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(didFinishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // GestureRecognizer
    UITapGestureRecognizer *keyboardCloser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didFinishButtonClicked:)];

    // window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window addSubview:self.textField];
    [self.window addSubview:self.button];
    [self.window addGestureRecognizer:keyboardCloser];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 

- (void)didFinishButtonClicked:(UIButton*)button
{
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return NO;
}


@end
