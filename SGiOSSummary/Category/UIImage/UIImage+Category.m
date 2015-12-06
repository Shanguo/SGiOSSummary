//
//  UIImage+Category.m
//  Toing
//
//  Created by Rdd7 on 7/5/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage(Category)

-(UIImage*)setTintColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+(UIImage*)blankImage{
    return [UIImage new];
}



+(UIImage*)failureImage{
    return nil;
}


-(BOOL)saveImageToFilePath:(NSString *)filePath{
    NSData *imagedata=UIImagePNGRepresentation(self);
    return [imagedata writeToFile:filePath atomically:YES];
}





- (UIImage *)fixOrientation {
   
      // No-op if the orientation is already correct
      if (self.imageOrientation == UIImageOrientationUp) return self;
   
      // We need to calculate the proper transformation to make the image upright.
      // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
       CGAffineTransform transform = CGAffineTransformIdentity;
   
       switch (self.imageOrientation) {
               case UIImageOrientationDown:
               case UIImageOrientationDownMirrored:
                   transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
                   transform = CGAffineTransformRotate(transform, M_PI);
                   break;
       
               case UIImageOrientationLeft:
               case UIImageOrientationLeftMirrored:
                   transform = CGAffineTransformTranslate(transform, self.size.width, 0);
                   transform = CGAffineTransformRotate(transform, M_PI_2);
                   break;
       
               case UIImageOrientationRight:
               case UIImageOrientationRightMirrored:
                   transform = CGAffineTransformTranslate(transform, 0, self.size.height);
                   transform = CGAffineTransformRotate(transform, -M_PI_2);
                   break;
               case UIImageOrientationUp:
               case UIImageOrientationUpMirrored:
                   break;
    }
   
       switch (self.imageOrientation) {
                case UIImageOrientationUpMirrored:
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.width, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
        
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.height, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
                case UIImageOrientationUp:
                case UIImageOrientationDown:
                case UIImageOrientationLeft:
                case UIImageOrientationRight:
                    break;
      }
   
       // Now we draw the underlying CGImage into a new context, applying the transform
       // calculated above.
       CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                                                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                                                                              CGImageGetColorSpace(self.CGImage),
                                                                                              CGImageGetBitmapInfo(self.CGImage));
       CGContextConcatCTM(ctx, transform);
       switch (self.imageOrientation) {
                 case UIImageOrientationLeft:
                 case UIImageOrientationLeftMirrored:
                 case UIImageOrientationRight:
                 case UIImageOrientationRightMirrored:
                     // Grr...
                     CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
                     break;
         
                 default:
                     CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
                     break;
        }
   
       // And now we just create a new UIImage from the drawing context
       CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
       UIImage *img = [UIImage imageWithCGImage:cgimg];
       CGContextRelease(ctx);
       CGImageRelease(cgimg);
       return img;
   }


- (UIImage *)scaleToSize:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  等比缩放本图片
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
-(UIImage *)compressImageWith:(CGFloat)newImageWidth
{
    if (!self) return nil;
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float width = newImageWidth;
    float height = self.size.height/(self.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
