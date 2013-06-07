//
//  StudyAppDelegate.h
//  CanvasWithPallet
//
//  Created by Yohei Yamaguchi on 2013/04/14.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CanvasView;

@interface StudyAppDelegate : UIResponder <UIApplicationDelegate>
{
    CanvasView *canvasView;
}

@property (strong, nonatomic) UIWindow *window;

@end
