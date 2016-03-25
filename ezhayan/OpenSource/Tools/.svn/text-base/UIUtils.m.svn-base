//
//  UIUtils.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIUtils.h"

#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

//#define DESKEY @"DE76E3EC39801CEEE0440014"

@implementation UIUtils

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    [dateFormatter release];
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return datestring;
}

+ (NSString *)fomateStringTimeAgoString:(NSString *)datestring {
    
    // Wed Oct 01 19:27:18 +0800 2014
    // 格式化的字符串必须和所给定日期个格式一致，如果不一致获取NSDate对象为NULL
    // 最好是时间戳，便于计算
    NSString *formate = @"yyyy-M-d HH:mm:ss";
    NSDate *createDate = [UIUtils dateFromString:datestring formate:formate];
    // 过去的时间（createDate）和现在（now）的比较
    NSString *text = [createDate timeAgo];
    return text;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] autorelease];
    return destinationDateNow;
}


+ (long long)countDirectorySize:(NSString *)directory
{
    // 文件管理者对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    //NSLog(@"fileNames : %@", fileNames);
    
    // 所有的文件大小
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        
        // 拼接文件路径 Library/Caches.. + bdcdd4208ac8657348d9836f7d6cc160
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        // 获取文件属性
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        //NSLog(@"attribute : %@", attribute);
        
        //NSNumber *filesize = attribute[NSFileSize];
        // 得到是没一个文件大小
        long long size = [attribute fileSize];
        
        // 累加
        sum += size;
    }
    
    return sum;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
  
}

+ (NSString *) dataToHexString:(NSData *)data
{
    NSUInteger          len = [data length];
    char *              chars = (char *)[data bytes];
    NSString *   hexString = [[NSMutableString alloc] init];

    for(NSUInteger i = 0; i < len; i++ ) {
        //[hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
        NSString *newHexStr = [NSString stringWithFormat:@"%x",chars[i]&0xff];///16进制数
    
        if([newHexStr length]==1){
        
            hexString = [NSString stringWithFormat:@"%@0%@",hexString,newHexStr];
        
        }else{
        
            hexString = [NSString stringWithFormat:@"%@%@",hexString,newHexStr];
        }
    }
    
    return hexString;
}

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt DESKEY:(NSString *)deskey
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[deskey UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding]
                  autorelease];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [self dataToHexString:myData];//[GTMBase64 stringByEncodingData:myData];//
    }
    
    return result;
}

+ (NSString*)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    return outputStr;
}

+ (NSString *)yearMonthDay
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

+ (void)showActivityIndicatorView:(UIView *)view
{
    UIActivityIndicatorView *_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    _activityView.tag = 100000000;
    _activityView.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    [_activityView startAnimating];
    [view addSubview:_activityView];
}

+ (void)removeActivityIndicatorView:(UIView *)view
{
    UIActivityIndicatorView *_activityView = (UIActivityIndicatorView *)[view viewWithTag:100000000];
    [_activityView stopAnimating];
    [_activityView removeFromSuperview];
}

@end
