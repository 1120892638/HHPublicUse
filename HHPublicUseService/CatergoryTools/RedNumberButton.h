//
//  RedNumberButton.h
//  MeileTang
//
//  Created by 豆子 on 2019/7/29.
//  Copyright © 2019年 douzi. All rights reserved.
//

#import "MyDefindButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface RedNumberButton : MyDefindButton

//数字
@property (nonatomic,assign) NSInteger redNumber;
//红点
@property (nonatomic,assign) BOOL redTagShow;
//背景颜色
@property (nonatomic,strong) UIColor *redBackColor;

@end

NS_ASSUME_NONNULL_END
