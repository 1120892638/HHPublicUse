//
//  MyPickerManager.h
//  utravel
//
//  Created by 豆子 on 2018/6/23.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSingleSelectView.h"

@interface MyPickerManager : NSObject

+ (void)showPickerArray:(NSArray *)array tipText:(NSString *)tip block:(void (^)(NSString *text))sure;

//日期选择（最小日期为今天）
+ (void)showDatepickerWithTipText:(NSString *)tip block:(void (^)(NSString *text))sure;

//时间
+ (void)showDatepickerWithTipText:(NSString *)tip withType:(NSInteger)type withDate:(NSDate *)date block:(void (^)(NSString *text))sure;

//设置最大日期
+ (void)showDatepickerWithTipText:(NSString *)tip maxDate:(NSDate *)maxDate block:(void (^)(NSString *text))sure;

//设置最小日期
+ (void)showDatepickerWithTipText:(NSString *)tip minDate:(NSDate *)minDate block:(void (^)(NSString *text))sure;

//选择年月
+ (void)showMyDefineDatePickerManagerWithTitleTex:(NSString *)titleText minimumDate:(NSDate *)minDate maxDate:(NSDate *)maxDate currentSelectDate:(NSDate *)selectDate sureSelectBlock:(void (^) (NSString *dateStr))sureAction;

//从底部弹出的单选视图  --- 是否单选
+ (void)showSingleSelectView:(NSArray *)array isSingle:(BOOL)isSingle block:(void (^)(NSString *text,CustomSingleSelectView *sView))selectBlock;

@end
