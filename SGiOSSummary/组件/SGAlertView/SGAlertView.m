//
//  SGAlertView.m
//  SGiOSSummary
//
//  Created by 刘山国 on 15/11/14.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "SGAlertView.h"
#import <objc/runtime.h> 

@interface SGAlertView()<UIAlertViewDelegate>

@end

@implementation SGAlertView


+ (SGAlertView *)alertWitMessage:(NSString *)message confirmTitle:(NSString *)confirmTitle completionBlock:(void (^)(NSUInteger, SGAlertView *))complete{
    return [SGAlertView alertWithTitle:@"提示"
                                   message:message
                           completionBlock:complete
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:confirmTitle,nil];
}

+ (SGAlertView*)alertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelTitle
              confirmTitle:(NSString *)confirmTitle
           completionBlock:(void (^)(NSUInteger buttonIndex, SGAlertView *alertView))complete{
   return [SGAlertView alertWithTitle:title
                                  message:message
                          completionBlock:complete
                        cancelButtonTitle:cancelTitle
                        otherButtonTitles:confirmTitle,nil];
}

+ (SGAlertView*)alertWithTitle:(NSString *)title
                           message:(NSString *)message
         completionBlock:(void (^)(NSUInteger buttonIndex, SGAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (!cancelButtonTitle && !otherButtonTitles) {
        return nil;
    }
    SGAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         completionBlock:block
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    
    if (otherButtonTitles != nil) {
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [alertView addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [alertView addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    
    [alertView show];
    
    return alertView;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(buttonIndex, self);
    }
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
    completionBlock:(void (^)(NSUInteger buttonIndex, SGAlertView *alertView))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {

    objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (self = [self initWithTitle:title
                           message:message
                          delegate:self
                 cancelButtonTitle:nil
                 otherButtonTitles:nil]) {

        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }

        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [self addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    return self;
}
@end
