//
//  RetryAppDelegate.m
//  Backbone
//
//  Created by Yohei Yamaguchi on 2013/03/24.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "RetryAppDelegate.h"

@implementation RetryAppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@", @"didFinishLaunching\n");
    
    window = [[UIWindow alloc] initWithFrame:CGRectMake(50, 200, 150, 100)];
    window.backgroundColor = [UIColor cyanColor];
    [window makeKeyAndVisible];
    
    return YES;
}
@end
