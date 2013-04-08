//
//  Pallet.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Pallet.h"
#import "TargetActionHandler.h"

@implementation Pallet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        handler = [[TargetActionHandler alloc] init];
        CGRect r = CGRectMake(0, 0, 44, 44);
        for (int i = 0; i < 7; ++i) {
            CALayer *bt = [CALayer layer];
            bt.frame = r;
            bt.backgroundColor = [UIColor colorWithHue:(float)i / 7.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
            [self.layer addSublayer:bt];
            r = CGRectOffset(r, 0, r.size.height);
        }
    }
    return self;
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    [handler setTarget:target action:action forEvent:event];
}

- (void)sendAction:(int)event
{
    [handler sendAction:event sender:self];
}

- (void)select:(CALayer*)layer
{
    if ((layer == self.layer || layer == nil))
        layer = lastLayer;
    if (selectedLayer == layer)
        return;
    
    selectedLayer.opacity = 1.0;
    selectedLayer = layer;
    selectedLayer.opacity = 0.5;
    [self sendAction:PalletEventValueChanged];
}

- (UIColor*)selectedColor
{
    //return selectedLayer.backgroundColor;
    if (selectedLayer)
        return [UIColor colorWithCGColor:selectedLayer.backgroundColor];
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    lastLayer = selectedLayer;
    selectedLayer = nil;
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self hitLayer:touch];
    [self select:layer];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self hitLayer:touch];
    [self select:layer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self hitLayer:touch];
    [self select:layer];
    selectedLayer.opacity = 1.0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    selectedLayer.opacity = 1.0;
}

- (CALayer*)hitLayer:(UITouch*)touch
{
    CGPoint touchPoint = [touch locationInView:self];
    touchPoint = [self.layer convertPoint:touchPoint fromLayer:self.layer.superlayer];
    return [self.layer hitTest:touchPoint];
}

@end
