//
//  ViewController.m
//  MyBrowser
//
//  Created by Yohei Yamaguchi on 2013/05/04.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gologo13.com/"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleToolbarButton:(id)sender
{
    if (self.goBackButton.hidden) {
        self.goBackButton.hidden = NO;
        self.goForwardButton.hidden = NO;
        self.reloadButton.hidden = NO;
        self.stopButton.hidden = NO;
    } else {
        self.goBackButton.hidden = YES;
        self.goForwardButton.hidden = YES;
        self.reloadButton.hidden = YES;
        self.stopButton.hidden = YES;
    }
}

- (IBAction)toggleURLButton:(id)sender
{
    if (self.bookmarkView.hidden) {
        [self.urlField becomeFirstResponder];
        self.bookmarkView.hidden = NO;
    } else {
        [self.urlField resignFirstResponder];
        self.bookmarkView.hidden = YES;
    }
}

- (IBAction)goGoogle:(id)sender
{
    [self.urlField resignFirstResponder];
    self.bookmarkView.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}

- (IBAction)goYahoo:(id)sender
{
    [self.urlField resignFirstResponder];
    self.bookmarkView.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yahoo.co.jp"]]];
}

- (IBAction)goURL:(id)sender
{
    [self.urlField resignFirstResponder];
    self.bookmarkView.hidden = YES;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlField.text]]];
}

@end
