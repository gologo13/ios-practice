//
//  StudyAppDelegate.h
//  CanvasWithPallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtendablePalletView.h"
#import "ThumbnailView.h"
@class CanvasView;

@interface StudyAppDelegate : UIResponder <UIApplicationDelegate, ExtendablePalletViewDelegate,ThumbnailViewDelegate, UIActionSheetDelegate> {
    CanvasView* canvasview;
    ExtendablePalletView* slideInView;
    NSMutableArray* imageNames;
    int             curtImageIndex;
    UIBarButtonItem* rewinditem;
    UIBarButtonItem* forwarditem;
    UIView*          mainView;
}

@property (strong, nonatomic) UIWindow *window;

@end
