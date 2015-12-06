//
//  UIFont+Private.m
//  SGiOSSummary
//
//  Created by 刘山国 on 15/12/6.
//  Copyright © 2015年 山国. All rights reserved.
//

#import "UIFont+Private.h"
#import <CoreText/CTFontManager.h>

@implementation UIFont (Private)


+ (UIFont*)fontSize:(CGFloat)size FontName:(NSString*)fontName{
    NSArray *array = [fontName componentsSeparatedByString:@"."];
    if (array.count<2) return [UIFont systemFontOfSize:size];
    return [self fontWithSize:size FontName:array[0] OfType:array[1]];
}

+ (UIFont*)fontWithSize:(CGFloat)size FontName:(NSString*)fontName OfType:(NSString*)type{
    NSURL *fontUrl = [[NSBundle mainBundle] URLForResource:fontName withExtension:type];
    if (fontUrl==nil)  NSLog(@"加载字体失败,路径错误");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *realFontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    if (realFontName==nil)  NSLog(@"加载字体失败!");
    UIFont *font = [UIFont fontWithName:realFontName size:size];
    CGFontRelease(fontRef);
    return font;
}

@end
