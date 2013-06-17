//
//  ExtendablePalletView.m
//  SlideIn
//
//  Created by 國居 貴浩 on 11/10/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ExtendablePalletView.h"
#import "Pallet.h"

@implementation ExtendablePalletView
@synthesize palletView; //  @propertyの合成。

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];

        //  Palletを作成し入れ子にする。
        palletView = [[[Pallet alloc] initWithFrame:CGRectMake(20, 10, 44, 320)] autorelease];
        [self addSubview:palletView];

        //  把手を作成し入れ子にする。
        UIView* handle = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 340)] autorelease];
        //  -addTarget:action:メソッドで探すためtagプロパティを設定。
        handle.tag = 1000;
        [self addSubview:handle];

        //  UITapGestureRecognizerを作成し把手に設定。
        UITapGestureRecognizer* tapGestureRecognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
        [handle addGestureRecognizer:tapGestureRecognizer];

        //  切り替えボタン追加
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(80, 290, 200, 30);
        [button setTitle:@"切り替え" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(nextSetupView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}


- (void)addTarget:(id)target action:(SEL)action
{
    UIView* handle = [self viewWithTag:1000];   //  把手のUIViewを探す。
    UITapGestureRecognizer* tapGestureRecognizer = (UITapGestureRecognizer*)[handle.gestureRecognizers objectAtIndex:0];
    [tapGestureRecognizer addTarget:target action:action];
}

- (void)nextSetupView
{
    [setupview removeFromSuperview];    //  現在の編集画面をとりはずす。
    //  次の番号を決定。
    curtIndex++;
    if (curtIndex >= [delegate palletviewEditorCount:self])
        curtIndex = 0;
    setupview = [delegate palletview:self editorFrame:CGRectMake(80, 10, 200, 280) atIndex:curtIndex];
    //  新しい編集画面を貼付ける。
    [self addSubview:setupview];
}


- (void)setDelegate:(id)inDelegate  //  delegateだと、インスタンス変数側か引数側かわからないのでinDelegateとした。
                                    //  よく使われるのはインスタンス変数側を_delegateというように命名する方法。
{
    delegate = inDelegate;
    curtIndex = 0;                  //  番号を0に初期化
    setupview = [delegate palletview:self editorFrame:CGRectMake(80, 10, 200, 280) atIndex:curtIndex];
    [self addSubview:setupview];
}
@end
