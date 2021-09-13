//
//  UIView+ViewCayegory.h
//  FriendBlood
//
//  Created by 豆子 on 17/4/21.
//  Copyright © 2017年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewCayegory)

@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat bottom;

@property (nonatomic,assign) CGFloat right;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

@property (nonatomic,assign) CGSize size;

//Method

//移除所有子视图
- (void)removeAllSubviews;

/**
  *  视图旋转动画
  *  isAsTimeDirection = yes 表示顺时针  为no逆时针旋转
 */
- (void)startRotateAnimation:(BOOL)isAsTimeDirection;
- (void)stopRotateAnimation;
- (BOOL)isRotateAnimation;

/**
 *  视图闪烁
 *  duration --- 动画周期时长
 */

- (void)startFlashAnimation:(CGFloat)duration;
- (void)stopFlashAnimation;
- (BOOL)isFlashAnimation;

//视图中某个位置的颜色
- (UIColor *) colorOfPoint:(CGPoint)point;

/**
 
 * 添加阴影
 *
 
 */
- (void)addLayerShadowOfColor:(UIColor *)shadowColor withOpacity:(CGFloat)Opacity withRadius:(CGFloat)Radius withSize:(CGSize)size;

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

//添加毛玻璃效果 alpha 0-1
- (UIVisualEffectView *)addBlurEffectWithAlpha:(CGFloat)alpha;

@end
