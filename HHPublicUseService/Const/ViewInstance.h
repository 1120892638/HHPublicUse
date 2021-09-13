//
//  ViewInstance.h
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "EaseTextView.h"

@interface ViewInstance : NSObject

/**
 创建label
 */
+ (UILabel *)defindLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font;

/**
 创建button
 */
+ (UIButton *)defindButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;

//只有标题的按钮
+ (UIButton *)defindButOnlyTileWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;

//只有图片的按钮
+ (UIButton *)defindButOnlyImageWithFrame:(CGRect)frame image:(UIImage *)image;


/**
 创建imageView
 */
+ (UIImageView *)defindImageViewWithFrame:(CGRect)frmae image:(UIImage *)image;

/**
 创建一个view
 */
+ (UIView *)defindViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

/**
 *  创建一个textView
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor;

/**
 *  创建一个textView(重载)
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 *  创建一个textField
 */
+ (UITextField *)defindTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

/**
 *  创建一个textField
 */
+ (UITextField *)defindColorTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeColor:(UIColor *)color;

/**
 *  创建分割线
 */
+ (UILabel *)defindLinelWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor;

@end
