//
//  NSData+AES256.h
//  Meet
//
//  Created by 豆子 on 2018/4/27.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

//AES加密
- (NSData *)AES256EncryptWithKey:(NSString *)key;

//AES解密
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
