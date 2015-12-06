//
//  SGAlertView.h
//  SGiOSSummary
//
//  Created by 刘山国 on 15/11/14.
//  Copyright © 2015年 云葵科技. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  该AlertView，在Block中响应点击按钮
 */


@class SGAlertView;
typedef void (^SGAlertViewSelectedBlock)(NSUInteger buttonIndex, SGAlertView *alertView);

@interface SGAlertView : UIAlertView

/**
 *  弹出提示框，为swift调用准备
 *
 *  @param title             提示(默认)
 *  @param message           message
 *  @param block             block
 *  @param cancelButtonTitle 取消(默认)
 *
 *  @return SGAlertView
 */
+ (SGAlertView*)alertWitMessage:(NSString *)message
                       confirmTitle:(NSString *)confirmTitle
                   completionBlock:(SGAlertViewSelectedBlock)complete;
/**
 *  弹出提示框，为swift调用准备
 *
 *  @param title             title
 *  @param message           message
 *  @param block             block
 *  @param cancelButtonTitle cancel
 *  @param otherButtonTitles other titles
 *
 *  @return SGAlertView
 */
+ (SGAlertView*)alertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelTitle
                      confirmTitle:(NSString *)confirmTitle
                   completionBlock:(SGAlertViewSelectedBlock)complete;

/**
 *  弹出提示框
 *
 *  @param title             title
 *  @param message           message
 *  @param block             block
 *  @param cancelButtonTitle cancel
 *  @param otherButtonTitles other titles
 *
 *  @return SGAlertView
 */
+ (SGAlertView*)alertWithTitle:(NSString *)title
                 message:(NSString *)message
         completionBlock:(SGAlertViewSelectedBlock)block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...;


@end
