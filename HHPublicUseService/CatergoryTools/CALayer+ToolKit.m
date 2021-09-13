//
//  CALayer+ToolKit.m
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "CALayer+ToolKit.h"

@implementation CALayer (ToolKit)

+ (CAGradientLayer *)setGradientLayerWithColors:(NSArray *)colors layerFrame:(CGRect)frame direction:(CALayerGradientLayerDirectionOption)direction {
    
    CAGradientLayer * layer = [CAGradientLayer layer];
    layer.frame    = frame;
    layer.colors = colors;
    CGPoint  start = CGPointMake(0.5, 0);
    CGPoint end = CGPointMake(0.5, 1);
    
    switch (direction) {
        case CALayerGradientLayerDirectionTopToDown:
        {
            //            start = CGPointMake(0.5, 0);
            //            end = CGPointMake(0.5, 1);
        }
            break;
        case CALayerGradientLayerDirectionLeftToRight:
        {
            start = CGPointMake(0, 0.5);
            end = CGPointMake(1, 0.5);
        }
            break;
        case CALayerGradientLayerDirectionTopLeftToDownRight:
        {
            start = CGPointMake(0, 0);
            end = CGPointMake(1, 1);
        }
            break;
        case CALayerGradientLayerDirectionTopRightToDownLeft:
        {
            start = CGPointMake(1, 0);
            end = CGPointMake(0, 1);
        }
            break;
        case CALayerGradientLayerDirectionOther:
        {
            //            start = CGPointMake(0.5, 0);
            //            end = CGPointMake(0.5, 1);
        }
            break;
            
        default:
            break;
    }
    
    layer.startPoint = start;
    layer.endPoint   = end;
    return layer;
}

- (UIColor *)getColorFromPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
