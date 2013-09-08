//
//  ThumbnailView.h
//  Thumbnail
//
//  Created by Yohei Yamaguchi on 2013/06/02.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThumbnailView;
@protocol ThumbnailViewDelegate <NSObject>
- (void)thumbnailView:(ThumbnailView*)thumbnailView didSelectIndex:(int)index;
@end

@interface ThumbnailView : UIScrollView
@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, readwrite) CGSize thumbnailSize;
@property (nonatomic, readwrite) int numInRow;
@property (nonatomic, strong) id<ThumbnailViewDelegate> thumbnailDelegate;
@end
