//
//  CJLocationService.m
//  Meet
//
//  Created by lisaike on 15/4/17.
//  Copyright (c) 2015年 Pobing Tech. All rights reserved.
//

#import "CJLocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface CJLocationService ()<CLLocationManagerDelegate>

/**
 *  @description 苹果定位服务
 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/**
 *  @description 定位成功后将要执行的操作队列(数组)
 */
@property (strong)            NSMutableArray    *operationArray;

@end

@implementation CJLocationService

+ (instancetype)sharedInstance
{
    static CJLocationService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CJLocationService alloc] init];
        sharedInstance.locationManager          = [[CLLocationManager alloc] init];
        sharedInstance.locationManager.delegate = sharedInstance;
        sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        sharedInstance.locationManager.distanceFilter = 3.0f;
        sharedInstance.isLocating               = NO;
        sharedInstance.operationArray           = [[NSMutableArray alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public

- (void)getLocationWithCompletion:(CJGetLocationCompleted)completion
{
    void (^startLocationBlock)() = ^
    {
        [self.operationArray addObject:completion];
        if(!self.isLocating)
        {
            self.isLocating = YES;
            [self.locationManager startUpdatingLocation];
        }
    };
    //指派到主队列保证线程安全
    if([NSThread isMainThread])
    {
        startLocationBlock();
    }
    else
    {
        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:startLocationBlock]];
    }
}

#pragma mark - setter

- (void)setIsLocating:(BOOL)isLocating
{
    _isLocating = isLocating;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location                = [locations lastObject];
//    CLLocationCoordinate2D coordinate   = location.coordinate;
    //停止定位
    [manager stopUpdatingLocation];
    self.isLocating = NO;
    //遍历执行所有待执行代码块
    for(CJGetLocationCompleted completion in self.operationArray)
    {
        if([NSThread isMainThread])
        {
            completion(location,nil);
        }
        else
        {
            [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^
            {
                completion(location,nil);
            }]];
        }
    }
    //删除所有待执行代码块
    [self.operationArray removeAllObjects];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //停止定位
    [manager stopUpdatingLocation];
    self.isLocating = NO;
    //遍历执行所有待执行代码块
    for(CJGetLocationCompleted completion in self.operationArray)
    {
        if([NSThread isMainThread])
        {
            completion(nil,error);
        }
        else
        {
            [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^
            {
                completion(nil,error);
            }]];
        }
    }
    //删除所有待执行代码块
    [self.operationArray removeAllObjects];
}

+ (BOOL)systemLocationServiceStatus
{
//    return [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus authorizationStatus=[CLLocationManager authorizationStatus];
    return authorizationStatus==kCLAuthorizationStatusAuthorizedAlways||authorizationStatus==kCLAuthorizationStatusAuthorizedWhenInUse;
}
@end
