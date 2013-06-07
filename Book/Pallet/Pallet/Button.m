//
//  Button.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "Button.h"
#import "TargetActionHandler.h"

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        handler = [[TargetActionHandler alloc] init];
    }
    return self;
}

- (void)setTargt:(id)target action:(SEL)action forEvent:(int)event
{
    [handler sendAction:event sender:self];
}

- (void)sendAction:(int)event
{
    [handler setTarget:_target action:_action forEvent:event];
}

@end
