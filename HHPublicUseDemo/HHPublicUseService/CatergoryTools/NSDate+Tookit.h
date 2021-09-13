//
//  NSDate+Tookit.h
//  education
//
//  Created by 豆子 on 2019/3/27.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Tookit)

//NSDate转NSString
+(NSString *)stringFromDate:(NSDate *)date DateFormat:(NSString *)DateFormat;

//NSString转NSDate
+(NSDate *)dateFromString:(NSString *)dateString DateFormat:(NSString *)DateFormat;

//获取时间字符串的时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
