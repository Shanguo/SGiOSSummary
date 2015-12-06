//
//  SGTimer.m
//  SGiOSSummary
//
//  Created by 刘山国 on 15/12/6.
//  Copyright © 2015年 山国. All rights reserved.
//

#import "SGTimer.h"

@interface SGTimer()
@property (nonatomic,strong) NSTimer        *timer;
@property (nonatomic,copy)   NSDate         *startDate;
@property (nonatomic,assign) BOOL           isTimering;
@end

@implementation SGTimer

#define mark - 默认初始化
- (instancetype)init
{
    return [super init];
}

#pragma mark - 倒计时
#pragma mark     --    倒计时初始化
- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime
{
    return [self initWithMaxTime:maxTime Format:nil];
}

- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime Format:(NSString*)format
{
    return [self initWithMaxTime:maxTime Format:format EndDedfault:nil];
}

- (instancetype)initWithMaxTime:(NSTimeInterval)maxTime Format:(NSString*)format EndDedfault:(NSString*)endDefault
{
    self = [super init];
    if (self) {
        self.MAX_TIME   = maxTime<=0 ? 60         : maxTime;
        self.format     = format     ? format     : @"%@";
        self.endDefault = endDefault ? endDefault : @"";
    }
    return self;
}

#pragma mark    --    倒计时方法
- (void)startD{
    if (self.isTimering) [self end];
    self.isTimering= YES;
    self.startDate = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    [self.timer fire];
}
- (void)end{
    self.isTimering = NO;
    self.timer = nil;
}

- (NSString*)time{
    if (self.isTimering) {
        NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:self.startDate];
        
        NSTimeInterval timeLeft = self.MAX_TIME - timeDiff;
        if (timeLeft<0) [self end];
        NSString *str = [NSString stringWithFormat:@"%.f",timeLeft];
        if (timeLeft<0) {
            _time = self.endDefault;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(sgTimerEndNotify)]) [self.delegate sgTimerEndNotify];
            [self end];
        }else{
            _time = [NSString stringWithFormat:self.format,str];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sgTime:)]) [self.delegate sgTime:_time];

    return _time;
}
@end
