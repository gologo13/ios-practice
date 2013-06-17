//
//  Pallet.h
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TargetActionHandler;
@class CALayer;

enum {
    PalletEvent_Touched,            //  指が触れた
    PalletEvent_ValueChanged,       //  色が変わった
    PalletEvent_Released            //  指が離れた
};

@interface Pallet : UIView {
    CALayer*    selectedLayer;  //  現在触られているCALayer
    CALayer*    lastLayer;      //  最後に触れられたCALayer
    TargetActionHandler*    handler;    //  アクションメソッド管理用。
    CALayer*                indicator;  //  インジケータ
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;

//  現在選択されている色パッチの色を返す。
- (UIColor*)selectedColor;


//  現在選択されている色パッチの色を設定する。
- (void)setSelectedColor:(UIColor*)inColor;
@end
