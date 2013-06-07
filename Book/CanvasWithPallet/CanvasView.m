//
//  CanvasView.m
//  Canvas
//
//  Created by Yohei Yamaguchi on 2013/04/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _penWidth = 3;
        _penColor = [UIColor redColor];
    }
    return self;
}

- (void)canvasImage:(CGPoint)newPoint
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    UIRectFill(self.bounds);
    [canvas drawAtPoint:CGPointZero];
    [_penColor set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _penWidth);
    CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
    CGContextAddLineToPoint(context, newPoint.x, newPoint.y);
    CGContextStrokePath(context);
    
    canvas = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

- (void)drawRect:(CGRect)rect
{
    //canvas = [self canvasImage];
    //[canvas drawInRect:self.bounds];
    [canvas drawAtPoint:CGPointMake(0, 0)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    currentPoint = [touch locationInView:self];
    NSLog(@"currentPoint = (%f, %f)", currentPoint.x, currentPoint.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint nextPoint = [touch locationInView:self];

    [self canvasImage:nextPoint];
    [self setNeedsDisplay];
    
    currentPoint = nextPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (UIImage*)image
{
    return canvas;
}

- (void)setImage:(UIImage *)image
{
    if (canvas == image)
        return;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    UIRectFill(self.bounds);
    [image drawAtPoint:CGPointZero];
    canvas = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setNeedsDisplay];
}

@end
