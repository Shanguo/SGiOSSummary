//
//  UIButton+YK.m
//  ToingiOS
//
//  Created by 刘山国 on 15/11/5.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "UIButton+YK.h"

@implementation UIButton (YK)

-(void)color:(nullable UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}
-(void)font:(UIFont *)font{
    self.titleLabel.font = font;
}

-(void)title:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

-(void)image:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

-(void)backgroundImage:(UIImage *)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)addTarget:(id)target Listener:(SEL)listener{
    [self addTarget:target action:listener forControlEvents:UIControlEventTouchUpInside];
}

-(void)textLRAlignment:(UIControlContentHorizontalAlignment)alignment{
    self.contentHorizontalAlignment = alignment;
}


@end
