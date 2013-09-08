//
//  Button.h
//  TargetAction
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
@protocol ButtonProtocol <NSObject>

- (void)touched;

@end
 */

@interface Button : UIView
@property (assign) id target;
@property (assign) SEL action;
@end
