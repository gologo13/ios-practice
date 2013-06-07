//
//  Slider.h
//  Slider
//
//  Created by Yohei Yamaguchi on 2013/04/09.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CALayer;

@interface Slider : UIView
{
    CGPoint startLocation;
    CALayer *thumb;
    UILabel *messageLabel;
}
@property (readonly) UILabel *messagLabel;
@end
