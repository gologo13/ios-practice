//
//  AppDelegate.h
//  Table
//
//  Created by Yohei Yamaguchi on 2013/06/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITableViewController *controller;
@property (strong, nonatomic) NSMutableArray *sections;
@end
