//
//  SGGlobalb.h
//  ToingiOS
//
//  Created by 刘山国 on 15/10/27.
//  Copyright © 2015年 云葵科技. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SGGlobal : NSObject

/**
 * A convenient way to show a MBProgressHUD with a message and it will be removed 2s later. 
 */
void SGHud(NSString* message);
void SGHudT(NSString* message,float duringTime);
/**
 * A convenient way to show a UIAlertView with a message.
 */
UIAlertView* SGAlert(NSString* message);
UIAlertView* SGTitleAlert(NSString* title , NSString* message);

/**
 * A convenient way to limit words number of a TextField or TextView
 */
id SGWordsLimit(id textField,NSInteger maxLength);

/**
 * A convenient way to get words size
 */
CGSize SGWordsSize(NSString* text,UIFont* font);

/**
 *  根据View获文字frame，注意：view必须有text属性(UILabel,UITextView),并且text已经被赋值，font已确定
 *
 *  @param labelOrTextView 有公开属性text的View
 *
 *  @return bounds
 */
CGRect SGWordsRectWithView(id labelOrTextView);

/**
 *  SGWordsRect
 *
 *  @param width 宽度
 *  @param words words
 *  @param font  font
 *
 *  @return bounds
 */
CGRect SGWordsRect(CGFloat width,NSString* words,UIFont* font);

@end
