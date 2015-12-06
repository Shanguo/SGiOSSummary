//
//  TIMapAnnotation.h
//  ToingiOS
//
//  Created by 刘山国 on 15/11/12.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TIMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (void)setALocation:(CLLocation*)location Completion:(void(^)(NSString *place))complete;
@end
