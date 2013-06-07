//
//  Pallet.h
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TargetActionHandler;

@interface Pallet : UIView {
    CALayer*    selectedLayer;  //  現在触られているCALayer
    CALayer*    lastLayer;      //  最後に触れられたCALayer
    TargetActionHandler*    handler;    //  アクションメソッド管理用。
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
- (void)setSelectedColor:(UIColor*)inColor;

//  現在触られている色パッチの色を返す。
- (UIColor*)selectedColor;
@end

enum {
    PalletEvent_Touched,            //  指が触れた
    PalletEvent_ValueChanged,       //  色が変わった
    PalletEvent_Released            //  指が離れた
};

