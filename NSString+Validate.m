//
//  NSString+Validate.m
//  NSString+Validate
//
//  Created by shaimi on 15/6/26.
//  Copyright (c) 2015年 xingcheng. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)
- (BOOL)isEmail{
    NSString *emailRegex = @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [predicate evaluateWithObject:self];
    return isValid;
    
}

-(BOOL)isUrl{
    NSString*urlRegex = @"((http|ftp|https)://)?(www.){1}[a-zA-Z0-9]+[.]{1}[\\w]+[/\\w]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    BOOL isValid = [predicate evaluateWithObject:self];
    return isValid;
}

-(BOOL)isMobilePhoneNumber{
    NSString*mobilePhoneNumberRegex = @"^[1][3,4,5,6,7,8][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobilePhoneNumberRegex];
    BOOL isValid = [predicate evaluateWithObject:self];
    return isValid;

}

-(BOOL)isWordMoreThan:(NSInteger)wordCount{
    return [self length]>wordCount;
}

-(BOOL)isWordLessThan:(NSInteger)wordCount{
    return [self length]<wordCount;

}

-(BOOL)isCharMoreThan:(NSInteger)charCount{
    return [self convertToInt:self]>charCount;
}

-(BOOL)isCharLessThan:(NSInteger)charCount{
    return [self convertToInt:self]<charCount;
}
-(NSInteger)charLength{
    return [self convertToInt:self];
}
-  (NSInteger)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}
@end
