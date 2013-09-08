//
//  CanvasView.m
//  Canvas
//
//  Created by 國居 貴浩 on 11/10/16.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView
@synthesize penColor, penWidth;     //  合成

- (void)canvasImage:(CGPoint)newPt  //  戻り値をvoidにし、線の到達点を受け取るように変更。
{
    //  CanvasView全体の矩形サイズを指定。
    UIGraphicsBeginImageContext(self.bounds.size);

    //  新しいオフスクリーンを真っ黒に初期化。
    UIRectFill(self.bounds);
    
    //  古いオフスクリーンを今のオフスクリーンに再現。
    [canvas drawAtPoint:CGPointZero];
    //  線の色指定。
    [penColor set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //  線の太さ指定。
    CGContextSetLineWidth(context, penWidth);
    //  線を引く。
    CGContextMoveToPoint(context, curtPt.x, curtPt.y);
    CGContextAddLineToPoint(context, newPt.x, newPt.y);
    CGContextStrokePath(context);
    
    //  以前のcanvasの所有権を放棄。
    [canvas release];
    canvas = UIGraphicsGetImageFromCurrentImageContext();
    
    //  新しいcanvasを所有。
    [canvas retain];
    UIGraphicsEndImageContext();
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  線の太さ：3　色：シアン
        penWidth = 3;
        self.penColor = [UIColor redColor];    //  所有権確保の作業（retain）をドット構文で簡略化した。
    }
    return self;
}

- (void)dealloc
{
    [penColor release]; //  所有権の放棄。
    [canvas release];   //  所有権の放棄。
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    [canvas drawAtPoint:CGPointMake(0, 0)];    //  オフスクリーンを描画。
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    curtPt = [touch locationInView:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint newPt = [touch locationInView:self];
    
    //  ここで毎回canvasを作成し入れ替える。
    [self canvasImage:newPt];
    [self setNeedsDisplay];
    curtPt = newPt;
}
- (void)touchesEnd:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{    
}


- (UIImage*)image
{
    return canvas;
}

- (void)setImage:(UIImage *)image
{
    if (canvas == image) {
        return;
    }
    UIGraphicsBeginImageContext(self.bounds.size);
    //  最初にオフスクリーンを真っ黒に塗りつぶす。
    UIRectFill(self.bounds);

    //  もらった画像を描画。
    [image drawAtPoint:CGPointZero];

    //  新しいオフスクリーンに更新。
    [canvas release];
    canvas = UIGraphicsGetImageFromCurrentImageContext();
    [canvas retain];
    
    UIGraphicsEndImageContext();
    
    //  再表示依頼。
    [self setNeedsDisplay];
}
@end
