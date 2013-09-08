//
//  ExtendablePalletView.h
//  SlideIn
//
//  Created by 國居 貴浩 on 11/10/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pallet;      //  Pallet.hをimportせずに宣言にとどめる。
@class ExtendablePalletView;    //  ExtendablePalletViewDelegateで使うので先に宣言。

@protocol  ExtendablePalletViewDelegate<NSObject>
- (int)palletviewEditorCount:(ExtendablePalletView*)palletview;
- (UIView*)palletview:(ExtendablePalletView*)palletview editorFrame:(CGRect)frame atIndex:(int)index;
@end

@interface ExtendablePalletView : UIView {
    UIView* setupview;      //  現在の色パッチ編集画面アイテム。
    int curtIndex;          //  現在の色パッチ編集画面アイテム番号。
    id<ExtendablePalletViewDelegate>  delegate;   //  ExtendablePalletViewDelegateを採用したidを使う。
}

@property (readonly) Pallet* palletView;
- (void)addTarget:(id)target action:(SEL)action;
- (void)setDelegate:(id<ExtendablePalletViewDelegate>)delegate;   //  ExtendablePalletViewDelegateを採用したidを使う。
@end
