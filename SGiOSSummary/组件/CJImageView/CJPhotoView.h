//
//  CJPhotoView.h
//  CraftsMan
//
//  Created by lisaike on 15/3/6.
//  Copyright (c) 2015年 Pobing Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJPhotoView;

@protocol CJPhotoViewDelegate <NSObject>

/**
 *  单击图片
 */
- (void)singleTouchEvent:(CJPhotoView*)photoView;

/**
 *  双击图片
 */
- (void)doubleTouchEvent:(CJPhotoView*)photoView;

/**
 *  缩放
 */
- (void)photoViewDidZoom:(CJPhotoView *)photoView;

@end

@interface CJPhotoView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic, strong, readonly) UIImageView* imageView;
@property(nonatomic, weak  ) id<CJPhotoViewDelegate> touchEventDelegate;

- (void)setImage:(UIImage *)image;

@end
