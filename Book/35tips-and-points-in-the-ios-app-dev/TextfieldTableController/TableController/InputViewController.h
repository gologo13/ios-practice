//
//  InputViewController.h
//  TableController
//
//  Created by Yohei Yamaguchi on 2013/07/02.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputViewController;
@protocol InputViewControllerDelegate <NSObject>

- (void)inputViewEnter:(InputViewController*)InputViewController title:(NSString*)text;
- (void)inputViewEnter:(InputViewController*)InputViewController memo:(NSString*)text;

@end

@interface InputViewController : UITableViewController<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) id<InputViewControllerDelegate> inputDelegate;

@end
