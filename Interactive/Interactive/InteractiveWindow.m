//
//  InteractiveWindow.m
//  Interactive
//
//  Created by Yohei Yamaguchi on 2013/03/25.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "InteractiveWindow.h"

@implementation InteractiveWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor yellowColor] setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, CGRectMake(location.x, location.y, 10, 10));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    NSLog(@"touch began: location = %f %f", pt.x, pt.y);
    
    location = pt;
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    NSLog(@"touch moved: location = %f %f", pt.x, pt.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    NSLog(@"touch ended: location = %f %f", pt.x, pt.y);
}

@end
