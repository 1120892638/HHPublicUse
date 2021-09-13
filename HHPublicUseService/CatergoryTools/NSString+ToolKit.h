//
//  NSString+ToolKit.h
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToolKit)

//md5加密
- (NSString *) md5;

//是否为邮箱
- (BOOL)isValidEmail;

//是否为手机
- (BOOL)isValiMobile;

//随机字符串
+ (NSString *)randString;

//哈希算法
- (NSString *)hashString;

//将数组的元素用逗号分隔开
+ (NSString *)completmentStringWithArray:(NSArray *)array;

//获取错误的详细信息
+ (NSString *)getDetailErrorInfo:(NSError *)error;

//字符串转dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

//判断身份证格式是否正确
- (BOOL)judgeIdentityStringValid;

//判断银行卡号是否有效
+ (BOOL)checkBankCardNumber:(NSString *)cardNumber;

@end
