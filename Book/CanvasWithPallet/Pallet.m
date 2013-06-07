//
//  Pallet.m
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>   //  CALayerを扱うときは必要。
#import "Pallet.h"
#import "TargetActionHandler.h" //  TargetActionHandlerを使うのでimportする。 

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
        }
    }
    return self;
}

- (void)sendAction:(int)event
{
    [handler sendAction:event sender:self];
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    [handler setTarget:target action:action forEvent:event];
}

- (void)select:(CALayer*)layer
{
    if ((layer == self.layer) || (layer == nil)) {
        //  Pallet自身や、見つからなかった場合は、以前のCALayerに設定。
        layer = lastLayer;
    }
    if (selectedLayer == layer) {
        //  変化が無いので以後の処理はしない。
        return;
    }
    //  古い方の色パッチの透明度を戻し、新しい方の色パッチの透明度を0.5にする。透明度はopacityで指定する。
    selectedLayer.opacity = 1.0;
    selectedLayer = layer;
    selectedLayer.opacity = 0.5;
    //  アクション送信。
    [self sendAction:PalletEvent_ValueChanged];
}

//  現在触られているCALayerの背景色を返す。
- (UIColor*)selectedColor
{
    if (selectedLayer) {
        //  UIColorインスタンスを作り返している。
        return [UIColor colorWithCGColor:selectedLayer.backgroundColor];
    }
    return nil;
}

- (CALayer*)hitLayer:(UITouch*)touch
{
    CGPoint touchPoint = [touch locationInView:self];
    touchPoint = [self.layer convertPoint:touchPoint toLayer:self.layer.superlayer];
    return [self.layer hitTest:touchPoint];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  最後に選択されていたCALayerを記憶。
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
    //  指が放されたので選択されたCALayerの透明度を元に戻す。
    selectedLayer.opacity = 1.0;    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  キャンセルされたので選択されたCALayerの透明度を元に戻す。
    selectedLayer.opacity = 1.0;    
}
@end
