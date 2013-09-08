//
//  HeartLayer.m
//  CustomLayer
//
//  Created by Yohei Yamaguchi on 2013/04/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "HeartLayer.h"

@implementation HeartLayer

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

- (void)drawHeart:(CGContextRef)ctx;
{
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0.25);
    CGContextAddCurveToPoint(ctx, 0.1, 0, 0.5, 0, 0.5, 0.3);
    CGContextAddCurveToPoint(ctx, 0.5, 0.75, 0, 0.9, 0, 0.9);
    CGContextAddCurveToPoint(ctx, 0, 0.9, -0.5, 0.75, -0.5, 0.3);
    CGContextAddCurveToPoint(ctx, -0.5, 0, -0.1, 0, 0, 0.25);
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    /*
        CGContextFillPath(ctx);
     */
    CGContextClip(ctx);
    //CGContextFillRect(ctx, CGRectMake(-0.5, 0, 0.75, 0.75));
    [self fillGradation:ctx startPoint:CGPointMake(0, 1) endPoint:CGPointMake(0, 0)];
}
    

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextTranslateCTM(ctx, self.bounds.size.width / 2.0, 0);
    CGContextScaleCTM(ctx, self.bounds.size.width, self.bounds.size.height);
    [self drawHeart:ctx];
}

@end
