//
//  NSString+Util.m
//  UIDemo
//
//  Created by YU on 16/4/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonHMAC.h>


@implementation NSString (Util)

//字典排序
+ (NSString *)sortDictioanry:(NSDictionary *)dic
{
    NSMutableString *sign = [NSMutableString string];
    //参数必须为升序排列
    NSArray *dicArray = [[dic allKeys] copy];
    NSArray *sortArray = [dicArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    /**
     *  除去排列参数中的sign参数
     */
    for (int i = 0; i < sortArray.count; i++) {
        if ([sortArray[i] isEqualToString:@"sign"]) {
            continue;
        }else if (i == sortArray.count-1)
        {
            [sign appendFormat:@"%@=%@",sortArray[i],[dic objectForKey:sortArray[i]]];
        }else{
            [sign appendFormat:@"%@=%@&",sortArray[i],[dic objectForKey:sortArray[i]]];
        }
    }
    return [sign copy];
}

//MD5
+ (NSString *)lowMD5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

#pragma mark -- 数字有关的验证操作

- (NSString *)convertToYuan{
    return [NSString stringWithFormat:@"%.2lf",[self doubleValue]/100.0];
}

- (NSString *)convertToFen{
    return  [[NSNumber numberWithInteger:[self doubleValue] * 100] stringValue];
}

- (BOOL)verfiyMoney {
    if (self.length >= 1 && ![self isEqualToString:@"0"]) {
        
        NSString *channelString = @"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$";
        NSPredicate *channel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",channelString];
        return [channel evaluateWithObject:self];
    }
    return NO;
    
}

- (BOOL)verfiyNumber {
    //只能输入数字
    if (self.length >= 1) {
        
        NSString *channelString = @"^[0-9]+$";
        NSPredicate *channel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",channelString];
        return [channel evaluateWithObject:self];
    }
    return NO;
}

+ (NSString*)getSysTimeStamp{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    long int timeStamp = timeInterval;
    NSString * timStampStr = [NSString stringWithFormat:@"%ld",timeStamp];
    return timStampStr;
}

#pragma mark -- 字符串验证 手机号 银行卡 身份证
// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,170
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181,187
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[1567])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181,187
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        if([regextestcm evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

//身份证号
+ (BOOL) validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/**
 *  验证银行卡的正确性！
 *
 *  @param number 银行卡号
 *
 *  @return YES 为合法银行卡号
 */
+ (BOOL)isValidBankCardNumber:(NSString *)number{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[number length];
    int lastNum = 0;
    for (int i = cardNoLength ; i >= 1; i--) {
        NSString *cardNumber = [number substringToIndex:i];
        lastNum = [[cardNumber substringFromIndex:i-1] intValue];
        if (i%2 == 1) {//奇数
            oddsum += lastNum;
        }else{
            lastNum *= 2;
            if (lastNum >= 10) {
                lastNum -= 9;
            }
            evensum += lastNum;
        }
    }
    allsum = oddsum + evensum;
    if (allsum%10 == 0) {
        return YES;
    }else{
        return NO;
    }
    
}


@end
