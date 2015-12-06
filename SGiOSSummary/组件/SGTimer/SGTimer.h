//
//  SGTimer.h
//  SGiOSSummary
//
//  Created by 刘山国 on 15/12/6.
//  Copyright © 2015年 山国. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  计时器
 */

@protocol SGTimerDelegate <NSObject>

- (void)sgTime:(NSString*)time;
- (void)sgTimerEndNotify;

@end

@interface SGTimer : NSObject


@property (nonatomic,assign) id<SGTimerDelegate>    delegate;
@property (nonatomic,copy)   NSString               *time;
@property (nonatomic,copy)   NSString               *format;
@property (nonatomic,copy)   NSString               *endDefault;
@property (nonatomic,assign) NSTimeInterval         MAX_TIME;


/**
 *  倒计时计时器初始化
 *
 *  @param maxTime    倒计时时间 默认 60s
 *  @param format     输出格式 如：@"倒计时%@s"
 *  @param endDefault 结束时显示字符串 默认 @""
 *
 *  @return SGTimer
 */
- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime;
- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime Format:(NSString*)format;
- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime Format:(NSString*)format EndDedfault:(NSString*)endDefault;

/**
 *  开始倒计时 start count down
 */
- (void)startD;

/**
 *  结束计时
 */
- (void)end;

@end
