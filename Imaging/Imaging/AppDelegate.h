//
//  AppDelegate.h
//  Imaging
//
//  Created by Yohei Yamaguchi on 2013/05/29.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (UIImage*)createImage:(CGSize)contentsSize;

@end
