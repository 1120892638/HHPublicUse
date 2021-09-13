//
//  UITextField+ToolKit.h
//  Meet
//
//  Created by 豆子 on 2018/5/21.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ToolKit)

//左间距
@property (nonatomic,assign) CGFloat leftPadding;

//右间距
@property (nonatomic,assign) CGFloat rightPadding;

- (void)setTextFieldPlaceHolder:(NSString *)placeholder holderColor:(UIColor *)color;

@end
