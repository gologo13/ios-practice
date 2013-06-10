//
//  DatePicker.m
//  DatePicker
//
//  Created by Yohei Yamaguchi on 2013/06/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "DatePicker.h"

@implementation DatePicker

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = 100.0f;
    
    CGRect toolbarFrame   = CGRectMake(0, frame.size.height, 300.f, 50.f);
    CGRect datePickerRect = CGRectMake(0, frame.size.height + 50.f, 300.f, 300.f);
    //CGRect textFieldRect  = CGRectMake(0, frame.size.height + toolbarFrame.origin.y + datePickerRect.origin.y, 300.f, 20.f);
    CGRect superFrame     = CGRectMake(0, 100, 300.f, 350.f);
    
    
    self = [super initWithFrame:superFrame];
    if (self) {
        // Toolbar
        self.toolbar = [[UIToolbar alloc] init];
        [self.toolbar setFrame:toolbarFrame];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                   target:self
                                   action:nil];
        UIBarButtonItem *close = [[UIBarButtonItem alloc]
                                  initWithTitle:@"閉じる"
                                  style:(UIBarButtonItemStyle)UIBarButtonSystemItemCancel
                                  target:self
                                  action:@selector(datePickerClose:)];
        [self.toolbar setItems:@[spacer, close]];
        [self addSubview:self.toolbar];
        
        // DatePicker
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
        self.datePicker.userInteractionEnabled = YES;
        [self.datePicker setFrame:datePickerRect];
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.datePicker];

        // textfield
        //self.textField = [[UITextField alloc] initWithFrame:textFieldRect];
        //[self addSubview:self.textField];
    }
    return self;
}

- (void)dateChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    NSLog(@"selected date = %@", [dateFormater stringFromDate:datePicker.date]);
    
    //self.textField.text = [dateFormater stringFromDate:datePicker.date];
}

- (void)datePickerClose:(id)sender;
{
    if ([self.delegate respondsToSelector:@selector(datePickerClose:)])
        [self.delegate datePickerClose:(UIDatePicker*)sender];
}

@end
