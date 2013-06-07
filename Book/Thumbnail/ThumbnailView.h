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

@interface ThumbnailView : UIView
@property (nonatomic) NSArray *thumbnails;
@property (nonatomic) UIView *selectedView;
@property (nonatomic) id<ThumbnailViewDelegate> delegate;
@end
