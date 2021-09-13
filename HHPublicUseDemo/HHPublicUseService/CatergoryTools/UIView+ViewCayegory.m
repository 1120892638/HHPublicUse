//
//  UIView+ViewCayegory.m
//  FriendBlood
//
//  Created by 豆子 on 17/4/21.
//  Copyright © 2017年 豆子. All rights reserved.
//

#import "UIView+ViewCayegory.h"

@implementation UIView (ViewCayegory)

@dynamic x;

@dynamic y;

@dynamic width;

@dynamic height;

@dynamic right;

@dynamic bottom;

@dynamic size;

- (CGFloat)x{
    
    return self.frame.origin.x;
    
}

- (void)setX:(CGFloat)x{
    
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    
}

- (CGFloat)y{
    
    return self.frame.origin.y;
    
}

- (void)setY:(CGFloat)y{
    
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
    
}

- (CGFloat)width{
    
    return self.frame.size.width;
    
}

- (void)setWidth:(CGFloat)width{
    
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    
}

- (CGFloat)height{
    
    return self.frame.size.height;
    
}

- (void)setHeight:(CGFloat)height{
    
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    
}

- (CGFloat)right{
    
    return CGRectGetMaxX(self.frame);
    
}

- (CGFloat)bottom{
    
    return CGRectGetMaxY(self.frame);
    
}

- (CGFloat)centerX{
    
    return self.center.x;
    
}

- (CGFloat)centerY{
    
    return self.center.y;
    
}

- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    self.width = size.width;
    self.height = size.height;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

#pragma mark - rotate animation
- (void)startRotateAnimation:(BOOL)isAsTimeDirection{
    if (![self.layer animationForKey:@"rotationAnimation"]) {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * (isAsTimeDirection?1:-1)];
        rotationAnimation.duration = 1.0;
        rotationAnimation.cumulative = NO;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.repeatCount = HUGE_VALF;
        [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}
- (void)stopRotateAnimation{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}
- (BOOL)isRotateAnimation{
    if (![self.layer animationForKey:@"rotationAnimation"])
        return NO;
    if (self.layer.speed == 0.0)
        return NO;
    return YES;
}

#pragma mark - flash animation
- (void)startFlashAnimation:(CGFloat)duration{
    if (![self.layer animationForKey:@"flashAnimation"]) {
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue=[NSNumber numberWithFloat:1.0];
        animation.toValue=[NSNumber numberWithFloat:0.0];
        animation.autoreverses=YES;
        animation.duration=duration;
        animation.repeatCount=FLT_MAX;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        [self.layer addAnimation:animation forKey:@"flashAnimation"];
    }
    
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
}
- (void)stopFlashAnimation{
    self.layer.speed = 0.0;
}
- (BOOL)isFlashAnimation{
    if (![self.layer animationForKey:@"flashAnimation"])
        return NO;
    if (self.layer.speed == 0.0)
        return NO;
    return YES;
}

- (UIColor *) colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}


#pragma mark 添加阴影
- (void)addLayerShadowOfColor:(UIColor *)shadowColor withOpacity:(CGFloat)Opacity withRadius:(CGFloat)Radius withSize:(CGSize)size{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = Opacity;
    self.layer.shadowRadius = Radius;
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

//添加毛玻璃效果 
- (UIVisualEffectView *)addBlurEffectWithAlpha:(CGFloat)alpha{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    effectView.frame = self.bounds;
    effectView.alpha = alpha;
    [self addSubview:effectView];
    [self sendSubviewToBack:effectView];
    return effectView;
    
}

@end
