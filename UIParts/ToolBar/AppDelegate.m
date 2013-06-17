//
//  AppDelegate.m
//  ToolBar
//
//  Created by Yohei Yamaguchi on 2013/05/31.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

typedef NS_ENUM(NSUInteger, ButtonType) {
    SaveItemType,
    RewindItemType,
    ForwardItemType,
    CancelItemType,
};

- (void)save
{
    NSLog(@"called");
}

- (void)tap:(UIBarButtonItem*)sender
{
    
    NSLog(@"%@ tag=%d", [sender description], sender.tag);
    
    if (sender.tag == RewindItemType) {
        if (_index <= -2)
            return;
        --_index;
    } else if (sender.tag == ForwardItemType) {
        if (_index >= 2)
            return;
        ++_index;
    }
    NSLog(@"index = %d", _index);
    
    rewindItem.enabled = (_index > -2);
    forwardItem.enabled = (_index < 2);
}

- (void)rewind
{
    --_index;
    NSLog(@"index = %d", _index);
}

- (void)forward
{
    ++_index;
    NSLog(@"index = %d", _index);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, applicationFrame.size.width, 44)];
    [self.window addSubview:toolBar];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(tap:)];
    saveItem.tag = SaveItemType;
    rewindItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                                target:self
                                                                                action:@selector(tap:)];
    rewindItem.tag = RewindItemType;
    forwardItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                                 target:self
                                                                                 action:@selector(tap:)];
    forwardItem.tag = ForwardItemType;
    cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(tap:)];
    cancelItem.tag = CancelItemType;
    toolBar.items = @[cancelItem, rewindItem, forwardItem, saveItem];
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
