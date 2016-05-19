//
//  NSString+Util.h
//  UIDemo
//
//  Created by YU on 16/4/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

/**
 *  升序排列字典
 *
 *  @param dic  排列字典
 *
 *  @return 升序排列后的字符串形如a=a&b=b
 */
+ (NSString *)sortDictioanry:(NSDictionary *)dic;

/**
 *  MD5
 *
 *  @param NSString md5字符串
 *
 *  @return 小写MD5
 */
+ (NSString *)lowMD5String:(NSString *)string;

/**
 *  金额单位转换成元
 *
 *  @return
 */
- (NSString *)convertToYuan;

/**
 *  金额单位转换成分
 *
 *  @return
 */
- (NSString *)convertToFen;

/**
 *  验证数字或者金额正确性
 *
 *  @return
 */
- (BOOL)verfiyNumber;
- (BOOL)verfiyMoney;

/**
 *  验证银行卡的正确性！
 *
 *  @param number 银行卡号
 *
 *  @return YES 为合法银行卡号
 */
+ (BOOL)isValidBankCardNumber:(NSString *)number;

/**
 *  验证手机号正确性
 *
 *  @param mobileNum 手机号
 *
 *  @return
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  验证身份证
 *
 *  @param identityCard 身份证号
 *
 *  @return  YES/NO
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 *  获取系统的时间戳
 *
 *  @return
 */
+ (NSString *)getSysTimeStamp;
@end
