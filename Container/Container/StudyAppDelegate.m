//
//  StudyAppDelegate.m
//  Container
//
//  Created by Yohei Yamaguchi on 2013/04/03.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"

@implementation StudyAppDelegate

- (NSString*)arrayFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"array.plist"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.arrayFilePath];
    
    if (array == nil) {
        NSLog(@"Created for the first time.");
        NSDate *date = [NSDate date];
        NSString *text = @"hello";
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:date, @"when", text, @"name", nil];
        array = [NSMutableArray arrayWithObjects:date, text, dictionary, nil];


//        NSLog(@"array[0] = %@", [array objectAtIndex:0]);
//        NSLog(@"array[1] = %@", [array objectAtIndex:1]);
//        NSLog(@"dictionary when = %@", [dictionary objectForKey:@"when"]);
//        NSLog(@"dictionary name = %@", [dictionary objectForKey:@"name"]);
    } else {
        NSLog(@"Created from array.plist");
    }
    [array addObject:[NSDate date]];
    [array writeToFile:self.arrayFilePath atomically:YES];
    NSLog(@"array = %@", array);
    
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