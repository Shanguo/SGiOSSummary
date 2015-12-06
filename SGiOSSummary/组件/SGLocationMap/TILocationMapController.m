//
//  TILocationMapController.m
//  ToingiOS
//
//  Created by 刘山国 on 15/11/12.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "TILocationMapController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TIMapAnnotation.h"
#import "TILog.h"



@interface TILocationMapController ()<MKMapViewDelegate>
@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) TIMapAnnotation *annotation;
@property (nonatomic,assign) NSInteger updateTimes;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation TILocationMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGUI];
}

#pragma mark 添加地图控件
-(void)initGUI{
    self.navigationItem.title = @"定位中...";
    [self.view addSubview:self.mapView];
    [self.mapView addAnnotation:self.annotation];
    
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
}


#pragma mark - 地图控件代理方法
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if (self.updateTimes<3) {
        self.updateTimes++;
        //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
        MKCoordinateSpan span=MKCoordinateSpanMake(0.05, 0.05);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
        [self.mapView setRegion:region animated:true];
        [self updateLocationPlaceWithLocation:userLocation.location];
    }
}

#pragma mark - actions
- (void)mapTaped:(UITapGestureRecognizer*)tapGesture{
    CGPoint touchPoint = [tapGesture locationInView:self.mapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    CLLocation *location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    [self updateLocationPlaceWithLocation:location];
}

#pragma mark - private 
- (void)updateLocationPlaceWithLocation:(CLLocation*)location{
    __weak typeof(self) weakSelf = self;
    [self.annotation setALocation:location Completion:^(NSString *place) {
        weakSelf.navigationItem.title = place;
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(tiLocationMapControllerGetPlace:)]) {
            [weakSelf.delegate tiLocationMapControllerGetPlace:place];
        }
    }];
}

#pragma mark - getter 

-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView=[[MKMapView alloc]initWithFrame:self.view.bounds];
        _mapView.userTrackingMode=MKUserTrackingModeFollow;//用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
        _mapView.mapType=MKMapTypeStandard;//设置地图类型
        _mapView.delegate=self;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapTaped:)];
        [_mapView addGestureRecognizer:singleTap];
    }
    return _mapView;
}

-(TIMapAnnotation *)annotation{
    if (!_annotation) {
        _annotation = [[TIMapAnnotation alloc] init];
        _annotation.title = @"";
        _annotation.subtitle = @"";
    }
    return _annotation;
}

@end
