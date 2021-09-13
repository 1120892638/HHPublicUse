//
//  CustomDataPickView.h
//  education
//
//  Created by 豆子 on 2019/3/27.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSDate+Tookit.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CustomDataPickViewType) {
    CustomDataPickViewTypeYearMonthDay,//年月日
    CustomDataPickViewTypeYearMonth//年月
};

@protocol CustomDataPickViewDelegate <NSObject>
@optional

//CustomDataPickViewTypeYearMonthDay 回调
- (void)pickViewCallBack_year:(NSString *)year month:(NSString *)month day:(NSString *)day;

//CustomDataPickViewTypeYearMonth 回调
- (void)pickViewCallBack_year:(NSString *)year month:(NSString *)month;

//滚动pickView时 回调
- (void)pickViewScroollCallBack_year:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface CustomDataPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate> {
    UIPickerView * pickView;
}

@property (nonatomic, weak) id<CustomDataPickViewDelegate> delegate;
@property(nonatomic,unsafe_unretained)CustomDataPickViewType type;
@property (nullable, nonatomic, strong) NSDate *minimumDate;//最小显示的日期
@property (nullable, nonatomic, strong) NSDate *maximumDate;//最大显示的日期
@property (nullable, nonatomic, strong) NSDate *defaultSelectDate;//默认选中的日期
- (void)show;
- (void)startCallBack;

@end

NS_ASSUME_NONNULL_END
