//
//  NSString+Validate.h
//  NSString+Validate
//
//  Created by shaimi on 15/6/26.
//  Copyright (c) 2015年 xingcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isMobilePhoneNumber;
- (BOOL)isWordMoreThan:(NSInteger)wordCount;
- (BOOL)isWordLessThan:(NSInteger)wordCount;
- (BOOL)isCharMoreThan:(NSInteger)charCount;
- (BOOL)isCharLessThan:(NSInteger)charCount;
- (NSInteger)charLength;
@end
