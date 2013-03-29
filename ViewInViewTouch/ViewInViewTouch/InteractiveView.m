//
//  InteractiveView.m
//  ViewInViewTouch
//
//  Created by Yohei Yamaguchi on 2013/03/29.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "InteractiveView.h"

@implementation InteractiveView

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
    [[UIColor blackColor] setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, CGRectMake(location.x, location.y, 10, 10));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    location = pt;
    NSLog(@"touch began: location = %f %f", pt.x, pt.y);
    [self setNeedsDisplay];
}


@end
