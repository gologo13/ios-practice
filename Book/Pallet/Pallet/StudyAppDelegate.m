//
//  StudyAppDelegate.m
//  Pallet
//
//  Created by Yohei Yamaguchi on 2013/03/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "Pallet.h"

@implementation StudyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CGRect r = CGRectMake(100, 100, 44, 44);
    indicator = [[UIView alloc] initWithFrame:r];
    indicator.backgroundColor = [UIColor blackColor];
    [self.window addSubview:indicator];
    r.origin.x += 50;
    r.size.height = 44 * 7;
    
    Pallet *pallet = [[Pallet alloc] initWithFrame:r];
    [pallet setTarget:self action:@selector(palletActionStart:)        forEvent:PalletEventTouched];
    [pallet setTarget:self action:@selector(palletActionValueChanged:) forEvent:PalletEventValueChanged];
    [pallet setTarget:self action:@selector(palletActionEnd:)          forEvent:PalletEventReleased];
    [self.window addSubview:pallet];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)palletActionStart:(Pallet*)sender
{
    NSLog(@"%@", [sender selectedColor]);
    indicator.backgroundColor = [sender selectedColor];
}

- (void)palletActionValueChanged:(Pallet*)sender
{
    indicator.backgroundColor = [sender selectedColor];
}

- (void)palletActionEnd:(Pallet*)sender
{
    
}

@end
