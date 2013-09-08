//
//  StudyAppDelegate.m
//  ViewInViewTouch
//
//  Created by Yohei Yamaguchi on 2013/03/29.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "InteractiveView.h"

@implementation StudyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIView *firstView = [[InteractiveView alloc] initWithFrame:CGRectMake(20, 20, 180, 200)];
    [self.window addSubview:firstView];
    firstView.backgroundColor = [UIColor redColor];

    UIView *nestedView = [[InteractiveView alloc] initWithFrame:CGRectMake(60, 60, 180, 200)];
    nestedView.backgroundColor = [UIColor orangeColor];
    [firstView addSubview:nestedView];
    
    UIView *overView = [[InteractiveView alloc] initWithFrame:CGRectMake(140, 140, 180, 200)];
    overView.backgroundColor = [UIColor greenColor];
    //[self.window addSubview:overView];
    [self.window insertSubview:overView aboveSubview:firstView];
    nestedView.alpha = 0.5;
    firstView.alpha = 0.5;
    firstView.userInteractionEnabled = YES;
    nestedView.backgroundColor = [UIColor clearColor];
    
    
//    [self.window exchangeSubviewAtIndex:[@2 integerValue] withSubviewAtIndex:[@0 integerValue]];
    
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
