//
//  CJImageTools.m
//  Meet
//
//  Created by lisaike on 14/12/9.
//  Copyright (c) 2014年 Pobing Tech. All rights reserved.
//

#import "CJImageTools.h"

@implementation CJImageTools

+ (UIImage *)fixOrientationAfterTakePhoto:(UIImage *)image
{
    if(image.imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    return image;
}

@end
