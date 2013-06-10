//
//  DatePicker.h
//  DatePicker
//
//  Created by Yohei Yamaguchi on 2013/06/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>
- (void)datePickerClose:(UIDatePicker*)datePicker;
@end

@interface DatePicker : UIView
@property (nonatomic, strong) id<DatePickerDelegate> delegate;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *textField;
- (id)initWithFrame:(CGRect)frame;
- (void)datePickerClose:(id)sender;
@end
