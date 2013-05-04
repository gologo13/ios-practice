//
//  TargetActionHandler.m
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/16.
//  Copyright (c) 2011年 TETERA. All rights reserved.
//

#import "TargetActionHandler.h"


//  ターゲットとアクションのペア。
@interface TargetAndAction : NSObject {
@public
    id  target;
    SEL action;
}
@end

@implementation TargetAndAction
@end


@implementation TargetActionHandler

- (id)init
{
    self = [super init];
    if (self) {
        //  ターゲットとアクションのペアをイベント毎に管理する辞書を作成し所有する。
        targetAndActionDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    TargetAndAction* ta = [[TargetAndAction alloc] init];
    ta->target = target;
    ta->action = action;
    //  event値からキー作成。
    NSString* key = [NSString stringWithFormat:@"%d", event];
    //  コンテナに収納。
    [targetAndActionDic setObject:ta forKey:key];
}

//  targetの指定メソッドを呼び出す。
//  自身はアクションメッセージ送信の代行なので、実際の送信者を受け取れるようsenderを追加する。
- (void)sendAction:(int)event sender:(id)sender
{
    NSString* key = [NSString stringWithFormat:@"%d", event];
    TargetAndAction* ta = [targetAndActionDic objectForKey:key];
    if (ta) {
        //  コンテナに収納されていた。
        //  targetの指定メソッドを呼び出す。withObject:にsenderを指定しているが、これが渡るのはコロン付きのメソッドのときだけ。
        [ta->target performSelector:ta->action withObject:sender];
    }
}

@end
