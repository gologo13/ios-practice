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
    
    CGRect frame = self.bounds;
    frame.size.width /= 3; // Thumbnailview の横サイズの1/3
    frame.size.height = frame.size.width;
    float white = 0.0;
    int i = 1;
    for (NSString *path in _thumbnails) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        image = [self resizeImage:image size:frame.size];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i++;
        [self addSubview:imageView];
        
        frame.origin.x += frame.size.width;
        
        if ((frame.origin.x + frame.size.width) > self.bounds.size.width) {
            frame.origin.x = 0;
            frame.origin.y += frame.size.height;
        }
        imageView.backgroundColor = [UIColor colorWithWhite:white alpha:1];
        
        white += 0.05;
        if (white > 1.0) {
            white = 0.0;
        }
    }
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
        [self.delegate thumbnailView:self didSelectIndex:self.selectedView.tag - 1];
    }
    self.selectedView.alpha = 1.0;
    self.selectedView = nil;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectImage:touches withEvent:event];
}

@end
