//
//  CanvasView.h
//  Canvas
//
//  Created by 國居 貴浩 on 11/10/16.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView {
    UIImage*    canvas; //  オフスクリーン保持用。
    CGPoint     curtPt; //  線の開始点。
}
@property (retain) UIColor* penColor;
@property (assign) float penWidth;

//  現在のオフスクリーンをUIImageとして返す。
- (UIImage*)image;

//  UIImageを現在のオフスクリーンに描き出す。
- (void)setImage:(UIImage *)image;
@end
