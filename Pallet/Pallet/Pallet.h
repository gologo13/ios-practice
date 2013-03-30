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

@interface Pallet : UIView
{
    TargetActionHandler *handler;
    Indicator *indicator;
    UIView *selectedView;
    UIView *lastView;
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
- (UIColor*)selectedColor;
@end
