//
//  CJPhotoView.m
//  CraftsMan
//
//  Created by lisaike on 15/3/6.
//  Copyright (c) 2015年 Pobing Tech. All rights reserved.
//

#import "CJPhotoView.h"
#import <AVFoundation/AVFoundation.h>

@interface CJPhotoView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CJPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
        [self setMaximumZoomScale:5.0];
//        [self setShowsHorizontalScrollIndicator:NO];
//        [self setShowsVerticalScrollIndicator:NO];
        [self setDelaysContentTouches:YES];

        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_containerView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_containerView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 是否处于放大状态

- (BOOL)isZoomed
{
    return !([self zoomScale] == [self minimumZoomScale]);
}

#pragma mark - 取消缩放

- (void)turnOffZoom
{
    if ([self isZoomed])
    {
        _imageView.transform = CGAffineTransformIdentity;
        self.zoomScale = self.minimumZoomScale;
    }
}

#pragma mark - 触击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self)
    {
        if ([touch tapCount] == 2)
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self handleDoubleTap];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self)
    {
        if ([touch tapCount] == 1)
        {
            [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:0.25];
        }
    }
}

- (void)handleSingleTap
{
    if(self.touchEventDelegate && [self.touchEventDelegate respondsToSelector:@selector(singleTouchEvent:)])
    {
        [self.touchEventDelegate singleTouchEvent:self];
    }
}

- (void)handleDoubleTap
{
    if(self.touchEventDelegate && [self.touchEventDelegate respondsToSelector:@selector(doubleTouchEvent:)])
    {
        [self.touchEventDelegate doubleTouchEvent:self];
    }
}

#pragma mark - ScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if(self.touchEventDelegate && [self.touchEventDelegate respondsToSelector:@selector(photoViewDidZoom:)]
       )
    {
        [self.touchEventDelegate photoViewDidZoom:self];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"end");
}

#pragma mark - public

- (void)setImage:(UIImage *)image
{
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + 2 * CGRectGetWidth(self.imageView.bounds), CGRectGetHeight(self.bounds) + 2 * CGRectGetHeight(self.imageView.bounds));
    self.containerView.bounds = (CGRect){{0, 0}, self.contentSize};
    self.imageView.image = image;
    self.imageView.frame = AVMakeRectWithAspectRatioInsideRect(image.size, self.containerView.bounds);
    self.imageView.center = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
    self.contentOffset = CGPointMake(CGRectGetWidth(self.imageView.bounds), CGRectGetHeight(self.imageView.bounds));
}

@end
