//
//  SGTextView.m
//  SGiOSSummary
//
//  Created by 刘山国 on 15/6/26.
//  Copyright (c) 2015年 山国. All rights reserved.
//

#import "SGTextView.h"

@interface SGTextView()

@property(nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation SGTextView



- (id)initWithFrame:(CGRect)frame{
    if( (self = [super initWithFrame:frame]) ){
        self.font = [UIFont systemFontOfSize:16];
        _placeholder = @"";
        _placeholderColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification{
    
    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] == 0){
        [[self viewWithTag:999] setAlpha:1];
    }else{
        [[self viewWithTag:999] setAlpha:0];
    }
}



- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}


- (void)drawRect:(CGRect)rect{
    
    if( [[self placeholder] length] > 0 ) {
        if ( _placeHolderLabel == nil ){
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textContainerInset.left+4,self.textContainerInset.top,self.bounds.size.width,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
        
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ){
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
