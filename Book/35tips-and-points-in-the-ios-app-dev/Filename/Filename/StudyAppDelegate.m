//
//  StudyAppDelegate.m
//  Filename
//
//  Created by Yohei Yamaguchi on 2013/03/31.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"

@implementation StudyAppDelegate

- (void)testWithDate:(NSString*)documentDirectory
{
    NSString *imageDir = [documentDirectory stringByAppendingPathComponent:@"images"];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:&error];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss'.pg'"];
    for (int i = 0; i < 5; ++i) {
        NSString *name = [formatter stringFromDate:[NSDate date]];
        NSLog(@"name = %@", name);
        NSString *path;
        for (int num = 0; num < 1000; ++num) {
            NSString *componentName = [NSString stringWithFormat:@"%@_%05d.png", name, num];
            path = [imageDir stringByAppendingPathComponent:componentName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
                NSLog(@"path = %@", componentName);
                [[NSData data] writeToFile:path atomically:NO];
                break;
            }
        }

    }
}

- (void)testWithNumber:(NSString*)documentDirectory
{
    NSString *imageDir = [documentDirectory stringByAppendingPathComponent:@"images"];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
    NSLog(@"list images = %@", list);
    
    for (NSString *name in list) {
        if (rand() % 3 == 0) {
            NSString *path = [imageDir stringByAppendingPathComponent:name];
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            NSLog(@"removed: %@", path);
        }
    }
    
    int serialNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"serialNumber"];
    for (int i = 0; i < 10; ++i) {
        NSString *name = [NSString stringWithFormat:@"%d.png", serialNumber];
        NSLog(@"%@", name);
        NSString *imagePath = [imageDir stringByAppendingPathComponent:name];
        [[NSData data] writeToFile:imagePath atomically:YES];
        ++serialNumber;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:serialNumber forKey:@"serialNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    [self testWithDate:documentDirectory];
    
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
