//
//  UILabel+Timer.h
//  ToingiOS
//
//  Created by 刘山国 on 15/11/16.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UILabelDelegate <NSObject>

- (void)timerEndNotify;

@end

@interface UILabel (CountDownTimer)
/**
 *  开始倒计时
 *
 *  @param maxTime    倒计时时间(s)，<=0则默认60s
 *  @param format     倒计时显示格式化，如：@"倒计时%d"
 *  @param defaultStr 倒计时结束时显示字符串
 */
- (void)setDelegate:(id)delegate;
- (void)startTimerWithMaxTime:(NSUInteger)maxTime StartFormat:(NSString*)format EndDefaultStr:(NSString*)defaultStr;
- (void)endTimer;
@end
