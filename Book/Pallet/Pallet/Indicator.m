//
//  Indicator.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/31.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "Indicator.h"

@implementation Indicator

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextSetLineWidth(context, 2);
    CGContextStrokeRect(context, CGRectInset(self.bounds, 3, 3));
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 1);
    CGContextStrokeRect(context, self.bounds);
}

@end
