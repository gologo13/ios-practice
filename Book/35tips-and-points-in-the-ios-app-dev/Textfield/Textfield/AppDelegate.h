//
//  AppDelegate.h
//  Textfield
//
//  Created by Yohei Yamaguchi on 2013/07/01.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *button;

@end
