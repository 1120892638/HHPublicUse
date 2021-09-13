//
//  UIImage+ToolKit.h
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Accelerate/Accelerate.h>
#import "CALayer+ToolKit.h"

@interface UIImage (ToolKit)

//模糊效果
- (UIImage *)applySubtleEffect;
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
//高斯模糊
- (UIImage *)applyGaussianBlur:(CGFloat)blurLevel;

//图片复制
+ (UIImage *)imageDeepCopy:(UIImage *)imageToCopy;

//将view生成image
+ (UIImage *)imageWithView:(UIView *)view;

//修改tintcolor
- (UIImage *)imageBorderWithTintColor:(UIColor *)tintColor;

//设置边框和边框颜色
- (UIImage *)imageWithBorderColor:(UIColor *)borderColor width:(CGFloat)width;

//旋转90度
- (UIImage *)rotate90Clockwise;

//翻转
- (UIImage *)flipHorizontal;

//根据颜色获取图片
+ (UIImage*)imageWithColor:(UIColor*)color;

//生成二维码图片 数据源字符串 -- 图片尺寸  -- 是否返回高清图

+ (UIImage *)createNoramlCodeImageWithDic:(NSDictionary *)dic withImageSize:(CGSize)size isInterpolated:(BOOL)isInterpolated;

+ (UIImage *)createNoramlCodeImageWithString:(NSString *)dataStr withImageSize:(CGSize)size isInterpolated:(BOOL)isInterpolated;

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

/**
 生成一张渐变色的图片
 @param colors 颜色数组
 @param rect 图片大小
 @return 返回渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect direction:(CALayerGradientLayerDirectionOption)direction;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */

- (NSData *)reSizeImageDataMaxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

//图片压缩 单位为b  效果很好
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;

//vImage高斯模糊
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
