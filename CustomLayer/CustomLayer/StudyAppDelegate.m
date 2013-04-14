//
//  StudyAppDelegate.m
//  CustomLayer
//
//  Created by Yohei Yamaguchi on 2013/04/13.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "StudyAppDelegate.h"
#import "HeartLayer.h"

@implementation StudyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)]; // 正方形
    [self.window addSubview:view];
    
    for (int i = 0; i < 10; ++i) {
        CALayer *customLayer = [CALayer layer];
        customLayer.frame = CGRectMake(i * 15, i * 15, 100, 100);
        //customLayer.borderWidth = 1;
        customLayer.delegate = self;
        [view.layer addSublayer:customLayer];
        [customLayer setNeedsDisplay];
    }
    
    // HeartLayer
    CALayer *heartLayer = [HeartLayer layer];
    heartLayer.frame = CGRectMake(0, 0, 100, 100);
    [heartLayer setNeedsDisplay];
    [view.layer addSublayer:heartLayer];
    
    // circleLayer
    CALayer *circleLayer = [CALayer layer];
    circleLayer.frame = CGRectMake(0, 100, 100, 100);
    UIImage *image = [self createLayerImage:circleLayer.frame.size];
    circleLayer.contents = (id)image.CGImage;
    [view.layer addSublayer:circleLayer];
    
    // Gradient Layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(50, 50, 100, 100);
    UIColor *c1 = [UIColor colorWithHue:0.2 saturation:1.0 brightness:1.0 alpha:1.0];
    UIColor *c2 = [UIColor colorWithHue:0.3 saturation:1.0 brightness:1.0 alpha:0.1];
    NSArray *colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    [gradientLayer setColors:colors];
    NSArray *locations = [NSArray arrayWithObjects:@0.0, @1.0, nil];
    [gradientLayer setLocations:locations];
    [view.layer addSublayer:gradientLayer];
    
    // heart masking
    CALayer *maskLayer = [HeartLayer layer];
    maskLayer.frame = CGRectMake(0, 0, 100, 100);
    [maskLayer setNeedsDisplay];
    gradientLayer.mask = maskLayer;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIImage*)createLayerImage:(CGSize)contentsSize
{
    UIGraphicsBeginImageContext(contentsSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, contentsSize.width, contentsSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    float vTop = 0;
    float vCenter = layer.bounds.size.height / 2.0;
    float vBototom = layer.bounds.size.height;
    
    float lineHeight = layer.bounds.size.height / 3.0;
    float arrowNeckX = layer.bounds.size.width * 2.0 / 3.0;
    
    float hRight = layer.bounds.size.width;
    float v = vCenter - lineHeight / 2.0;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, v);
    CGContextAddLineToPoint(ctx, arrowNeckX, v);
    CGContextAddLineToPoint(ctx, arrowNeckX, vTop);
    CGContextAddLineToPoint(ctx, hRight, vCenter);
    CGContextAddLineToPoint(ctx, arrowNeckX, vBototom);
    v = vCenter + lineHeight / 2.0;
    CGContextAddLineToPoint(ctx, arrowNeckX, v);
    CGContextAddLineToPoint(ctx, 0, v);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
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
