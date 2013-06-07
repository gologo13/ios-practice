//
//  TargetActionHandler.h
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/16.
//  Copyright (c) 2011年 TETERA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetActionHandler : NSObject {
    //  ターゲットとアクションのペアをイベント毎に管理する辞書
    NSMutableDictionary*    targetAndActionDic;
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
//  外からメッセージを送るので公開する必要がある。
- (void)sendAction:(int)event sender:(id)sender;

@end
