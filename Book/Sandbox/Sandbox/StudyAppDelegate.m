//
//  StudyAppDelegate.m
//  Sandbox
//
//  Created by Yohei Yamaguchi on 2013/03/31.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"

@implementation StudyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"doumentsDirecotry = %s", [documentsDirectory UTF8String]);
    int persistentValueInteger = 0;
    NSLog(@"persistentValueInteger = %d", persistentValueInteger);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    persistentValueInteger = [userDefaults integerForKey:@"persistentValue"];
    
    NSLog(@"persistentValueInteger = %d", persistentValueInteger);
    ++persistentValueInteger;
    [userDefaults setInteger:persistentValueInteger forKey:@"persistentValue"];
    
    [userDefaults synchronize];

    
    /*  Property List
     
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"persistentArray.plist"];
    NSMutableDictionary *persistentDic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if (persistentDic)
        persistentValueInteger = [[persistentDic objectForKey:@"persistentValue"] intValue];
    else
        persistentDic = [[NSMutableDictionary alloc] init];
    
    NSLog(@"persistentValueInteger = %d", persistentValueInteger);
    ++persistentValueInteger;
    [persistentDic setObject:[NSNumber numberWithInt:persistentValueInteger] forKey:@"persistentValue"];
    [persistentDic writeToFile:filePath atomically:YES];
     */
    
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
