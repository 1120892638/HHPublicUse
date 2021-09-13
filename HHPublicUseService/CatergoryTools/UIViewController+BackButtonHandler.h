//
//  UIViewController+BackButtonHandler.h
//  Meet
//
//  Created by 豆子 on 2018/6/10.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)navigationShouldPopOnBackButton;
@end


//只可拦截到系统返回和侧滑动作
@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
