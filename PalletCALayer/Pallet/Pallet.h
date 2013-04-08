//
//  Pallet.h
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    PalletEventTouched = 0,
    PalletEventValueChanged,
    PalletEventReleased
};

@class TargetActionHandler;
@class Indicator;
@class CALayer;

@interface Pallet : UIView
{
    CALayer *selectedLayer;
    CALayer *lastLayer;
    TargetActionHandler *handler;
    Indicator *indicator;
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
- (UIColor*)selectedColor;
@end
