//
//  ViewController.m
//  SGiOSSummary
//
//  Created by 刘山国 on 15/12/5.
//  Copyright © 2015年 山国. All rights reserved.
//

#import "ViewController.h"
#import "SGTextView.h"
//#import "UIButton+YK.h"
#import "SGTimer.h"
//#import "UIView+Category.h"

@interface ViewController ()<SGTimerDelegate>

@property (nonatomic,strong) SGTextView *textView;
@property (nonatomic,strong) UIButton *countBtn;
@property (nonatomic,strong) SGTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.countBtn];
}


#pragma mark - delegates and actions

#pragma mark    --   delegates
-(void)sgTime:(NSString *)time{
    [self.countBtn title:time];
}

-(void)sgTimerEndNotify{
    
}

#pragma mark - getter

-(SGTextView *)textView{
    if (!_textView) {
        _textView = [[SGTextView alloc] initWithFrame:CGRectMake(30, 80, 200, 100)];
        _textView.placeholder = @"哈哈";
    }
    return _textView;
}

-(UIButton *)countBtn{
    if (!_countBtn) {
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(minXOf(self.textView), maxYOf(self.textView)+20, 120, 20)];
        [_countBtn title:@"开始"];
        [_countBtn setBorder:[UIColor lightGrayColor] With:1];
        [_countBtn setCircleRadius:5];
        [_countBtn addTarget:self.timer Listener:@selector(startD)];
    }
    return _countBtn;
}

-(SGTimer *)timer{
    if (!_timer) {
        _timer = [[SGTimer alloc]initWithMaxTime:10];
        _timer.delegate = self;
    }
    return _timer;
}

@end
