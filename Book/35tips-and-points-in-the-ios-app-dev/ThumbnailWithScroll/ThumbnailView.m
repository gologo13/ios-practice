//
//  ThumbnailView.m
//  Thumbnail
//
//  Created by Yohei Yamaguchi on 2013/06/02.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "ThumbnailView.h"

@implementation ThumbnailView

- (UIImage*)resizeImage:(UIImage*)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (void)setThumbnails:(NSArray *)thumbnails
{
    if (_thumbnails != thumbnails)
        _thumbnails = [thumbnails copy];
    [self reloadData];
}

- (void)reloadData
{
    NSArray *subviews = [self.subviews copy]; // ThumbnailView の subview たち
    for (UIView *subview in subviews) {
        [subview removeFromSuperview]; // もともと ThumbnailView 自体に所属していた UIImageView を削除する
    }
    
    self.thumbnailSize = self.bounds.size;
    [self setThumbnailSize:CGSizeMake(self.thumbnailSize.width/3, self.thumbnailSize.width/3)];
    
    self.numInRow = self.bounds.size.width / self.thumbnailSize.width;
    
    int numInCol = ([self.thumbnails count] + self.numInRow - 1) / self.numInRow;
    
    self.contentSize = CGSizeMake(self.bounds.size.width, numInCol * self.thumbnailSize.height);
    [self setNeedsLayout];
}

- (void)selectImage:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    UIView *view = [self hitTest:point withEvent:event];
    if (view != _selectedView) {
        _selectedView.alpha = 1.0; // 透明から戻す
        if (view == self) {
            _selectedView = nil;
        } else {
            _selectedView = view;
            _selectedView.alpha = 0.5;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selectedView.alpha = 1.0;
    self.selectedView = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
    // Image が選択された場合、delegate に通知
    if (self.selectedView) {
        [self.thumbnailDelegate thumbnailView:self didSelectIndex:self.selectedView.tag - 1];
    }
    self.selectedView.alpha = 1.0;
    self.selectedView = nil;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
}

- (CGRect)thumbnailViewWithIndex:(int)index
{
    CGSize thumbnailSize = self.bounds.size;
    thumbnailSize.width /= 3;
    thumbnailSize.height = thumbnailSize.width;
    
    int numInRow = self.bounds.size.width / thumbnailSize.width;
    int row = index / numInRow;
    int col = index % numInRow;

    return CGRectMake(col * thumbnailSize.width, row * thumbnailSize.height, thumbnailSize.width, thumbnailSize.height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_thumbnails == nil)
        return;
    
    CGRect visibleFrame = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height);
    
    int imageIndex = 0;
    for (NSString *path in _thumbnails) {
        CGRect frame = [self thumbnailViewWithIndex:imageIndex];
        if (CGRectIntersectsRect(visibleFrame, frame)) {
            // 指定したタグを持つsubviewを返す.誰も持っていない場合、nil を返す
            // nil が返る　＝　その image は読み込まれていない
            UIImageView *imageView = (UIImageView*)[self viewWithTag:imageIndex + 1];
            if (imageView == nil) {
                NSLog(@"Now loading thumbnail no. %d", imageIndex + 1);
                imageView = [[UIImageView alloc] initWithFrame:frame];
                imageView.image = [self resizeImage:[UIImage imageWithContentsOfFile:path] size:frame.size];
                imageView.userInteractionEnabled = YES;
                imageView.tag = imageIndex + 1;
                [self addSubview:imageView];
            } else {
                // TODO: バグってる
                // NSLog(@"removed thumbnail no. %02d from superview", imageIndex + 1);
                //[imageView removeFromSuperview];
            }
        }
        ++imageIndex;
    }
}

@end
