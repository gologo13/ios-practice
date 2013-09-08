//
//  AppDelegate.m
//  Thumbnail
//
//  Created by Yohei Yamaguchi on 2013/06/02.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"

#define NUM_THUMBNAILS 10

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ThumbnailView *thumbnailView = [[ThumbnailView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [self.window addSubview:thumbnailView];
    [thumbnailView setThumbnails:[self thumbs]];
    thumbnailView.delegate = self;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSArray*)thumbs
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *imageDirectory = [documentDirectory stringByAppendingPathComponent:@"images"];
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDirectory
                              withIntermediateDirectories:YES
                                               attributes:0
                                                    error:nil];
    
    NSMutableArray *thumbs = [NSMutableArray array];
    for (int i = 0; i < NUM_THUMBNAILS; ++i) {
        NSString *path = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"test%02d.png", i]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
            UIImage *image = [self createImage:CGSizeMake(1000, 10000) hue:(float)i / (float)NUM_THUMBNAILS];
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:path atomically:YES];
        }
        [thumbs addObject:path];
    }
    return thumbs;
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

/*
 グラデーションでの塗りつぶし。色相をhueで受け取ってグラデーションに使う。
 */
- (void)fillGradation:(CGContextRef)context startPoint:(CGPoint)gradientStartPoint endPoint:(CGPoint)gradientEndPoint hue:(float)hue
{
    CGColorRef c1 = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1].CGColor;
    CGColorRef c2 = [UIColor colorWithHue:hue saturation:1 brightness:0.2 alpha:1].CGColor;
    NSArray* colors = [NSArray arrayWithObjects:(__bridge id)c1, (__bridge id)c2, nil];
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace(c1), (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient,
                                gradientStartPoint, gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

#pragma mark - ThumbnailViewDelegate

- (void)thumbnailView:(ThumbnailView *)thumbnailView didSelectIndex:(int)index
{
    NSLog(@"touched %d", index);
}

@end
