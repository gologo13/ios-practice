//
//  Pallet.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "Pallet.h"
#import "TargetActionHandler.h"
#import "Indicator.h"

@implementation Pallet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        handler = [[TargetActionHandler alloc] init];
        CGRect r = CGRectMake(0, 0, 44, 44);
        for (int i = 0; i < 7; ++i) {
            UIView *bt = [[UIView alloc] initWithFrame:r];
            bt.backgroundColor = [UIColor colorWithHue:(float)i/7.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [self addSubview:bt];
            r = CGRectOffset(r, 0, r.size.height);
        }
        r = CGRectMake(0, 0, 44, 44);
        indicator = [[Indicator alloc] initWithFrame:CGRectInset(r, -3, -3)];
        indicator.backgroundColor = [UIColor clearColor];
        indicator.hidden = YES;
        indicator.userInteractionEnabled = NO;
        [self addSubview:indicator];
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

- (void)select:(UIView*)view
{
    if (view == self || view == nil)
        view = lastView;
    if (selectedView == view)
        return;

    /*
    selectedView.alpha = 1.0;
    selectedView = view;
    selectedView.alpha = 0.5;
     */
    selectedView = view;
    if (selectedView) {
        indicator.hidden = NO;
        indicator.frame = CGRectInset(selectedView.frame, -3, -3);
    } else {
        indicator.hidden = YES;
    }
    [self sendAction:PalletEventValueChanged];
}

- (UIColor*)selectedColor
{
    return selectedView.backgroundColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    lastView = selectedView;
    selectedView = nil;
    UITouch *touch = [touches anyObject];
    UIView *view = [self hitTest:[touch locationInView:self] withEvent:event];
    [self select:view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = [self hitTest:[touch locationInView:self] withEvent:event];
    [self select:view];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = [self hitTest:[touch locationInView:self] withEvent:event];
    [self select:view];
    selectedView.alpha = 1.0;
    indicator.hidden = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    selectedView.alpha = 1.0;
    indicator.hidden = YES;
}

@end
