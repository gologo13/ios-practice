//
//  InputViewController.m
//  TableController
//
//  Created by Yohei Yamaguchi on 2013/07/02.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

typedef NS_ENUM(NSInteger, InputSectionType) {
    TitleSection,
    MemoSeciton,
    NUM_SECTIONS
};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:style];
        self.title = self.data[@"title"];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *titleCellIdentifier = @"TitleCell";
    static NSString *memoCellIdentitier = @"MemoCell";
    
    UITableViewCell *cell;
    
    NSLog(@"data: %@", self.data);

    
    if (indexPath.section == TitleSection) {
        cell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellIdentifier];
        }
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectInset(cell.contentView.bounds, 8, 8)];
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        textField.text = self.data[@"title"];
        [cell.contentView addSubview:textField];
    } else if (indexPath.section == MemoSeciton) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:memoCellIdentitier];
        }
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(cell.contentView.bounds, 8, 8)];
        textView.delegate = self;
        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        textView.text = self.data[@"memo"];
        [cell.contentView addSubview:textView];
    }

    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if (section == TitleSection) {
        title = @"タイトルを入力";
    } else if (section == MemoSeciton) {
        title = @"メモを入力";
    }
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == TitleSection) {
        height = 44;
    } else if (indexPath.section == MemoSeciton) {
        height = 200;
    }
    return height;
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.data[@"title"] isEqualToString:textField.text])
        return;
    
    self.data[@"title"] = textField.text;
    
    if ([self.inputDelegate respondsToSelector:@selector(inputViewEnter:title:)]) {
        [self.inputDelegate inputViewEnter:self title:self.data[@"title"]];
    } else {
        NSLog(@"inputDelegate doesn't has selector: %@", @"inputViewEnter:title:");
    }
}

#pragma mark - text view delegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.data[@"memo"] isEqualToString:textView.text])
        return;
    
    self.data[@"memo"] = textView.text;
    
    if ([self.inputDelegate respondsToSelector:@selector(inputViewEnter:memo:)]) {
        [self.inputDelegate inputViewEnter:self memo:self.data[@"memo"]];
    } else {
        NSLog(@"inputDelegate doesn't has selector: %@", @"inputViewEnter:memo:");
    }

}

@end
