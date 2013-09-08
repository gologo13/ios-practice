//
//  StudyAppDelegate.h
//  Thumbnail
//
//  Created by 國居 貴浩 on 11/10/20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbnailView.h"       //  ThumbnailViewDelegateを採用するのでimportする。

@interface StudyAppDelegate : UIResponder <UIApplicationDelegate, ThumbnailViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
