//
//  ViewController.m
//  DatePicker
//
//  Created by Yohei Yamaguchi on 2013/06/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "ViewController.h"
#import "DatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect datePickerFrame = CGRectMake(0, 0, 300.f, 50.f);
    self.datePicker = [[DatePicker alloc] initWithFrame:datePickerFrame];
    self.datePicker.delegate = self;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300.f, 50.f)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"指定なし";
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.textField addTarget:self
                       action:@selector(datePickerClose:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DatePicker delegate
- (void)datePickerClose:(UIDatePicker *)datePicker
{
    NSLog(@"closed button is clicked");
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"hoge");
}


@end
