//
//  AppDelegate.m
//  Camera
//
//  Created by Yohei Yamaguchi on 2013/08/20.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@property AVAudioPlayer *audioPlayer;
@property NSInteger numShooted;
@property IBOutlet UIView *baseView;
@property IBOutlet UIButton *shutterButton;
@property IBOutlet UIImageView *imageView;
- (IBAction)pushShutter:(id)sender;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Camera" owner:self options:nil];
    
    NSLog(@"%s : %@", __PRETTY_FUNCTION__, topLevelObjects);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.baseView];
    [self setPlayer];
    [self.audioPlayer play];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setPlayer
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shutter" ofType:@"caf"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
}

- (IBAction)pushShutter:(id)sender
{
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = 0.0f;
    [self.audioPlayer play];

    NSString *path;
    ++self.numShooted;
    if (self.numShooted % 2) {
        path = [[NSBundle mainBundle] pathForResource:@"frog" ofType:@"jpg" inDirectory:@"background"];
    } else {
        path = [[NSBundle mainBundle] pathForResource:@"flower" ofType:@"jpg" inDirectory:@"background/alt"];
    }
    NSLog(@"path = %@", path);
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:path];
}

@end
