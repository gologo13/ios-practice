//
//  HeartView.m
//  Rotate
//
//  Created by Yohei Yamaguchi on 2013/06/16.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import <QuartzCore/CoreAnimation.h>

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
- (void)drawDeart:(CGContextRef)ctx
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

@end
