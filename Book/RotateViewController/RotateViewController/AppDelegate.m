//
//  AppDelegate.m
//  RotateViewController
//
//  Created by Yohei Yamaguchi on 2013/06/18.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"


@interface HeartView : UIView
@end

@implementation HeartView

/**
 * drawRect
 */
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width / 2, 0);
    CGContextScaleCTM(context, self.bounds.size.width, self.bounds.size.height);
    [self drawHeart:context];
}

/**
 * draw a heart
 */
- (void)drawHeart:(CGContextRef)ctx
{
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0.25);
    CGContextAddCurveToPoint(ctx, 0.1, 0, 0.5, 0, 0.5, 0.3);
    CGContextAddCurveToPoint(ctx, 0.5, 0.75, 0, 0.9, 0, 0.9);
    CGContextAddCurveToPoint(ctx, 0, 0.9, -0.5, 0.75, -0.5, 0.3);
    CGContextAddCurveToPoint(ctx, -0.5, 0, -0.1, 0, 0, 0.25);
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextClip(ctx);
    [self fillGradation:ctx startPoint:CGPointMake(0, 1) endPoint:CGPointMake(0, 0)];
}

- (void)fillGradation:(CGContextRef)context
           startPoint:(CGPoint)gradientStartPoint
             endPoint:(CGPoint)gradientEndPoint
{
    UIColor *c1 = [UIColor colorWithHue:0.6 saturation:1 brightness:1 alpha:1];
    UIColor *c2 = [UIColor colorWithHue:0.6 saturation:1 brightness:0.2 alpha:1];
    NSArray *colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGFloat locations[] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace(c1.CGColor), (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, gradientStartPoint, gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

@end

@interface HeartViewController : UIViewController
@end

@implementation HeartViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.controller = [HeartViewController new];
    //self.controller.view.backgroundColor = [UIColor orangeColor];
    HeartView *heartView = [[HeartView alloc] initWithFrame:CGRectInset(self.controller.view.bounds, 44, 44)];
    heartView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.controller.view addSubview:heartView];
    self.window.rootViewController = self.controller;

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
