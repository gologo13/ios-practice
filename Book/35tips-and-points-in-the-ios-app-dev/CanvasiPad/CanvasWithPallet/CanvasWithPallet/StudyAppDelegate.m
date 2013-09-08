//
//  StudyAppDelegate.m
//  CanvasWithPallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyAppDelegate.h"
#import "CanvasView.h"
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
            slider.tag = tag;   //  1:色相用、2:彩度用、3:明度用。
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
    slider = (UISlider*)[view viewWithTag:1];   //  色相
    float hue = slider.value;
    slider = (UISlider*)[view viewWithTag:2];   //  彩度
    float saturation = slider.value;
    slider = (UISlider*)[view viewWithTag:3];   //  明度
    float brightness = slider.value;
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    [slideInView.palletView setSelectedColor:color];    //  色パッチの色変更
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
    UIColor* color = [UIColor colorWithHue:slider.value saturation:1.0 brightness:1.0 alpha:1.0];
    [slideInView.palletView setSelectedColor:color];    //  色パッチの色変更
}
@end

@implementation StudyAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [mainView release]; //  所有権放棄
    [_window release];
    [super dealloc];
}

//  Documents/imagesディレクトリのパスを返す。
- (NSString*)imageDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* imageDir = [documentsDirectory stringByAppendingPathComponent:@"images"];
    return imageDir;
}

/*
 新しいファイル名の生成
 */
- (NSString*)nameNow
{
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString* imageDir = [self imageDir];
    for (int i = 0; i < 5; i++) {
        NSString* name = [formatter stringFromDate:[NSDate date]];
        NSString* path;
        for (int num = 0; num < 1000; num++) {
            NSString* componentName = [NSString stringWithFormat:@"%@_%05d.png",name, num];
            path = [imageDir stringByAppendingPathComponent:componentName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
                return componentName;
            }
        }
    }
    return nil;
}

/*
    imageNamesの作成。
 */
- (void)initImageNames
{
    NSString* imageDir = [self imageDir];
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:&error];
    NSArray* list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
    list = [list sortedArrayUsingSelector:@selector(compare:)];
    imageNames = [list mutableCopy];
    if ([imageNames count] == 0) {
        //  画像ファイルが1つもない。
        NSString* imageName = [self nameNow];   //  新しいファイル名をもらう
        NSString* filePath = [[self imageDir] stringByAppendingPathComponent:imageName];
        //  ダミー画像
        UIGraphicsBeginImageContext(CGSizeMake(0, 0));
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData* imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:filePath atomically:NO];        
        [imageNames addObject:imageName];      //  新しいファイル名を末尾に追加
    }
}

/*
 指定されたインディックスのファイルを読み込んでUIImageを返す。
 */
- (UIImage*)loadImageAtIndex:(int)index
{
    NSString* imageName = [imageNames objectAtIndex:index];
    return [UIImage imageWithContentsOfFile:[[self imageDir] stringByAppendingPathComponent:imageName]];
}

/*
 渡されたUIImageを、指定されたインディックスのファイルに書き出す。
 */
- (void)saveImage:(UIImage*)image index:(int)index
{
    NSString* imageName = [imageNames objectAtIndex:index];
    NSString* filePath = [[self imageDir] stringByAppendingPathComponent:imageName];
    NSData* imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
}

/*
 指定されたインディックスのファイルを削除する。
*/
- (void)removeImageAtIndex:(int)index
{
    NSString* imageName = [imageNames objectAtIndex:index];
    NSString* filePath = [[self imageDir] stringByAppendingPathComponent:imageName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    [imageNames removeObjectAtIndex:index];
}

/*
 ツールバーのrewinditemボタン、forwardボタンの使用可能/不可能調整。
 */
- (void)adjustToolbarButtons
{
    rewinditem.enabled = (curtImageIndex > 0);
    forwarditem.enabled = (curtImageIndex < ([imageNames count] - 1));
}

/*
    現在の画像で元ファイルを更新してから、新しいファイルを追加し、そのファイルの画像を表示する。
 */
- (void)copyImage
{
    [self saveImage:canvasview.image index:curtImageIndex]; //  現在の状態に更新。
    NSString* imageName = [self nameNow];   //  新しいファイル名をもらう
    [imageNames addObject:imageName];      //  新しいファイル名を末尾に追加
    curtImageIndex = [imageNames count] - 1;
    [self saveImage:canvasview.image index:curtImageIndex];
    [self adjustToolbarButtons];
}


#define HANDLE_WIDTH 16     //  把手の幅
#define PALLET_WIDTH 44     //  パレットの幅
#define SLIDIN_WIDTH 300    //  slideInViewの幅
#define TOOLBA_HEIGHT 44    //  ツールバーの高さ

//  ツールバーの準備
- (void)initToolbar
{
    //  ディスプレイ上部にツールバー追加。
    CGRect r = mainView.bounds;
    CGRect toolbarFrame = r;
    toolbarFrame.size.height = TOOLBA_HEIGHT;
    UIToolbar* toolBar = [[[UIToolbar alloc] initWithFrame:toolbarFrame]autorelease];
    [mainView addSubview:toolBar];
    
    //  アクションボタンを作成。
    UIBarButtonItem* actionitem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                               target:self action:@selector(selectAction)]autorelease];
    actionitem.tag = 1;   //  タグ1設定
    
    //  自動調整幅
    UIBarButtonItem* flexspace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]autorelease];
    
    //  巻き戻しボタンを作成。
    rewinditem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind 
                                                                target:self action:@selector(changeCanvasImage:)]autorelease];
    rewinditem.tag = 2;   //  タグ2設定
    
    //  固定幅
    UIBarButtonItem* fixspace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]autorelease];
    fixspace.width = 50;
    
    //  早送りボタンを作成。
    forwarditem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward 
                                                                 target:self action:@selector(changeCanvasImage:)]autorelease];
    forwarditem.tag = 3;   //  タグ3設定
    
    //  自動調整幅
    UIBarButtonItem* flexspace2 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]autorelease];
    
    //  ツールバーに設定。
    toolBar.items = [NSArray arrayWithObjects:actionitem, flexspace, rewinditem, fixspace, forwarditem, flexspace2, nil];
}

//  キャンバス、パレットの準備
- (void)initCanvas
{
    CGRect r = mainView.bounds;
    r.origin.y += TOOLBA_HEIGHT;
    r.size.width -= (HANDLE_WIDTH + PALLET_WIDTH);
    canvasview = [[[CanvasView alloc] initWithFrame:r] autorelease];
    [mainView addSubview:canvasview];
    r = CGRectOffset(r, r.size.width, 0);

    r.size.width = SLIDIN_WIDTH;     //  横幅は従来どおり
    slideInView = [[[ExtendablePalletView alloc] initWithFrame:r] autorelease];
    [slideInView addTarget:self action:@selector(showhide)];    
    [slideInView.palletView setTarget:self action:@selector(palletActionValueChanged:) forEvent:PalletEvent_ValueChanged];
    [slideInView setDelegate:self];
    
    [canvasview setPenColor:slideInView.palletView.selectedColor];    //  パレットの選択とシンクロさせる。
    [mainView addSubview:slideInView];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    //  mainView作成。autoreleaseしない。
    mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.window addSubview:mainView];
    
    [self initToolbar];
    [self initCanvas];    
    [self initImageNames];
    //  画像ファイル群の末尾の画像を選んで表示する。
    curtImageIndex = [imageNames count] - 1;
    canvasview.image = [self loadImageAtIndex:curtImageIndex];    
    [self adjustToolbarButtons];
    
    [self.window makeKeyAndVisible];
    return YES;
}

//  パレットの色パッチの色が変わったので、キャンバスも変更する。
-(void)palletActionValueChanged:(Pallet*)sender
{
    canvasview.penColor = [sender selectedColor];    
}

//  表示する画像ファイルを変更する。
-(void)changeCanvasImage:(UIBarButtonItem*)sender
{
    int direction = (sender.tag == 2)?-1:1;
    int index = curtImageIndex + direction;
    if (index < 0)
        return;
    if (index > ([imageNames count] - 1))
        return;
    [self saveImage:canvasview.image index:curtImageIndex];
    curtImageIndex = index;
    canvasview.image = [self loadImageAtIndex:curtImageIndex];
    [self adjustToolbarButtons];
}

-(void)showhide
{
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

-(int)palletviewEditorCount:(ExtendablePalletView*)palletView
{
    return 2;   //  2つの色パッチ編集画面アイテムを持つ。
}

- (UIView*)palletview:(ExtendablePalletView*)palletView editorFrame:(CGRect)frame atIndex:(int)index;
{
    if (index == 0) {
        //  indexが0なら色相単独。
        HueSlider* baseView = [[[HueSlider alloc] initWithFrame:frame] autorelease]; //  こちらでは所有しない。
        baseView.slideInView = slideInView; //  slideInViewをプロパティ経由で渡す。
        return baseView;
    }
    //  それ以外なら色相、彩度、明度。
    HSBSlider* baseView = [[[HSBSlider alloc] initWithFrame:frame] autorelease]; //  こちらでは所有しない。
    baseView.slideInView = slideInView; //  slideInViewをプロパティ経由で渡す。
    return baseView;
}

//  切り替え画面を引数で受け取るようにした。
- (void)flip:(UIView*)frontsideView backsideView:(UIView*)backsideView
{
    UIView* fromView = frontsideView;
    UIView* toView = backsideView;
    if (backsideView.superview) {
        toView = frontsideView;
        fromView = backsideView;
    }
    [UIView transitionFromView:fromView 
                        toView:toView 
                      duration:1 
                       options:UIViewAnimationOptionTransitionFlipFromLeft 
                    completion:nil];    //  completion:パラメータはnilに戻しました。もちろん、そのままでもかまいません。
    
}

/*
 選ばれた画像をcanvasviewに設定。
 */
- (void)thumbnailView:(ThumbnailView*)thumbnailView didSelectIndex:(int)index
{
    if (curtImageIndex != index) {
        curtImageIndex = index;
        canvasview.image = [self loadImageAtIndex:curtImageIndex];
        [self adjustToolbarButtons];
    }
    [self flip:thumbnailView backsideView:mainView];
    [thumbnailView autorelease];    //  この呼び出しの後、解放されるようにする。
}

/*
 humbnailView用NSArray作成。
 */
- (NSArray*)thumbs
{
    NSMutableArray* thumbs = [NSMutableArray array];
    NSString* dirPath = [self imageDir];
    for (NSString* name in imageNames) {
        NSString* path = [dirPath stringByAppendingPathComponent:name];
        [thumbs addObject:path];
    }
    return thumbs;
}

/*
 毎回ThumbnailViewを作成。ここではautoreleaseしない。
 */
- (void)selectThumbnail
{
    [self saveImage:canvasview.image index:curtImageIndex];    
    ThumbnailView* thumbnailView = [[ThumbnailView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [thumbnailView setThumbnails:[self thumbs]];
    thumbnailView.thumbnailDelegate = self;
    [self flip:mainView backsideView:thumbnailView];
}

/*
 表示中の画像のファイルを削除する。
 */
- (void)deleteFile
{
    if ([imageNames count] > 1) {
        //  現在表示中の画像のファイルを削除する。
        [self removeImageAtIndex:curtImageIndex];

        //  もしcurtImageIndexが末尾を越えていたら、末尾を指すように調整する。
        if (curtImageIndex >= [imageNames count]) {
            curtImageIndex = [imageNames count] - 1;
        }
        canvasview.image = [self loadImageAtIndex:curtImageIndex];
    } else {
        //  画面をクリアし、ファイルも更新。こちらのcanvasview.imageはCanvasViewのcanvasであることに注意。
        canvasview.image = nil;
        [self saveImage:canvasview.image index:curtImageIndex];
    }
    [self adjustToolbarButtons];
}

- (void)selectAction
{
    UIActionSheet* sheet = [[[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self 
                                               cancelButtonTitle:@"キャンセル" 
                                          destructiveButtonTitle:@"削除" 
                                               otherButtonTitles:@"一覧", @"コピー", nil] autorelease];
    [sheet showInView:self.window];    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self deleteFile];  //  ファイルを削除。
            break;
        case 1:
            [self selectThumbnail]; //  サムネイル一覧表示。
            break;
        case 2:
            [self copyImage];   //  複製ファイル作成。
            break;
    }
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
    [self saveImage:canvasview.image index:curtImageIndex];
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
    [self saveImage:canvasview.image index:curtImageIndex];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
