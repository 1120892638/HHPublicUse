//
//  DJJitter.m
//  动画测试
//
//  Created by admin on 2018/3/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "DJJitter.h"

#define RADIANS(degrees) (((degrees) * M_PI) / 180.0)

@implementation DJJitter

+ (void)startAnimateWithView:(UIView *)view{
    view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-1));
    
    [UIView animateWithDuration:0.10 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^ {
        view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(1));
    } completion:nil];
}

+ (void)stopAnimateWithView:(UIView *)view {
    [UIView animateWithDuration:0.10 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^ {
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
}
@end
