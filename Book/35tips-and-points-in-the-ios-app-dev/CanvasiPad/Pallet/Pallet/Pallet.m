//
//  Pallet.m
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>   //  CALayerを扱うときは必要。
#import "Pallet.h"
#import "TargetActionHandler.h" //  TargetActionHandlerを使うのでimportする。 

//  タップに反応しないカスタムCALayerクラスの定義
@interface IndicatorLayer : CALayer
@end

@implementation IndicatorLayer
- (BOOL)containsPoint:(CGPoint)thePoint
{
    return NO;
}
@end

@implementation Pallet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        handler = [[TargetActionHandler alloc] init];
        //  7つの色パッチ（Button）作成、貼付け。
        CGRect r = CGRectMake(0, 0, 44, 44);        
        for (int i = 0; i < 7; i++) {
            CALayer* bt = [CALayer layer];
            bt.frame = r;
            //  色相を変化させた色の設定。
            bt.backgroundColor = [UIColor colorWithHue:(float)i / 7.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
            [self.layer addSublayer:bt];
            //  次の位置を計算
            r = CGRectOffset(r, 0, r.size.height);
            if (i == 0) //  最初のCALayerを設定。
                selectedLayer = bt;
        }
        //  インジケータ貼付け。
        r = CGRectMake(0, 0, 44, 44);        
        indicator = [IndicatorLayer layer];
        indicator.frame =CGRectInset(r, -3, -3);
        indicator.borderWidth = 3;
        indicator.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:indicator];
    }
    return self;
}

- (void)dealloc
{
    [handler release];      //  所有権の放棄。
    [super dealloc];
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
    if ((layer == self.layer) || (layer == nil)) {
        //  Pallet自身や、見つからなかった場合は、以前のCALayerに設定。
        layer = lastLayer;
    }
    if ((layer == nil) || (selectedLayer == layer)) {
        //  変化が無いので以後の処理はしない。
        return;
    }
    selectedLayer = layer;
    indicator.frame = CGRectInset(selectedLayer.frame, -3, -3);
    [self sendAction:PalletEvent_ValueChanged];
}

- (UIColor*)selectedColor
{
    if (selectedLayer) {
        //  UIColorインスタンスを作り返している。
        return [UIColor colorWithCGColor:selectedLayer.backgroundColor];
    }
    return nil;
}

- (void)setSelectedColor:(UIColor*)inColor
{
    //  CALayerなのでCGColorプロパティを渡す。
    selectedLayer.backgroundColor = inColor.CGColor;
    [self sendAction:PalletEvent_ValueChanged];
}

- (CALayer*)hitLayer:(UITouch*)touch
{
    CGPoint touchPoint = [touch locationInView:self];
    touchPoint = [self.layer convertPoint:touchPoint toLayer:self.layer.superlayer];
    return [self.layer hitTest:touchPoint];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    lastLayer = selectedLayer;
    selectedLayer = nil;
    UITouch* touch = [touches anyObject];
    CALayer* layer = [self hitLayer:touch]; //  指が触れたCALayerを特定。
    [self select:layer];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CALayer* layer = [self hitLayer:touch]; //  指が触れたCALayerを特定。
    [self select:layer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CALayer* layer = [self hitLayer:touch]; //  指が触れたCALayerを特定。
    [self select:layer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
