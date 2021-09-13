//
//  BasicController.h
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicController : UIViewController

//是否显示阴影
@property (nonatomic,assign) BOOL showNavigationShadow;
//阴影颜色  默认grayColor
@property (nonatomic,strong) UIColor *shadowColor;

@end

NS_ASSUME_NONNULL_END
