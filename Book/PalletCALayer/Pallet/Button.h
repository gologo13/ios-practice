//
//  Button.h
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TargetActionHandler;

@interface Button : UIView
{
    TargetActionHandler *handler;
}
@property id target;
@property SEL action;
- (void)sendAction:(int)event;
- (void)setTargt:(id)target action:(SEL)action forEvent:(int)event;

@end
