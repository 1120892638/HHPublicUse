//
//  UITextField+ToolKit.m
//  Meet
//
//  Created by 豆子 on 2018/5/21.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "UITextField+ToolKit.h"

@implementation UITextField (ToolKit)

@dynamic leftPadding;
@dynamic rightPadding;

- (void)setLeftPadding:(CGFloat)leftPadding{
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 0)];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)setRightPadding:(CGFloat)rightPadding{
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightPadding, 0)];
    
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)setTextFieldPlaceHolder:(NSString *)placeholder holderColor:(UIColor *)color{
    
    self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:color}];
    
}

@end
