//
//  UIUtils.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import "NSDate+TimeAgo.h"

@interface UIUtils : NSObject

// 将字符串格式化为Date对象
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;

// 将日期格式化为NSString对象
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

+ (NSString *)fomateStringTimeAgoString:(NSString *)datestring;

//转换时区
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

// 计算目录下面所有文件的大小
+ (long long)countDirectorySize:(NSString *)directory;

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt DESKEY:(NSString *)deskey;
+ (NSString*)sha1:(NSString *)str;

+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

+ (NSString *)yearMonthDay;

+ (void)showActivityIndicatorView:(UIView *)view;
+ (void)removeActivityIndicatorView:(UIView *)view;

@end
