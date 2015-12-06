//
//  UIImage+Category.h
//  Toing
//
//  Created by Rdd7 on 7/5/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Category)

- (UIImage*)setTintColor:(UIColor *)color;

+ (UIImage*)blankImage;

+ (UIImage*)failureImage;

- (BOOL)saveImageToFilePath:(NSString*)filePath;

- (UIImage *)fixOrientation;

- (UIImage *)scaleToSize:(CGSize)newsize;

-(UIImage *)compressImageWith:(CGFloat)newImageWidth;

@end
