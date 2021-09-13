//
//  UITabBar+RedBadgeBar.h
//  utravel
//
//  Created by 豆子 on 2018/8/20.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedBadgeBar)

- (void)showBadgeOnItemIndex:(int)index;//显示小红点

- (void)hideBadgeOnItemIndex:(int)index;//隐藏小红点

@end
