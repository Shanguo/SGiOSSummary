//
//  CJLocationService.h
//  Meet
//
//  Created by lisaike on 15/4/17.
//  Copyright (c) 2015年 Pobing Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  @description 定位当前位置用代码块
    @param location 经纬度坐标(GPS坐标)
    @param error 定位失败时候的错误
 */
typedef void(^CJGetLocationCompleted)(CLLocation *location, NSError *error);

@interface CJLocationService : NSObject

/**
 *  @description 是否正在定位
 */
@property (nonatomic, assign, readonly) BOOL isLocating;

/**
 *  @description 定位服务实例
 */
+ (instancetype)sharedInstance;

/**
    @description 定位当前位置
    @param completion 完成后执行的代码块(在主线程执行)
 */
- (void)getLocationWithCompletion:(CJGetLocationCompleted)completion;

+ (BOOL)systemLocationServiceStatus;
@end
