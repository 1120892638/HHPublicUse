//
//  GlobalModel.h
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void (^SelectBlock)(void);

typedef void (^CancleBlock)(void);

@interface GlobalModel : NSObject

//根据颜色获取图片
+ (UIImage*) imageWithColor:(UIColor*)color;

+ (BOOL)isNum:(id)obj;

//自适应宽度
+ (CGFloat)returnSieByLabelText:(NSString *)text withlabelFont:(NSInteger)fontOfLab;

//自适应高度
+ (CGFloat)returnSieHeightWithText:(NSString *)text withCGSzie:(CGSize)size withTextFont:(CGFloat)fontNum;

//带有行间距计算高度
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGSize)maxSize withLineSpace:(CGFloat)lineSpace;

//给label设置行距和字距
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withKernSpace:(CGFloat)kernSpace;

//设置行间距
+ (NSMutableParagraphStyle *)settingLabelLineSpacing:(CGFloat)lineSpace;

/**
 提示语
 提示时间3s
 只显示内容
 */

+ (void)showTipToView:(UIView *)view andTipText:(NSString *)text;
+ (void)showWhiteTipToView:(UIView *)view andTipText:(NSString *)text;
/**
 提示语
 只显示菊花
 */

+ (void)showActivityToView:(UIView *)view;

//使提示消失

+ (void)dismissMBProgressHUDFromView:(UIView *)view;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 获取已date为节点n天之前的日期
 @parame n 多少天之前
 date 时间节点
 
 */

+ (NSString *)getPastNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm;

/**
 获取已date为节点n天之后的日期
 @parame n 多少天之后
 date 时间节点
 
 */
+ (NSString *)getFutureNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm;

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

//全局时间日期格式 yyyy-MM-dd

+ (NSDateFormatter *)wholeDateFormmatter;

//HH:mm
+ (NSDateFormatter *)dateFormHourMinute;

//yyyy-MM-dd HH:mm
+ (NSDateFormatter *)dateFormYMDHourMinute;

+ (void)setUpLayerrPropertyWithView:(UIView *)view withCornerRadius:(CGFloat)cornerRadius withBorderWidth:(CGFloat)borderWidth withBoderColor:(UIColor *)borderColor;

//获取当前时间日期星期
+ (NSString *)getCurrentTimeAndWeekDay;

//根据不同mol值设置不同字体颜色
+ (UIColor *)accordingDifferenceMolToChangeLabelColorWithMol:(CGFloat)mol withTimeIndex:(NSInteger)index;


/**
 系统弹框
 */
+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message alertStyle:(UIAlertControllerStyle)style actionTitle:(NSString *)actionTitle cancelActionTitle:(NSString *)cancelTitle selectBlock:(SelectBlock)selectBlock cancleBlock:(CancleBlock)cancleBlock;

/**
 获取当前视图的控制器
 
 @return 控制器
 */
+ (UIViewController*)getCurrentViewController:(UIView *)view;



/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

//实用的常用公共方法

/**
 获取磁盘总空间大小
 */
+ (CGFloat)diskOfAllSizeMBytes;

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes;

//获取指定路径下某个文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;

//获取字符串(或汉字)首字母 --- 返回大写字母
+ (NSString *)firstCharacterWithString:(NSString *)string;

//将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;

//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format;

//获取指定时间与当前时间的时间差
+ (NSInteger)timeIntervalFromActivityTime:(NSString *)activityTime;

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

//利用正则表达式验证
+ (BOOL)isAvailableEmail:(NSString *)email;

//Avilable in iOS 8.0 and later -- 毛玻璃效果的view
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame withEffectStyle:(UIBlurEffectStyle)effectStyle;

//全屏截图
+ (UIImage *)shotScreen;

//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view;

//截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

//判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;

//判断字符串中是否全部为数字
+ (BOOL)isAllNum:(NSString *)string;

/*
 ** 绘制虚线
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

/**
 *  创建一个倒计时
 *  count  -  倒计时多少秒(int)
 *  running - 返回还剩多少秒
 *  finish - 倒计时完毕
 */
+ (dispatch_source_t)defindCountDownWithTimeCount:(int)count running:(void(^)(NSString *restTime))running finish:(void(^)(void))finish;

/**
 *  获取当前window顶层的控制器
 */
+ (UIViewController*)topViewController;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

//判断两个日期的大小
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//获取整个app缓存大小
+ (CGFloat)folderSize;

//清除缓存
+ (void)removeCache:(void (^) (BOOL success))success;

//高德天气判断
+ (NSString *)weatherImageWithState:(NSString *)state withPageType:(NSInteger)type;

//拨打电话
+ (void)callPhoneWithPhoneStr:(NSString *)tel;

/**
 *  返回截取屏幕的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot;

/**
 *  并发执行完毕后处理逻辑（如多个网络请求完成之后再刷新UI）
 *  num---需要并发操作的数量
 *  block---传出循环个数i以及并发队列group
 *  notiBlock---所有的并发操作完成之后通知主线程操作
 *  需注意、在实现block时需要主动调用dispatch_group_leave、因为此方法的循环中是有调用dispatch_group_enter的。需一一对应才会回调notiBlock
 */

+ (void)handleMutipleNetworkWithNumber:(int)num block:(void (^) (int i,dispatch_group_t group))block notiBlock:(void (^) (void))notiBlock;

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)isNotchScreen;

//判断文件是否已经在沙盒中已经存在？
+ (BOOL)isFileExist:(NSString *)fileName;

//不能输入特殊字符
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;

//判断长度大于6位后再接着判断是否同时包含数字和大小写字母
+ (BOOL)judgePassWordLegal:(NSString *)pass;

//用户名为6-16位字母加数字组成
+ (NSString *)verifyUserName:(NSString *)userName;

//密码为6-32为数字与字母组成
+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName;

/*
 *  处理小数点、price（doubel）。position（保留小数点后几位）。进位或降位修改model即可
 */
-(NSString *)stringByNotRounding:(double)price afterPoint:(int)position;

//改变文字颜色及大小
+ (NSMutableAttributedString *)changeTextColorFont:(NSString *)str char:(NSString *)charStr color:(UIColor *)color font:(UIFont *)font;

//改变文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeTextBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor color:(UIColor *)color font:(UIFont *)font;

//改变3个不同文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeThreeBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor char2:(NSString *)charStr2 bgColor2:(UIColor *)bgColor2 color:(UIColor *)color font:(UIFont *)font;

//添加图标
+ (NSMutableAttributedString *)addPullDownIcon:(NSString *)value color:(UIColor *)color;

//添加标签
+ (NSMutableAttributedString *)addLabelsIcon:(NSString *)value img:(UIImage *)img;

//h5转富文本
+ (NSMutableAttributedString *)ChangeToNSMutableAttributedString:(NSString *)contentStr;

// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString*)idCard;

//是否安装了QQ
+ (BOOL)isQQ;
//是否安装了微信
+ (BOOL)isWX;
//是否安装了新浪微博
+ (BOOL)isSina;

//图片添加水印
+ (UIImage *)waterMarkedImage:(UIImage *)img;

/**
 添加本地推送
 */
+ (void)addLocalNotification:(NSString *)schId time:(NSString *)schTime type:(int)type;
/**
 修改本地推送
 */
+ (void)updateLocalNotification:(NSString *)schId time:(NSString *)schTime type:(int)type;
/**
 删除本地推送
 */
+ (void)deleteLocalNotification;

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string;
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;
//去除表情
+ (NSString *)disableEmoji:(NSString *)text;
@end
