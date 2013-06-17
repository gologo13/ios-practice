//
//  StudyAppDelegate.m
//  SlideIn
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "ExtendablePalletView.h"
#import "Pallet.h"

@interface HSBSlider : UIView
@property (assign) ExtendablePalletView* slideInView;   //  slideInViewをプロパティ経由で受け取る。
@end

@implementation HSBSlider
@synthesize slideInView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  baseViewがselfとなり、そこにUISliderが貼られていく以外は同じ。
        //  均等に配置するための前準備。
        frame.size.height /= 3;
        frame.origin.x = 0;
        for (int tag = 1; tag <= 3; tag++) {
            UISlider* slider = [[[UISlider alloc] initWithFrame:frame] autorelease];
            [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            slider.tag = tag;    //  1:色相用、2:彩度用、3:明度用。
            [self addSubview:slider];
            frame = CGRectOffset(frame, 0, frame.size.height);
        }
    }
    return self;
}

//  3つのスライダーの値を色相、彩度、明度にして色を設定。
- (void)sliderAction:(UISlider*)slider
{
    UIView* view = slider.superview;
    slider = (UISlider*)[view viewWithTag:1];       //  色相
    float hue = slider.value;   
    slider = (UISlider*)[view viewWithTag:2];       //  彩度
    float saturation = slider.value;
    slider = (UISlider*)[view viewWithTag:3];       //  明度
    float brightness = slider.value;
    [slideInView.palletView setSelectedColor:[UIColor colorWithHue:hue 
                                                        saturation:saturation brightness:brightness alpha:1.0]];
}
@end

@interface HueSlider : UIView
@property (assign) ExtendablePalletView* slideInView;   //  slideInViewをプロパティ経由で受け取る。
@end

@implementation HueSlider
@synthesize slideInView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  UISliderは一つだが、HSBSlider同様、土台となるUIViewに貼るようにしている。
        UISlider* slider = [[[UISlider alloc] initWithFrame:self.bounds] autorelease];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
    }
    return self;
}

- (void)sliderAction:(UISlider*)slider
{
    [slideInView.palletView setSelectedColor:[UIColor colorWithHue:slider.value saturation:1.0 brightness:1.0 alpha:1.0]];
}
@end


@implementation StudyAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#define HANDLE_WIDTH 16     //  把手の幅
#define PALLET_WIDTH 44     //  パレットの幅
#define SLIDIN_WIDTH 300    //  slideInViewの幅

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    //  今回のslideInViewの高さはwindowのステータスバーをはぶいた高さ（applicationFrame.size.height）。
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    frame.origin.x = self.window.bounds.size.width - SLIDIN_WIDTH;
    frame.size.width = SLIDIN_WIDTH;     //  横幅は従来どおり

    //  ExtendablePalletViewを作成しwindowに貼付ける。
    slideInView = [[[ExtendablePalletView alloc] initWithFrame:frame] autorelease];
    [slideInView addTarget:self action:@selector(showhide)];  //    把手タップ用のターゲットアクションを設定。
    //  デリゲートとして設定。
    [slideInView setDelegate:self];    
    [self.window addSubview:slideInView];   //  windowに貼付け。
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(int)palletviewEditorCount:(ExtendablePalletView*)palletView
{
    return 2;   //  2つの色パッチ編集画面アイテムを持つ。
}

- (UIView*)palletview:(ExtendablePalletView*)palletView editorFrame:(CGRect)frame atIndex:(int)index
{
    if (index == 0) {
        //  indexが0なら色相単独。
        HueSlider* baseView = [[[HueSlider alloc] initWithFrame:frame] autorelease];    //  こちらでは所有しない。
        baseView.slideInView = slideInView; //  slideInViewをプロパティ経由で渡す。
        return baseView;
    }
    //  それ以外なら色相、彩度、明度。
    HSBSlider* baseView = [[[HSBSlider alloc] initWithFrame:frame] autorelease];    //  こちらでは所有しない。
    baseView.slideInView = slideInView; //  slideInViewをプロパティ経由で渡す。
    return baseView;
}

/*
    UITapGestureRecognizerが不要なので、引数無しにした。
 */
-(void)showhide
{
    /*
        slideInViewをインスタンス変数にせず、superviewを使い、このような取り出し方もできる。
     -(void)showhide:(UITapGestureRecognizer*)tapGestureRecognizer
     {
        UIView* handleView = tapGestureRecognizer.view; //  ジェスチャー見張りが登録されているUIViewはhandleView
        UIView* slideInView = handleView.superview;     //  handleViewの親がslideInView
            ・・・
     }
     */
    CGRect frame = slideInView.frame;
    CGFloat opendloc = self.window.bounds.size.width - slideInView.frame.size.width;
    if (frame.origin.x == opendloc) {
        frame.origin.x = self.window.bounds.size.width - (HANDLE_WIDTH + PALLET_WIDTH);
    } else {
        frame.origin.x = opendloc;
    }
    [UIView animateWithDuration:1.0 animations:^(void){
        slideInView.frame = frame;
    }];
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
