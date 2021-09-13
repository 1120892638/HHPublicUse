//
//  ViewInstance.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "ViewInstance.h"
#import "ConstDefineHeader.h"
#import "UITextField+ToolKit.h"

@implementation ViewInstance

/**
 创建label
 */
+ (UILabel *)defindLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text?text:nil;
    label.textColor = textColor?textColor:nil;
    label.textAlignment = alignment;
    label.font = font?font:nil;
    return label;    
}

/**
 创建button
 */
+ (UIButton *)defindButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor titleFont:(UIFont *)font{
    UIButton *but = [[UIButton alloc] initWithFrame:frame];
    [but setImage:image forState:UIControlStateNormal];
    [but setTitle:title?title:nil forState:UIControlStateNormal];
    [but setTitleColor:titleColor?titleColor:nil forState:UIControlStateNormal];
    but.titleLabel.font = font?font:nil;
    return but;
}
//只有标题的按钮
+ (UIButton *)defindButOnlyTileWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font{
    UIButton *but = [[UIButton alloc] initWithFrame:frame];
    [but setTitle:title?title:nil forState:UIControlStateNormal];
    [but setTitleColor:titleColor?titleColor:nil forState:UIControlStateNormal];
    but.titleLabel.font = font?font:nil;
    return but;    
}
//只有图片的按钮
+ (UIButton *)defindButOnlyImageWithFrame:(CGRect)frame image:(UIImage *)image{
    UIButton *but = [[UIButton alloc] initWithFrame:frame];
    [but setImage:image forState:UIControlStateNormal];
    return but;
}

/**
 创建imageView
 */
+ (UIImageView *)defindImageViewWithFrame:(CGRect)frmae image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frmae];
    imageView.image = image;
    return imageView;    
}

/**
 创建一个view
 */
+ (UIView *)defindViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;    
}

/**
 *  创建一个textView
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor{
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:frame];
    textView.frame = frame;
    textView.placeHolder = placeHolder;
    textView.placeHolderTextColor = placeHolderColor;
    return textView;    
}

/**
 *  创建一个textView(重载)
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:frame];
    textView.frame = frame;
    textView.text = text?text:nil;
    textView.textColor = textColor?textColor:nil;
    textView.font = font?font:nil;
    return textView;    
}

/**
 *  创建一个textField
 */
+ (UITextField *)defindTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setTextFieldPlaceHolder:placeHolder holderColor:HexString(@"#BDBDBD")];
    return textField;    
}

/**
 *  创建一个textField
 */
+ (UITextField *)defindColorTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeColor:(UIColor *)color{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setTextFieldPlaceHolder:placeHolder holderColor:color];
    return textField;
}

/**
 *  创建分割线
 */
+ (UILabel *)defindLinelWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor{
    UILabel *line = [[UILabel alloc] initWithFrame:frame];
    line.backgroundColor = backGroundColor?backGroundColor:nil;
    return line;
}

@end
