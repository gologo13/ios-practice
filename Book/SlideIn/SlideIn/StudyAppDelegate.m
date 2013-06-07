//
//  StudyAppDelegate.m
//  SlideIn
//
//  Created by Yohei Yamaguchi on 2013/04/15.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "Pallet.h"

@implementation StudyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // SlideInView
    UIView *slideInView = [[Pallet alloc] initWithFrame:CGRectMake(self.window.bounds.size.width - 44, 50, 300, 300)];
    slideInView.backgroundColor = [UIColor blueColor];
    [self.window addSubview:slideInView];
    
    // TapGesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showhide:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [slideInView addGestureRecognizer:tapGestureRecognizer];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// width of an opendloc:
// X: window, Y:opendloc, Z:SlideInView
// <----------X--------->
// 
// <-----Y-----><---Z---> in case that a slide is shown
// <-------Y-------><-Z-> in case that a slide is hidden
- (void)showhide:(UITapGestureRecognizer*)tapGestureRecognizer
{
    UIView *slideInView = tapGestureRecognizer.view;
    CGRect frame = slideInView.frame;
    CGFloat opendloc = self.window.bounds.size.width - slideInView.frame.size.width;
    
    if (frame.origin.x == opendloc) {
        frame.origin.x = self.window.bounds.size.width - 44;
    } else {
        frame.origin.x = opendloc;
    }
    // animation
    [UIView animateWithDuration:1.0 animations:^(void){
        slideInView.frame = frame;
    }];
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
