//
//  TargetActionHandler.h
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetActionHandler : NSObject
{
    NSMutableDictionary *targetAndActionDic;
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
- (void)sendAction:(int)event sender:(id)sender;
@end
