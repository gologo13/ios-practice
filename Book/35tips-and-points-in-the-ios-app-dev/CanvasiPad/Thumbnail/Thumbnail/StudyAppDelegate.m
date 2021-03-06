//
//  StudyAppDelegate.m
//  Thumbnail
//
//  Created by 國居 貴浩 on 11/10/20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "ThumbnailView.h"

@implementation StudyAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

/*
 グラデーションでの塗りつぶし。色相をhueで受け取ってグラデーションに使う。
 */
- (void)fillGradation:(CGContextRef)context startPoint:(CGPoint)gradientStartPoint endPoint:(CGPoint)gradientEndPoint hue:(float)hue
{
    CGColorRef c1 = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1].CGColor;
    CGColorRef c2 = [UIColor colorWithHue:hue saturation:1 brightness:0.2 alpha:1].CGColor;
    NSArray* colors = [NSArray arrayWithObjects:(id)c1, (id)c2, nil];
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace(c1), (CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, 
                                gradientStartPoint, gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

/*
 ハートマーク作成
 */
- (UIImage*)createImage:(CGSize)contentsSize hue:(float)hue
{
    UIGraphicsBeginImageContext(contentsSize);    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //  座標系を1 x 1に変更。
    CGContextTranslateCTM(context, contentsSize.width / 2.0, 0);
    CGContextScaleCTM(context, contentsSize.width, contentsSize.height);
    
    //  1 x 1の正方形の中にハートマークを描画。
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0.25);
    CGContextAddCurveToPoint(context, 0.1, 0, 0.5, 0, 0.5, 0.3);
    CGContextAddCurveToPoint(context, 0.5, 0.75, 0, 0.9, 0, 0.9);
    CGContextAddCurveToPoint(context, 0, 0.9, -0.5, 0.75, -0.5, 0.3);
    CGContextAddCurveToPoint(context, -0.5, 0, -0.1, 0, 0, 0.25);
    CGContextClosePath(context);
    CGContextClip(context);
    
    //  グラデーションで塗りつぶす。
    [self fillGradation:context startPoint:CGPointMake(0,1) endPoint:CGPointMake(0,0) hue:hue];
    
    //  オフスクリーンからUIImage作成。
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (NSArray*)thumbs
{
#define IMAGE_COUNT 200
    //  Documents/imagesディレクトリ作成。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* imageDirectory = [documentsDirectory stringByAppendingPathComponent:@"images"];
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:0 error:nil];
    
    NSMutableArray* thumbs = [NSMutableArray array];
    for (int i = 0; i < IMAGE_COUNT; i++) {        
        //  Documents/imagesディレクトリ内をtest0.png、test1.png…と順に検索。
        NSString* path = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"test%d.png", i]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
            //  ファイルがなければ作成。色相を変化させたグラデーション背景のハートマークを1000 x 1000のPNG画像ファイルとして作成する。
            UIImage* image = [self createImage:CGSizeMake(1000, 1000) hue:(float)i / (float)IMAGE_COUNT];   
            NSData* data = UIImagePNGRepresentation(image);
            [data writeToFile:path atomically:YES];
        }
        
        //  ファイルパスを収納。
        [thumbs addObject:path];
    }
    return thumbs;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    //  ThumbnailViewを作りwindowに貼付ける。
    ThumbnailView* thumbnailView = [[[ThumbnailView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    [self.window addSubview:thumbnailView];

    //  サムネイルに表示するファイル群を用意して設定。
    [thumbnailView setThumbnails:[self thumbs]];

    //  デリゲート設定。
    thumbnailView.thumbnailDelegate = self;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)thumbnailView:(ThumbnailView*)thumbnailView didSelectIndex:(int)index
{
    printf("touched %d\n", index);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
