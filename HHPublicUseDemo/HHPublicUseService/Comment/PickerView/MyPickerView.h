//
//  MyPickerView.h
//  utravel
//
//  Created by 豆子 on 2018/6/23.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView *picker;

@property (nonatomic,strong,readonly) NSArray *pickerArr;

//指示的时间 直接显示的时间
@property (nonatomic,strong) NSDate *date;

@property (nonatomic,copy) void (^pickerSelectBlock) (NSString *text);

//自驾团类型
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title pickerArray:(NSArray *)pickerArr;

//日期选择控件
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title;

//type=2 时间
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title withType:(NSInteger)type withDate:(NSDate*)date;

//设置选择的最大日期
@property (nonatomic,strong) NSDate *maxDate;
//设置选择的最小日期
@property (nonatomic,strong) NSDate *minDate;
@end
