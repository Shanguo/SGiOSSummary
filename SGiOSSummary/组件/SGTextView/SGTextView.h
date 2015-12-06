//
//  SGTextView.h
//  SGiOSSummary
//
//  Created by 刘山国 on 15/10/27.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SGTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, strong) UIColor  *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
