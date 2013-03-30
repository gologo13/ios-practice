//
//  Button.m
//  TargetAction
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "Button.h"

@interface TargetAndAction : NSObject
{
@public
    id target;
    SEL action;
}
@end

@implementation TargetAndAction
@end

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [targetAndActionDic setObject:target forKey:key];
}

- (void)sendAction:(int)event
{
    NSString *key = [NSString stringWithFormat:@"%d", event];
    TargetAndAction *ta = [targetAndActionDic objectForKey:key];
    if (ta) {
        [ta->target performSelector:ta->action withObject:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    [self sendAction:buttonEvent_Touched];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    float alpha = 1.0;
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(self.bounds, [touch locationInView:self]))
        alpha = 0.5;
    
    if (self.alpha != alpha) {
        self.alpha = alpha;
        [self sendAction:(alpha == 1.0) ? buttonEvent_MovedOut : buttonEvent_MoveIn];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0;
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(self.bounds, [touch locationInView:self]))
        [self sendAction:buttonEvent_TouchUpInside];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0;
    [self sendAction:buttonEvent_MovedOut];
}

@end
