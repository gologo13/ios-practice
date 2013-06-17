//
//  StudyAppDelegate.m
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "Pallet.h"

@implementation StudyAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    CGRect r = CGRectMake(100, 100, 44, 44);
    indicator = [[[UIView alloc] initWithFrame:r] autorelease];
    [self.window addSubview:indicator];
    indicator.backgroundColor = [UIColor blackColor];
    
    r.origin.x += 50;
    r.size.height = 44 * 7;
    Pallet* pallet = [[[Pallet alloc] initWithFrame:r] autorelease];
    [pallet setTarget:self action:@selector(palletActionStart:) forEvent:PalletEvent_Touched];
    [pallet setTarget:self action:@selector(palletActionValueChanged:) forEvent:PalletEvent_ValueChanged];
    [pallet setTarget:self action:@selector(palletActionEnd:) forEvent:PalletEvent_Released];
    [self.window addSubview:pallet];    
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)palletActionStart:(Pallet*)sender
{
    indicator.backgroundColor = [sender selectedColor];
}

-(void)palletActionValueChanged:(Pallet*)sender
{
    indicator.backgroundColor = [sender selectedColor];
}

-(void)palletActionEnd:(Pallet*)sender
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
