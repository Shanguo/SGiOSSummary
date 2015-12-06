//
//  UILabel+Timer.m
//  ToingiOS
//
//  Created by 刘山国 on 15/11/16.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "UILabel+CountDownTimer.h"



@implementation UILabel (CountDownTimer)
CGFloat _MAX_TIME;
NSString *_timerStartFormatString;
NSString *_timerEndDefaultString;

NSTimer *_timer;
NSDate *_startDate;
BOOL _timeCounting;
id<UILabelDelegate> _delegate;

- (void)updateLable{
    
    if (_timeCounting) {
        NSTimeInterval timeDiff = [[[NSDate alloc] init] timeIntervalSinceDate:_startDate];
        NSTimeInterval timeLeft = _MAX_TIME - timeDiff;
        if (timeLeft<0) {
            [self endTimer];
        }
        NSString *str = [NSString stringWithFormat:@"%.f",timeLeft];
        
        if (timeLeft<0) {
            if (_timerEndDefaultString != nil) {
                self.text = _timerEndDefaultString;
            }else{
                self.text = @"";
            }
            if (_delegate && [_delegate respondsToSelector:@selector(timerEndNotify)]) {
                [_delegate timerEndNotify];
            }
        }else{
            self.text = [NSString stringWithFormat:_timerStartFormatString,str];
        }
        NSLog(@"%@",str);
    }
}

- (void)setDelegate:(id)delegate{
    _delegate = delegate;
}

- (void)startTimerWithMaxTime:(NSUInteger)maxTime StartFormat:(NSString *)format EndDefaultStr:(NSString *)defaultStr{
    _MAX_TIME = maxTime<=0 ? 60:_MAX_TIME;
    _timerStartFormatString = format ? format : @"%d";
    _timerEndDefaultString = defaultStr;
    //开启计时器
    _timeCounting= YES;
    _startDate = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLable) userInfo:nil repeats:YES];
    [_timer fire];
}
- (void)endTimer{
    _timeCounting = NO;
    _timer = nil;
}


@end
