//
//  MyPickerView.m
//  utravel
//
//  Created by 豆子 on 2018/6/23.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "MyPickerView.h"
#import "ConstDefineHeader.h"
#import "UIView+ViewCayegory.h"
#import "ViewInstance.h"

#define PickerHeight (256 + (is_iPhone_X?34:0))

@interface MyPickerView(){
    
    NSInteger _selectIndex;
    
    UIView *_content;
    
    NSString *_title;
    
    NSInteger _type;
    
}

@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation MyPickerView

//单选控件
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title pickerArray:(NSArray *)pickerArr{
    
    if (self = [super initWithFrame:frame]) {
        
        _title = title;
        _pickerArr= pickerArr;
        _selectIndex = 0;
        
        self.backgroundColor = KWindowColor;
        
        [self defindPickerContentWithType:0];
        
        [self showAction];
        
    }
    
    return self;
    
}

//日期选择控件
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title{
    
    if (self = [super initWithFrame:frame]) {
        
        _title = title;
        
        self.backgroundColor = KWindowColor;
        
        [self defindPickerContentWithType:1];
        
        [self showAction];
        
    }
    
    return self;
    
}

//type=2 时间
- (instancetype)initWithFrame:(CGRect)frame tipText:(NSString *)title withType:(NSInteger)type withDate:(NSDate*)date{
    
    if (self = [super initWithFrame:frame]) {
        
        _title = title;
        
        self.date = date;
        
        self.backgroundColor = KWindowColor;
        
        [self defindPickerContentWithType:type];
        
        [self showAction];
        
    }
    
    return self;
    
}

- (void)defindPickerContentWithType:(NSInteger)type{
    
    _type = type;
    
    UIView *content = [[UIView alloc] initWithFrame:Setframe(0, self.height, SCREEN_WIDTH, PickerHeight)];
    [self addSubview:content];
    content.backgroundColor = HexString(@"f2f2f2");
    _content = content;
    
    UIButton *cancle = [ViewInstance defindButOnlyTileWithFrame:Setframe(0, 0, 70, 40) title:@"取消" titleColor:HexString(@"#373A3E") titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [content addSubview:cancle];
    [cancle addTarget:self action:@selector(cancleAction) forControlEvents:1<<6];
    
    UIButton *sure = [ViewInstance defindButOnlyTileWithFrame:Setframe(content.width-70, 0, 70, 40) title:@"确定" titleColor:[UIColor yellowColor] titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [content addSubview:sure];
    [sure addTarget:self action:@selector(sureAction) forControlEvents:1<<6];
    
    UILabel *title = [ViewInstance defindLabelWithFrame:Setframe(cancle.right + 10, 0, sure.x-cancle.right-20, 40) text:_title textColor:HexString(@"#373A3E") textAlignment:NSTextAlignmentCenter font:[UIFont fontWithName:@"PingFangSC-Medium" size:15]];
    [content addSubview:title];
    
    if (type == 0) {
        
        //单选
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:Setframe(0, 40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        [content addSubview:picker];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self;
        picker.dataSource = self;
        
    }else if (type == 1){
        
        //选择日期
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:Setframe(0, 40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        if (self.date) {
            picker.date = self.date;
        }
        if (@available(iOS 13.4, *)) {
            picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        [picker setFrame:CGRectMake(0,40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        [content addSubview:picker];
        self.datePicker = picker;
        
    }else if (type == 2){
        
        //选择时间
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:Setframe(0, 40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        picker.datePickerMode = UIDatePickerModeTime;
        picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        if (self.date) {
            picker.date = self.date;
        }
        if (@available(iOS 13.4, *)) {
            picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        [picker setFrame:CGRectMake(0,40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        [content addSubview:picker];
        self.datePicker = picker;
        
    }else if (type == 3){
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:Setframe(0, 40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        
        picker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        if (self.date) {
            picker.date = self.date;
        }
        if (@available(iOS 13.4, *)) {
            picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        [picker setFrame:CGRectMake(0,40, content.width, PickerHeight-40-(is_iPhone_X?34:0))];
        [content addSubview:picker];
        self.datePicker = picker;
    }
    
}

- (void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    self.datePicker.maximumDate = _maxDate;
}

- (void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    self.datePicker.minimumDate = _minDate;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return _pickerArr.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return _pickerArr[row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _selectIndex = row;
    
}

- (void)cancleAction{
    
    [self hiddenAction];
    
}

- (void)sureAction{
    
    if (_type == 0 && _pickerArr.count > 0) {
        
        NSString *text = [_pickerArr objectAtIndex:_selectIndex];
        
        if (self.pickerSelectBlock && text.length > 0) {
            
            self.pickerSelectBlock(text);
            
        }
        
    }else if (_type == 1){
        
        NSDate *selectDate = self.datePicker.date?self.datePicker.date:[NSDate date];
        
        NSString *dateString = [[GlobalModel wholeDateFormmatter] stringFromDate:selectDate];
        
        if (self.pickerSelectBlock && dateString.length > 0) {
            
            self.pickerSelectBlock(dateString);
            
        }
        
    }else if (_type == 2){
        
        NSDate *selectDate = self.datePicker.date?self.datePicker.date:self.date;
        
        NSString *dateString = [[GlobalModel dateFormHourMinute] stringFromDate:selectDate];
        
        if (self.pickerSelectBlock && dateString.length > 0) {
            
            self.pickerSelectBlock(dateString);
            
        }
        
    }else if (_type == 3){
        NSDate *selectDate = self.datePicker.date?self.datePicker.date:self.date;
        
        NSString *dateString = [[GlobalModel dateFormYMDHourMinute] stringFromDate:selectDate];
        
        if (self.pickerSelectBlock && dateString.length > 0) {
            
            self.pickerSelectBlock(dateString);
            
        }
    }
    
    [self hiddenAction];
    
}

- (void)hiddenAction{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_content.y = _content.y+PickerHeight;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

- (void)showAction{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_content.y = _content.y-PickerHeight;
        
    }];
    
}

@end
