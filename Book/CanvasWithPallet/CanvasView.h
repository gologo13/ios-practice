//
//  CanvasView.h
//  Canvas
//
//  Created by Yohei Yamaguchi on 2013/04/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView
{
    UIImage *canvas;
    CGPoint currentPoint;
}
@property UIColor *penColor;
@property float    penWidth;
- (UIImage*)image;
- (void)setImage:(UIImage*)image;
@end
