//
//  UIFont+Private.h
//  SGiOSSummary
//
//  Created by 刘山国 on 15/12/6.
//  Copyright © 2015年 山国. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用自带字体
 */

@interface UIFont (Private)

/**
 *  注册并加载自带字体
 *
 *  @param size     size
 *  @param fontName 字体名，带后缀
 *
 *  @return UIFont
 */
+ (UIFont*)fontSize:(CGFloat)size FontName:(NSString*)fontName;

/**
 *  注册并加重自带字体
 *
 *  @param size     size
 *  @param fontName 字体名
 *  @param type     字体后缀
 *
 *  @return UIFont
 */
+ (UIFont*)fontWithSize:(CGFloat)size FontName:(NSString*)fontName OfType:(NSString*)type;

@end
