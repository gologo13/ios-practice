//
//  AppDelegate.h
//  ToolBar
//
//  Created by Yohei Yamaguchi on 2013/05/31.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIBarButtonItem *rewindItem;
    UIBarButtonItem *forwardItem;
    UIBarButtonItem *cancelItem;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) int index;

@end
