//
//  MyPickerManager.m
//  utravel
//
//  Created by 豆子 on 2018/6/23.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "MyPickerManager.h"
#import "MyPickerView.h"
#import "CustomDataPickView.h"
#import "CustomSingleSelectView.h"
#import "ConstDefineHeader.h"
#import "ViewInstance.h"
#import "UIView+ViewCayegory.h"

@interface MyPickerManager()<CustomDataPickViewDelegate>{
    UIView *_myDefineBackView;
    CustomDataPickView *_customPickerView;
    NSString *_dateString;
}

@property (nonatomic,strong) MyPickerView *pickerView;

@property (nonatomic,copy) void (^sureSelectBlock) (NSString *str);

@end

@implementation MyPickerManager

+ (MyPickerManager *)sharedInstance {
    static dispatch_once_t onceToken;
    static MyPickerManager *shareManager;
    dispatch_once(&onceToken, ^{
        shareManager = [[[self class] alloc] init];
    });
    return shareManager;
}

+ (void)showSingleSelectView:(NSArray *)array isSingle:(BOOL)isSingle block:(void (^)(NSString *text,CustomSingleSelectView *sView))selectBlock{
    [CustomSingleSelectView initSingleSelectView:array isSingleSelect:isSingle block:selectBlock];
}

//单选
+ (void)showPickerArray:(NSArray *)array tipText:(NSString *)tip block:(void (^)(NSString *text))sure{
    
    [[MyPickerManager sharedInstance] showPickerViewArray:array tipText:tip block:sure];
    
}

- (void)showPickerViewArray:(NSArray *)array tipText:(NSString *)tip  block:(void (^)(NSString *text))sure{
    
    self.pickerView = [[MyPickerView alloc] initWithFrame:KWindow.bounds tipText:tip pickerArray:array];
    
    self.pickerView.pickerSelectBlock = ^(NSString *text) {
      
        sure(text);
        
    };
    
    [KWindow addSubview:self.pickerView];
    
    [KWindow bringSubviewToFront:self.pickerView];
    
}

//日期选择
+ (void)showDatepickerWithTipText:(NSString *)tip block:(void (^)(NSString *text))sure{
    
    [[MyPickerManager sharedInstance] showDatePicker:tip block:sure];
    
}

- (void)showDatePicker:(NSString *)tip block:(void (^)(NSString *text))sure{
    
    self.pickerView = [[MyPickerView alloc] initWithFrame:KWindow.bounds tipText:tip];
    
    self.pickerView.pickerSelectBlock = ^(NSString *text) {
        
        sure(text);
        
    };
    
    [KWindow addSubview:self.pickerView];
    
    [KWindow bringSubviewToFront:self.pickerView];
    
}


//时间日期选择
+ (void)showDatepickerWithTipText:(NSString *)tip withType:(NSInteger)type withDate:(NSDate *)date block:(void (^)(NSString *text))sure{
    
    [[MyPickerManager sharedInstance]  showDatePicker:tip withType:type withCurDate:date block:sure];
    
}

- (void)showDatePicker:(NSString *)tip withType:(NSInteger)type withCurDate:(NSDate*)date block:(void (^)(NSString *text))sure{
    
    self.pickerView = [[MyPickerView alloc] initWithFrame:KWindow.bounds tipText:tip withType:type withDate:date];
    
    self.pickerView.pickerSelectBlock = ^(NSString *text) {
        
        sure(text);
        
    };
    
    [KWindow addSubview:self.pickerView];
    
    [KWindow bringSubviewToFront:self.pickerView];
    
}

+ (void)showDatepickerWithTipText:(NSString *)tip maxDate:(NSDate *)maxDate block:(void (^)(NSString *text))sure{
    
    [[MyPickerManager sharedInstance] showDatePicker:tip withMaxDate:maxDate block:sure];
    
}

- (void)showDatePicker:(NSString *)tip withMaxDate:(NSDate *)maxDate block:(void (^)(NSString *text))sure{
    self.pickerView = [[MyPickerView alloc] initWithFrame:KWindow.bounds tipText:tip];
    self.pickerView.maxDate = maxDate;
    self.pickerView.pickerSelectBlock = ^(NSString *text) {
        sure(text);
    };
    [KWindow addSubview:self.pickerView];
    [KWindow bringSubviewToFront:self.pickerView];
    
}

+ (void)showDatepickerWithTipText:(NSString *)tip minDate:(NSDate *)minDate block:(void (^)(NSString *text))sure{
    
    [[MyPickerManager sharedInstance] showDatePicker:tip withMinDate:minDate block:sure];
    
}

- (void)showDatePicker:(NSString *)tip withMinDate:(NSDate *)minDate block:(void (^)(NSString *text))sure{
    self.pickerView = [[MyPickerView alloc] initWithFrame:KWindow.bounds tipText:tip];
    self.pickerView.minDate = minDate;
    self.pickerView.pickerSelectBlock = ^(NSString *text) {
        sure(text);
    };
    [KWindow addSubview:self.pickerView];
    [KWindow bringSubviewToFront:self.pickerView];
    
}

+ (void)showMyDefineDatePickerManagerWithTitleTex:(NSString *)titleText minimumDate:(NSDate *)minDate maxDate:(NSDate *)maxDate currentSelectDate:(NSDate *)selectDate sureSelectBlock:(void (^) (NSString *dateStr))sureAction{
    [[MyPickerManager sharedInstance] showMyefineDatePickerViewWithTitleTex:titleText minimumDate:minDate maxDate:maxDate currentSelectDate:selectDate sureSelectBlock:sureAction];
}

- (void)showMyefineDatePickerViewWithTitleTex:(NSString *)titleText minimumDate:(NSDate *)minDate maxDate:(NSDate *)maxDate currentSelectDate:(NSDate *)selectDate sureSelectBlock:(void (^) (NSString *dateStr))sureAction{
    self.sureSelectBlock = sureAction;
    UIView *backView = [ViewInstance defindViewWithFrame:KWindow.bounds backgroundColor:KWindowColor];
    [KWindow addSubview:backView];
    _myDefineBackView = backView;
    
    UIView *content = [[UIView alloc] initWithFrame:Setframe(0, SCREENH_HEIGHT-296, SCREEN_WIDTH, 296)];
    [backView addSubview:content];
    content.backgroundColor = HexString(@"f2f2f2");
    
    UIButton *cancle = [ViewInstance defindButOnlyTileWithFrame:Setframe(0, 0, 70, 40) title:@"取消" titleColor:HexString(@"#373A3E") titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [content addSubview:cancle];
    [cancle addTarget:self action:@selector(cancleAction) forControlEvents:1<<6];
    
    UIButton *sure = [ViewInstance defindButOnlyTileWithFrame:Setframe(content.width-70, 0, 70, 40) title:@"确定" titleColor:[UIColor redColor] titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [content addSubview:sure];
    [sure addTarget:self action:@selector(sureAction) forControlEvents:1<<6];
    
    UILabel *title = [ViewInstance defindLabelWithFrame:Setframe(cancle.right + 10, 0, sure.x-cancle.right-20, 40) text:titleText textColor:HexString(@"#373A3E") textAlignment:NSTextAlignmentCenter font:[UIFont fontWithName:@"PingFangSC-Medium" size:15]];
    [content addSubview:title];
    
    CustomDataPickView *customDataPickView = [[CustomDataPickView alloc] initWithFrame:CGRectMake(0, 40, content.width, 256)];
    customDataPickView.backgroundColor = [UIColor whiteColor];
    customDataPickView.minimumDate = minDate;
    customDataPickView.maximumDate = maxDate;
    customDataPickView.defaultSelectDate = selectDate;
    customDataPickView.type = CustomDataPickViewTypeYearMonth;
    customDataPickView.delegate = self;
    [customDataPickView show];
    [content addSubview:customDataPickView];
    _customPickerView = customDataPickView;
}

//CustomDataPickViewTypeYearMonth 回调
- (void)pickViewCallBack_year:(NSString *)year month:(NSString *)month{
    if (month.length == 1) {
        //个位数首位补0
        month = [NSString stringWithFormat:@"0%@",month];
    }
    _dateString = [NSString stringWithFormat:@"%@-%@",year,month];
}

- (void)cancleAction{
    [_myDefineBackView removeFromSuperview];
}

- (void)sureAction{
    [_customPickerView startCallBack];
    self.sureSelectBlock(_dateString);
    [_myDefineBackView removeFromSuperview];
}

@end
