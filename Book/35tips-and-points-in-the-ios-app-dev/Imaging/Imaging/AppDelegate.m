//
//  AppDelegate.m
//  Imaging
//
//  Created by Yohei Yamaguchi on 2013/05/29.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"oval.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.window.bounds];
    view.image = image;
    [self.window addSubview:view];
    [self.window makeKeyAndVisible];
    /*
     画像作成
     

    UIImage *image = [self createImage:CGSizeMake(100, 100)];
    //NSData *imageData = UIImagePNGRepresentation(image);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.0);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"oval.jpg"];
    [imageData writeToFile:filePath atomically:YES];
    NSLog(@"%@", documentsDirectory);
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

- (UIImage*)createImage:(CGSize)contentsSize
{
    UIGraphicsBeginImageContext(contentsSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, contentsSize.width, contentsSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
