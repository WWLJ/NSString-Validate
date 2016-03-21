//
//  NSString+Validate.m
//  NSString+Validate
//
//  Created by shaimi on 15/6/26.
//  Copyright (c) 2015年 xingcheng. All rights reserved.
//



//六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
//static NSUInteger addressLen  = 6;
//static NSUInteger birthdayLen = 8;
//static NSUInteger sxCodeLen = 3;
/*
 1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。
 2、将这17位数字和系数相乘的结果相加。
 3、用加出来和除以11，看余数是多少？
 4、余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。其分别对应的最后一位身份证的号码为1－0－X －9－8－7－6－5－4－3－2。
 5、通过上面得知如果余数是3，就会在身份证的第18位数字上出现的是9。如果对应的数字是2，身份证的最后一位号码就是罗马数字x。
 例如：某男性的身份证号码为【53010219200508011x】， 我们看看这个身份证是不是合法的身份证。
 首先我们得出前17位的乘积和【(5*7)+(3*9)+(0*10)+(1*5)+(0*8)+(2*4)+(1*2)+(9*1)+(2*6)+(0*3)+(0*7)+(5*9)+(0*10)+(8*5)+(0*8)+(1*4)+(1*2)】是189，然后用189除以11得出的结果是189/11=17----2，也就是说其余数是2。最后通过对应规则就可以知道余数2对应的检验码是X。所以，可以判定这是一个正确的身份证号码。
 */


#import "NSString+Validate.h"

@interface NSString ()

@property (nonatomic,strong) NSArray *validateCode;
@property (nonatomic,strong) NSArray *digits;

@end

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


- (BOOL)isMobileNumber
{
    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



- (BOOL) validateIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:self]) {
        if ([self checkCode:self]) {
            return YES;
        }
    }
    return NO;
}


- (NSArray *)validateCode{
    return @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
}

- (NSArray *)digits{
    return @[@1, @0, @10, @9, @8, @7, @6, @5, @4, @3, @2];
}


- (BOOL)checkCode:(NSString *)code{
    NSInteger sum = 0;
    for (NSInteger i = 0; i < self.validateCode.count; i++) {
        sum += ((NSNumber *)self.validateCode[i]).integerValue * [code substringWithRange:NSMakeRange(i, 1)].integerValue;
    }
    int remainder = fmod(sum, 11);
    
    NSString *last = [code substringFromIndex:code.length-1];
    
    if ([[last lowercaseString] isEqual:@"x"]) {
        last = @"10";
    }
    NSInteger lastNum = last.integerValue;
    
    if (((NSNumber *)self.digits[remainder]).integerValue == lastNum) {
        return YES;
    }else{
        return NO;
    }
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
