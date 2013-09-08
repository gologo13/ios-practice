//
//  AppDelegate.h
//  Flipflop
//
//  Created by Yohei Yamaguchi on 2013/06/10.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbnailView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,ThumbnailViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *frontView;
@property (strong, nonatomic) ThumbnailView *backView;
@property (strong, nonatomic) id<ThumbnailViewDelegate> delegate;

@end
