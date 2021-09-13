//
//  UIViewController+ToolKit.h
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ToolKit)

//导航栏设置

@property (nonatomic,strong) UIColor *naviBackColor;

@property (nonatomic,strong) UIColor *tintColor;

@property (nonatomic,strong) UIColor *titleTextColor;

@property (nonatomic,assign) BOOL   havingRules;
/**
 *  naviBackColor -- 导航栏背景颜色
 *  tintColor     -- naviItem的颜色
 *  titleTextColor-- 导航栏标题颜色
 */
- (void)setNaviBarWithBackColor:(UIColor *)naviBackColor withNaviTintColor:(UIColor *)tintColor withTitleColor:(UIColor *)titleTextColor;

+ (UIViewController *)topPresentedViewController;

+ (UIViewController *)getCurrentVC;

@end
