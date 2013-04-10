//
//  Slider.m
//  Slider
//
//  Created by Yohei Yamaguchi on 2013/04/09.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Slider.h"

@implementation Slider

@synthesize messagLabel;

// 独自に View を作成する場合、作成する場所と形をイメージする
// → bounds, frame の意味がわかってくる

// 引数 frame は View 自体の大きさを指定する
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect labelFrame = self.bounds; // 自分自身のローカル座標系
        messageLabel = [[UILabel alloc] initWithFrame:labelFrame];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = @"Message";
        messageLabel.alpha = 0.0;
        [self addSubview:messageLabel];
        
        // width:44, height:Slider自体の高さ
        CGRect thumbFrame = CGRectMake(0, 0, 44, self.bounds.size.height);
        thumb = [CALayer layer];
        thumb.borderWidth = 1;
        thumb.cornerRadius = thumbFrame.size.height / 2;
        thumb.backgroundColor = [UIColor whiteColor].CGColor;
        thumb.frame = thumbFrame;
        [self.layer addSublayer:thumb];
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = self.bounds.size.height / 2;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startLocation = [touch locationInView:self]; // 引数で渡されたViewの中での座標を返す
    [UIView animateWithDuration: 1.0
        animations: ^(void) {
            messageLabel.alpha = 1.0;
    }];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    if (!CGRectContainsPoint(CGRectInset(self.bounds, 0, 0), location)) {
        [self returnOriginalLocation];
        return;
    }
    float offset = location.x - startLocation.x;
    
    [CATransaction begin];
    //[CATransaction setAnimationDuration:2];
    [CATransaction setDisableActions:YES];
    thumb.frame = [self calculateThumbFrame: offset];
    [CATransaction commit];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self returnOriginalLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // bad example:
    // [self returnOriginalLocation];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    float offset = location.x - startLocation.x;
    CGRect thumbFrame = [self calculateThumbFrame:offset]; // 離した直後のthumbの座標系
    if ((thumbFrame.origin.x + thumbFrame.size.width) == (self.bounds.origin.x + self.bounds.size.width)) {
        thumb.frame = thumbFrame;
    } else {
        [self returnOriginalLocation];
    }
}

- (void)returnOriginalLocation
{
    CGRect thumbFrame = thumb.frame;
    thumbFrame.origin.x = self.bounds.origin.x;
    thumb.frame = thumbFrame;
    [UIView animateWithDuration:1.0 animations:^(void){
        messageLabel.alpha = 0.0;
    }];
}

- (CGRect)calculateThumbFrame:(float)offset
{
    CGRect thumbFrame = thumb.frame;
    thumbFrame.origin.x = offset + self.bounds.origin.x; // global 座標系を求めている
    
    if (thumbFrame.origin.x < self.bounds.origin.x) { // thumb が slider より左にいってしまった
        thumbFrame.origin.x = self.bounds.origin.x;
    }
    if ((thumbFrame.origin.x + thumbFrame.size.width) > (self.bounds.origin.x + self.bounds.size.width)) {
        thumbFrame.origin.x = (self.bounds.origin.x + self.bounds.size.width) - thumbFrame.size.width;
    }
    return thumbFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
