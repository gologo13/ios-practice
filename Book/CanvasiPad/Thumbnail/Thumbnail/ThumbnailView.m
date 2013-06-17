//
//  ThumbnailView.m
//  Thumbnail
//
//  Created by 國居 貴浩 on 11/10/20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ThumbnailView.h"

@implementation ThumbnailView
@synthesize thumbnailDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIImage*)resizeImage:(UIImage*)image size:(CGSize)size
{
    //  指定されたサイズのオフスクリーン作成。
    UIGraphicsBeginImageContext(size);
    
    //  オフスクリーンいっぱいにimageを描画。
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //  オフスクリーンからUIImage作成。
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;    
}

-(void)reloadData
{
    //  　まず、自身に貼付けられているサムネイル画面を、すべて取り外す。
    NSArray* subviews = [self.subviews copy];
    for (UIView* subview in subviews) {
        [subview removeFromSuperview];
    }
    [subviews release];

    //  -reloadDataでは画像を読み込まない。
    thumbnaileSize = self.bounds.size;
    thumbnaileSize.width /= 3;
    thumbnaileSize.height = thumbnaileSize.width;
    countInRow = self.bounds.size.width / thumbnaileSize.width;
    
    int vCount = ([_thumbnails count] + countInRow - 1) / countInRow;
    self.contentSize = CGSizeMake(self.bounds.size.width, vCount * thumbnaileSize.height);
    [self setNeedsLayout];      //  layoutSubviewsを呼び出すように指定（-setNeedsDisplayのレイアウト版）   
}

- (CGRect)thumbnailViewFrame:(int)index
{
    //  -reloadDataで計算された値を使う。
    int v = index / countInRow;
    int h = index % countInRow;
    return CGRectMake(h * thumbnaileSize.width,  v * thumbnaileSize.height, thumbnaileSize.width,thumbnaileSize.height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_thumbnails == nil) {
        return;
    }
    CGRect visibleFrame = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height);
    
    //  tagプロパティ用の番号初期化。
    int imageIndex = 0;
    for (NSString* path in _thumbnails) {
        //  _thumbnailsに収納された全ファイルパスを取り出すループ。
        CGRect frame = [self thumbnailViewFrame:imageIndex];
        if (CGRectIntersectsRect(visibleFrame, frame)) {
            //  画面に見えている。
            UIImageView* imageview = (UIImageView*)[self viewWithTag:imageIndex + 1];

            //  すでにUIImageViewとして貼られているならnil以外となる。
            if (imageview == nil) {
                //  サムネイル画面を1つ追加。
                UIImageView* imageview = [[[UIImageView alloc] initWithFrame:frame] autorelease];

                //  画像ファイルを読み込んでリサイズして設定。
                UIImage* image = [UIImage imageWithContentsOfFile:path];
                imageview.image = [self resizeImage:image size:frame.size];

                //  UIImageViewは初期状態ではNOになっているので、そのままだと-hitTest:で見つけられない。
                imageview.userInteractionEnabled = YES;

                //  サムネイルのインディックスを決定するために設定。
                imageview.tag = imageIndex + 1;
                
                [self addSubview:imageview];
            }
        } else {
            //  ディスプレイ外になったら取り外す。
            if (CGRectIntersectsRect(CGRectInset(visibleFrame, 0, -800), frame) == NO) {
                //  ただし　visibleFrameより上下どちらかが800ポイント以上、外に限る。
                UIImageView* imageview = (UIImageView*)[self viewWithTag:imageIndex + 1];
                [imageview removeFromSuperview];
            }
        }
        imageIndex++;
    }
}


//  受け取ったinThumbnailsの複製を持つ
- (void)setThumbnails:(NSArray*)inThumbnails
{
    if (_thumbnails != inThumbnails) {
        //  複製を作る。
        [_thumbnails release];
        _thumbnails = [inThumbnails copy];
    }
    
    //  _thumbnailsが設定できたら呼び出す。
    [self reloadData];
}

- (void)dealloc
{
    [_thumbnails release];      //  所有権の放棄
    [super dealloc];
}

- (void)selectImage:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  タッチされているサムネイル画面を検索。
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    UIView* view = [self hitTest:pt withEvent:event];
    
    /*
     　selectedViewと違うサムネイル画面が見つかった場合、selectedViewを更新し
     古いサムネイル画面の透明度を元に戻し、新しいサムネイル画面の透明度を50%にする。
    サムネイル画面以外のタッチならselectedViewはnilにする。
     */
    if (view != selectedView) {
        selectedView.alpha = 1.0;
        if (view == self) {
            selectedView = nil;
        } else {
            selectedView = view;
            selectedView.alpha = 0.5;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
    if (selectedView) {
        //  選択しているサムネイル画面があればデリゲートに通知する。
        [thumbnailDelegate thumbnailView:self didSelectIndex:selectedView.tag - 1];  //  tagは1から始まっているので-1する。
    }
    //  選択しているサムネイル画面の解除。
    selectedView.alpha = 1.0;
    selectedView = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  選択しているサムネイル画面の解除。
    selectedView.alpha = 1.0;
    selectedView = nil;
}
@end
