//
//  TargetActionHandler.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "TargetActionHandler.h"

@interface TargetAndAction : NSObject
{
@public
    id target;
    SEL action;
}
@end
@implementation TargetAndAction
@end

@implementation TargetActionHandler

- (id)init
{
    if ((self = [super init]) != nil) {
        targetAndActionDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    TargetAndAction *ta = [[TargetAndAction alloc] init];
    ta->target = target;
    ta->action = action;
    NSString *key = [NSString stringWithFormat:@"%d", event];
    [targetAndActionDic setObject:ta forKey:key];
}

- (void)sendAction:(int)event sender:(id)sender
{
    NSString *key = [NSString stringWithFormat:@"%d", event];
    TargetAndAction *ta = [targetAndActionDic objectForKey:key];
    if (ta) {
//        NSLog(@"target: %@", [ta->target description]);
//        NSLog(@"action: %@", [ta description]);
        if ([ta->target respondsToSelector:ta->action])
            [ta->target performSelector:ta->action withObject:sender];
        else
            NSLog(@"OMG!!!");
    }
}

@end
