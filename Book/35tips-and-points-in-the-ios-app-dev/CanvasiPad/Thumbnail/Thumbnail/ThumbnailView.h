//
//  ThumbnailView.h
//  Thumbnail
//
//  Created by 國居 貴浩 on 11/10/20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThumbnailView;

//  ThumbnailViewデリゲート
@protocol ThumbnailViewDelegate<NSObject>

//  タップされたサムネイルのインディックスを通知する。
- (void)thumbnailView:(ThumbnailView*)thumbnailView didSelectIndex:(int)index;
@end

@interface ThumbnailView : UIScrollView {
    NSArray*    _thumbnails;    //  サムネイル表示する画像ファイルパスの配列
    UIView*     selectedView;   //  選択されているサムネイル
    CGSize      thumbnaileSize; //  サムネイル矩形サイズ
    int         countInRow;     //  横に何個、並ぶか
}
- (void)setThumbnails:(NSArray*)thumbnails;
@property (assign) id<ThumbnailViewDelegate> thumbnailDelegate;
@end

