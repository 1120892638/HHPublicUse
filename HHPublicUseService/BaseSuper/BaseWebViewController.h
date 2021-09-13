//
//  BaseWebViewController.h
//  Meet
//
//  Created by 豆子 on 2018/5/2.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "BasicController.h"

#import <WebKit/WebKit.h>

@interface BaseWebViewController : BasicController

@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) UIColor *progressColor;

@property (nonatomic,strong) NSString *urlString;

@end
