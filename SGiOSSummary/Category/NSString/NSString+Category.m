//
//  NSString+Category.m
//  Toing
//
//  Created by Rdd7 on 7/8/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>


NSString* const MOBILE = @"^1\\d{10}";

NSString* const POSTCODE = @"\\d{6}";


@implementation NSString(Category)


/************** Check Area  ***************/
-(BOOL)isLegalPhoneNumber{
    NSPredicate *regexPhoneNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if ([regexPhoneNumber evaluateWithObject:self]){
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)isLegalPassword{
    NSString * regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


- (BOOL)isLegalPostCode{
    NSPredicate *regexPostCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",POSTCODE];
    return [regexPostCode evaluateWithObject:self];
}

-(NSString*)MD5Encrypt{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


- (BOOL)isMatchLetterNumber{
    NSString * regex = @"^[A-Za-z0-9]{0,1500}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isMatchWords{
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}



@end
