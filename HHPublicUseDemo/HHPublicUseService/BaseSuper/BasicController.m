//
//  BasicController.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "BasicController.h"

@interface BasicController ()

@end

@implementation BasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //默认有阴影
    self.showNavigationShadow = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 这部分使用到的过期api
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)setShowNavigationShadow:(bool)showNavigationShadow{
    _showNavigationShadow = showNavigationShadow;
    if(_showNavigationShadow){
        //1.设置阴影颜色
        self.navigationController.navigationBar.layer.shadowColor = self.shadowColor?self.shadowColor.CGColor:[UIColor grayColor].CGColor;
        //2.设置阴影偏移范围
        self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
        //3.设置阴影颜色的透明度
        self.navigationController.navigationBar.layer.shadowOpacity = 1;
    }else{
        self.navigationController.navigationBar.layer.shadowColor = [UIColor clearColor].CGColor;
    }
}

@end
