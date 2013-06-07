//
//  StudyAppDelegate.m
//  TargetAction
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"

@implementation StudyAppDelegate

- (void)touched
{
    self.window.backgroundColor = [UIColor blackColor];
}

- (void)printConsole
{
    NSLog(@"StudyAppDelegate report tag");
}

- (void)push:(Button*)sender
{
    indicator.backgroundColor = sender.backgroundColor;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    CGRect r = CGRectMake(100, 100, 44, 44);
    indicator = [[UIView alloc] initWithFrame:r];
    [self.window addSubview:indicator];
    indicator.backgroundColor = [UIColor blackColor];
    
    r = CGRectOffset(r, r.size.width + 10, 0);
    
    for (int i = 0; i < 7; ++i) {
        Button *bt = [[Button alloc] initWithFrame:r];
        bt.backgroundColor = [UIColor colorWithHue:(float)i / 7.0 saturation:1.0 brightness:1.0 alpha:1.0];
        bt.target = self;
        bt.action = @selector(push:);
        [self.window addSubview:bt];
        r = CGRectOffset(r, 0, r.size.height);
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
