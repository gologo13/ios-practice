//
//  StudyAppDelegate.h
//  SlideIn
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtendablePalletView.h"    //  ExtendablePalletViewDelegateを採用するので@classから変更。

@interface StudyAppDelegate : UIResponder <UIApplicationDelegate, ExtendablePalletViewDelegate> {
    ExtendablePalletView* slideInView;
}

@property (strong, nonatomic) UIWindow *window;

@end
