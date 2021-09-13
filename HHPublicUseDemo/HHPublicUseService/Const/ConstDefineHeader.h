//
//  ConstDefineHeader.h
//  MeileTang
//
//  Created by admin on 2019/6/17.
//  Copyright © 2019 douzi. All rights reserved.
//

#ifndef ConstDefineHeader_h
#define ConstDefineHeader_h

#import "GlobalModel.h"

//支持横屏的情况
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

//设置随机颜色
#define RANDOW_COLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//RGB颜色设置
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//RGBA颜色设置
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//自定义高效率的Log
#ifdef DEBUG
#define HHLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define HHLog(...)

#endif

//弱饮用/强引用
#define HHWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HHStrongSelf(type)  __strong typeof(type) type = weak##type;

//设置view的圆角、边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//角度转换弧度     弧度转换角度
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//设置坐标
#define Setframe(x,y,width,height) CGRectMake(x, y, width, height)

#define KWindow [[UIApplication sharedApplication].delegate window]

//状态栏的高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//导航栏高度
#define NavigationHeight (float)([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

//底部tabbar高度  适配iphoneX
#define TabbarHeight (float)([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//读取本地图片
#define Load_Image(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//对象是否为空
#define ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//如果release状态就不执行NSLog函数
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

//App版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define HexString(obj) [GlobalModel colorWithHexString:obj]

#define HexStringPercent(obj,alphaValue) [GlobalModel colorWithHexString:obj alpha:alphaValue]

#define HexStringA(hexValue,alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]

#define is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为刘海屏
#define is_iPhone_X  [GlobalModel isNotchScreen]

//弹框半透明背景颜色
#define KWindowColor [UIColor colorWithWhite:0.1 alpha:0.5]

//字体设置
#define MyFont(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]

//appdelegate对象
#define HHAppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

//字体名称
#define Font_Regular @"PingFangSC-Regular"

#define Font_Medium @"PingFangSC-Medium"

#define Font_Bold @"PingFangSC-Semibold"

#define Str_Obj(obj) [NSString stringWithFormat:@"%@",obj]

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* ConstDefineHeader_h */
