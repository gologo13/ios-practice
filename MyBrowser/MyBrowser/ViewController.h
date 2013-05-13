//
//  ViewController.h
//  MyBrowser
//
//  Created by Yohei Yamaguchi on 2013/05/04.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)toggleToolbarButton:(id)sender;
- (IBAction)toggleURLButton:(id)sender;
- (IBAction)goURL:(id)sender;
- (IBAction)goGoogle:(id)sender;
- (IBAction)goYahoo:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *web;

// Toolbar Buttons
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIButton *goForwardButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

// Buttons to controll the URL
@property (weak, nonatomic) IBOutlet UIView *bookmarkView;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UIButton *googleButton;
@property (weak, nonatomic) IBOutlet UIButton *yahooButton;


@end
