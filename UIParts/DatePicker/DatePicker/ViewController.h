//
//  ViewController.h
//  DatePicker
//
//  Created by Yohei Yamaguchi on 2013/06/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePicker.h"

@class DatePicker;
@interface ViewController : UIViewController<UITextFieldDelegate, DatePickerDelegate>
@property (nonatomic, strong) DatePicker *datePicker;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) id delegate;
@end
