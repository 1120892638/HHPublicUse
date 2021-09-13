//
//  UIViewController+ToolKit.m
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "UIViewController+ToolKit.h"
#import "UIImage+ToolKit.h"

@implementation UIViewController (ToolKit)

@dynamic naviBackColor;
@dynamic tintColor;
@dynamic titleTextColor;

+ (UIViewController *)topPresentedViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *viewController = keyWindow.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)setNaviBarWithBackColor:(UIColor *)naviBackColor withNaviTintColor:(UIColor *)tintColor withTitleColor:(UIColor *)titleTextColor{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviBackColor] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = tintColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor}];
    
}

- (void)setNaviBackColor:(UIColor *)naviBackColor{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviBackColor] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setTintColor:(UIColor *)tintColor{
    
    self.navigationController.navigationBar.tintColor = tintColor;
    
}

- (void)setHavingRules:(BOOL)havingRules{
    
    if (havingRules) {
        [self.navigationController.navigationBar  setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
    }else{
        [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    

    
}

- (void)setTitleTextColor:(UIColor *)titleTextColor{
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor}];
    
}

@end
