//
//  NSString+Category.h
//  Toing
//
//  Created by Rdd7 on 7/8/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Category)

- (BOOL)isLegalPhoneNumber;

- (BOOL)isLegalPassword;

- (NSString*)MD5Encrypt;


/**
 *  是否是合法的邮编，判断是否6位长度
 */
- (BOOL)isLegalPostCode;


/**
 *  是否匹配字母或数字
 */
- (BOOL)isMatchLetterNumber;


/**
 *  是否匹配中文、字母或数字
 */
- (BOOL)isMatchWords;


@end
