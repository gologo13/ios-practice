//
//  Button.h
//  TargetAction
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    buttonEvent_Touched = 0,
    buttonEvent_MovedOut,
    buttonEvent_MoveIn,
    buttonEvent_TouchUpInside
};

@interface Button : UIView
{
    NSMutableDictionary *targetAndActionDic;
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;

@end
