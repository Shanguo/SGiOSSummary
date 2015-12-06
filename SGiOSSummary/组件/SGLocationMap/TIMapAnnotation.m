//
//  TIMapAnnotation.m
//  ToingiOS
//
//  Created by 刘山国 on 15/11/12.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "TIMapAnnotation.h"

@implementation TIMapAnnotation

-(void)setALocation:(CLLocation *)location Completion:(void (^)(NSString *))complete{
    [self setCoordinate:location.coordinate];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark=[placemarks firstObject];
            self.title = placemark.subLocality;
            if ([placemark.name containsString:self.title]) {
                self.subtitle = [NSString stringWithFormat:@"%@%@",placemark.thoroughfare,placemark.subThoroughfare];
            }else{
                self.subtitle = placemark.name;
            }
            NSString *place = [NSString stringWithFormat:@"%@ %@",self.title,self.subtitle];
            place = [place stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            complete(place);
        }else{
//            DLog(@"获取详细地址失败");
            NSLog(@"获取详细地址失败");
        }
    }];
}



@end
