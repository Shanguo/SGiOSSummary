//
//  TILocationMapController.h
//  ToingiOS
//
//  Created by 刘山国 on 15/11/12.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol TILocationMapControllerDelegate <NSObject>

- (void)tiLocationMapControllerGetPlace:(NSString*)place;

@end

@interface TILocationMapController : UIViewController
@property (nonatomic,assign) id<TILocationMapControllerDelegate> delegate;
@end
