//
//  CALayer+ToolKit.h
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 *渐变的方向
 */
typedef enum : NSUInteger {
    CALayerGradientLayerDirectionTopToDown,
    CALayerGradientLayerDirectionLeftToRight,
    CALayerGradientLayerDirectionTopLeftToDownRight,
    CALayerGradientLayerDirectionTopRightToDownLeft,
    CALayerGradientLayerDirectionOther
} CALayerGradientLayerDirectionOption;

@interface CALayer (ToolKit)

/**
 *     给 layer 添加一个渐变 layer
 [layer setGradientLayerWithColors:@[ (__bridge id)UIColorFromRGB(0x006AFF).CGColor,(__bridge id)UIColorFromRGB(0x00A8FF).CGColor] layerFrame:frame direction:GCXGradientLayerDirectionTopToDown];
 
 */
+ (CAGradientLayer *)setGradientLayerWithColors:(NSArray *)colors layerFrame:(CGRect)frame direction:(CALayerGradientLayerDirectionOption)direction;

/**
    获取layer上某点的颜色
 */
- (UIColor *)getColorFromPoint:(CGPoint)point;

@end
