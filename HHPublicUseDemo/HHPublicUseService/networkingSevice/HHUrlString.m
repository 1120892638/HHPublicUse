//
//  YJUrlString.m
//  MeileTang
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "HHUrlString.h"

//开发环境
#define HostUrl @"http://test.com"

@implementation HHUrlString

+ (NSString *)testNetUrl{
    return  [NSString stringWithFormat:@"%@%@",HostUrl,@"/test/interface"];
}

@end
