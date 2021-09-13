//
//  UIImage+Luban.h
//  education
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Luban)

+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;

@end
