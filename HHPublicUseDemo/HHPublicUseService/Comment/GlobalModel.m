//
//  GlobalModel.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "GlobalModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ConstDefineHeader.h"

@implementation GlobalModel

//根据颜色获取图片
+ (UIImage*) imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (BOOL)isNum:(id)obj{
    if ([obj isKindOfClass:[NSNull class]] || [obj class] == NULL) {
        return YES;
    }
    return NO;
}

//自适应宽度
+ (CGFloat)returnSieByLabelText:(NSString *)text withlabelFont:(NSInteger)fontOfLab{
    CGSize labelSize=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont  systemFontOfSize:fontOfLab]}];
    return labelSize.width;
}

//自适应高度
+ (CGFloat)returnSieHeightWithText:(NSString *)text withCGSzie:(CGSize)size withTextFont:(CGFloat)fontNum{
    
    if ([text isKindOfClass:[NSNull class]] || text.length == 0) {
        
        return 0;
        
    }
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin  |  NSStringDrawingUsesFontLeading attributes:[ NSDictionary  dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontNum], NSFontAttributeName ,  nil ] context:nil];
    return rect.size.height;
}

//带有行间距计算高度
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGSize)maxSize withLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

//设置行间距
+ (NSMutableParagraphStyle *)settingLabelLineSpacing:(CGFloat)lineSpace{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    return paraStyle;
    
}

//给label设置行距和字距
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withKernSpace:(CGFloat)kernSpace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kernSpace)
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

/**
 提示语
 提示时间3s
 只显示内容
 */

+ (void)showTipToView:(UIView *)view andTipText:(NSString *)text{
    
    //先使其她的提示框全消失
    [self dismissMBProgressHUDFromView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 2;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3.0f];
    hud.userInteractionEnabled = NO;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoom;
    
}

+ (void)showWhiteTipToView:(UIView *)view andTipText:(NSString *)text{
    
    //先使其她的提示框全消失
    [self dismissMBProgressHUDFromView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 2;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3.0f];
    hud.userInteractionEnabled = YES;
    hud.bezelView.color = [UIColor whiteColor];
    hud.label.textColor = HexString(@"#333333");
    hud.label.font = MyFont(Font_Regular, 21);
    hud.animationType = MBProgressHUDAnimationZoom;
    
}

/**
 提示语
 只显示菊花
 */

+ (void)showActivityToView:(UIView *)view{
    
    //先使其她的提示框全消失
    [self dismissMBProgressHUDFromView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = YES;//设置在此view上是否可点击
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
}

//使提示消失

+ (void)dismissMBProgressHUDFromView:(UIView *)view{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

//获取n天之前的日期
+ (NSString *)getPastNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm{
    
    NSDate *nowDate = date;
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneDay = -24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeInterval:oneDay*n sinceDate:date];
        
    }else{
        
        theDate = nowDate;
        
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    
    [date_formatter setDateFormat:dateForm];
    
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}

//获取n天之后的日期
+ (NSString *)getFutureNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm{
    
    NSDate *nowDate = date;
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeInterval:oneDay*n sinceDate:date];
        
    }else{
        
        theDate = nowDate;
        
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    
    [date_formatter setDateFormat:dateForm];
    
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}

//全局时间日期格式 yyyy-MM-dd

+ (NSDateFormatter *)wholeDateFormmatter{
    
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    
    dateform.dateFormat = @"yyyy-MM-dd";
    
    return dateform;
    
}

+ (NSDateFormatter *)dateFormHourMinute{
    
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    
    dateform.dateFormat = @"HH:mm";
    
    return dateform;
    
}

+ (NSDateFormatter *)dateFormYMDHourMinute{
    
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    
    dateform.dateFormat = @"yyyy-MM-dd HH:mm";
    
    return dateform;
    
}

+ (void)setUpLayerrPropertyWithView:(UIView *)view withCornerRadius:(CGFloat)cornerRadius withBorderWidth:(CGFloat)borderWidth withBoderColor:(UIColor *)borderColor{
    
    view.layer.cornerRadius = cornerRadius;
    
    view.layer.borderWidth = borderWidth;
    
    view.layer.borderColor = borderColor.CGColor;
    
    view.layer.masksToBounds = YES;
    
}

//获取当前时间日期星期
+ (NSString *)getCurrentTimeAndWeekDay {
    NSArray * arrWeek = [NSArray arrayWithObjects:@"星期日", @"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    /*
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     */
    //ios 8.0 之后 不想看见警告用下面这个
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    /*
     NSInteger unitFlags = NSYearCalendarUnit |
     NSMonthCalendarUnit |
     NSDayCalendarUnit |
     NSWeekdayCalendarUnit |
     NSHourCalendarUnit |
     NSMinuteCalendarUnit |
     NSSecondCalendarUnit;
     */
    //ios 8.0 之后 不想看见警告用下面这个
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
//    int year=[comps year];
//    int month = [comps month];
//    int day = [comps day];
    return  [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
}

//根据不同mol值设置不同字体颜色
+ (UIColor *)accordingDifferenceMolToChangeLabelColorWithMol:(CGFloat)mol withTimeIndex:(NSInteger)index{
    NSInteger tag = 0;
    if (index == 0) {
        //表示空腹
        tag = 0;
    }else{
        tag = 1;
    }
    
    if (mol < 4.4) {
        
        return [self colorWithHexString:@"#2A2727"];
        
    }else if (tag == 0 && mol >=6.1){
        
        return [self colorWithHexString:@"#F44336"];
        
    }else if (tag == 1 && mol >= 7.8){
        
        return [self colorWithHexString:@"#F44336"];
        
    }else{
        
        return [self colorWithHexString:@"#2CAF61"];
        
    }
    
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message alertStyle:(UIAlertControllerStyle)style actionTitle:(NSString *)actionTitle cancelActionTitle:(NSString *)cancelTitle selectBlock:(SelectBlock)selectBlock cancleBlock:(CancleBlock)cancleBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    //    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:message];
    //    [titleText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:15] range:NSMakeRange(0, message.length)];
    //    [titleText addAttribute:NSForegroundColorAttributeName value:HexString(@"3d3d3d") range:NSMakeRange(0, message.length)];
    //    [alert setValue:titleText forKey:@"attributedMessage"];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        selectBlock();
        
    }];
    //    [action1 setValue:HexString(@"3d3d3d") forKey:@"titleTextColor"];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        cancleBlock();
        
    }];
    
    //    [action2 setValue:HexString(@"ffb132") forKey:@"titleTextColor"];
    
    
    [alert addAction:action1];
    
    [alert addAction:action2];
    
    return alert;
    
}

/**
 获取当前视图的控制器
 
 @return 控制器
 */
+ (UIViewController*)getCurrentViewController:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


//磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

//获取文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

//将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array{
    if (array.count == 0) {
        return nil;
    }
    for (id obj in array) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    //创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    //按字母顺序进行分组
    NSInteger lastIndex = -1;
    for (int i = 0; i < array.count; i++) {
        NSInteger index = [indexedCollation sectionForObject:array[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:array[i]];
        lastIndex = index;
    }
    //去掉空数组
    for (int i = 0; i < objects.count; i++) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    //获取索引字母
    for (NSMutableArray *obj in objects) {
        NSString *str = obj[0];
        NSString *key = [self firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    return dic;
}

//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

//获取当前时间
+ (NSInteger)timeIntervalFromActivityTime:(NSString *)activityTime{
    //日期格式化格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //当前时间
    NSDate *currentTime = [NSDate date];
    NSString *nowDateStr = [dateFormatter stringFromDate:currentTime];
    currentTime = [dateFormatter dateFromString:nowDateStr];
    //截止时间
    NSDate *expireDate = [dateFormatter dateFromString:activityTime];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [expireDate dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:expireDate]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [lastDate timeIntervalSinceReferenceDate] - [currentDate timeIntervalSinceReferenceDate];
    
    return intevalTime;
}

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
                     currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [self timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

//利用正则表达式验证
+ (BOOL)isAvailableEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame withEffectStyle:(UIBlurEffectStyle)effectStyle{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:effectStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

//全屏截图
+ (UIImage *)shotScreen{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);//下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}

+ (BOOL)isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color{
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

//倒计时
+ (dispatch_source_t)defindCountDownWithTimeCount:(int)count running:(void(^)(NSString *restTime))running finish:(void(^)(void))finish{
    
    __block int timeout = count; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                finish();
                
            });
        }else{
            int seconds = timeout % INT_MAX;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                running(strTime);
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    return _timer;
    
}

//获取当前屏幕显示的viewcontroller  即当前屏幕最顶层的viewcontroller
+ (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        //直接判断位数算了
//        return YES;
        /**
         * 移动号段正则表达式
         * 135 136 137 138 139 147 148 150 151 152 157 158 159  165 172 178 182 183 184 187 188 198
         */
//        NSString *CM_NUM = @"^((13[4-9])|(14[7-8])|(15[0-2,7-9])|(165)|(172)|(178)|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         * 130 131 132 145 146 155 156 166 171 175 176 185 186
         */
//        NSString *CU_NUM = @"^((13[0-2])|(14[5-6])|(15[5-6])|(166)|(171)|(17[5-6])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         * 133 149 153 173 174 177 180 181 189 199
         */
//        NSString *CT_NUM = @"^((133)|(149)|(153)|(17[3-4])|(177)|(18[0,1,9])|(199))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return YES;
//        }else{
//            return NO;
//        }
        
        NSString *CM_NUM = @"^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        if (isMatch1) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

// 缓存大小
+ (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1000.0/1000.0;
    
    return sizeM;
}

+ (void)removeCache:(void (^) (BOOL success))success{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            success(isRemove);
            
        }
    }
}

+ (NSString *)weatherImageWithState:(NSString *)state withPageType:(NSInteger)type{
    NSString *string = @"";
    if ([state isEqualToString:@"多云"]||[state isEqualToString:@"晴间多云"]){
        string = @"weather_icon_cloudy";
    }else if ([state isEqualToString:@"阴"] ||[state isEqualToString:@"少云"]||[state isEqualToString:@"平静"]||[state isEqualToString:@"微风"]||[state isEqualToString:@"和风"]||[state isEqualToString:@"清风"]){
        string = @"weather_icon_overcast";
    }else if ([state isEqualToString:@"阵雨"]||[state isEqualToString:@"强阵雨"]){
        string = @"weather_icon_shower";
    }else if ([state isEqualToString:@"雷阵雨"]||[state isEqualToString:@"雷阵雨伴有冰雹"]||[state isEqualToString:@"强雷阵雨"]){
        string = @"weather_icon_thunderShower";
    }else if ([state isEqualToString:@"小雨"]||[state isEqualToString:@"毛毛雨/细雨"]||[state isEqualToString:@"雨夹雪"]||[state isEqualToString:@"冷"]){
        string = @"weather_icon_lightRain";
    }else if ([state isEqualToString:@"中雨"]||[state isEqualToString:@"小到中雨"]||[state isEqualToString:@"雨"]){
        string = @"weather_icon_moderateRain";
    }else if ([state isEqualToString:@"大雨"]||[state isEqualToString:@"暴雨"]||[state isEqualToString:@"大暴雨"]||[state isEqualToString:@"特大暴雨"]||[state isEqualToString:@"冻雨"]||[state isEqualToString:@"极端降雨"]||[state isEqualToString:@"中到大雨"]||[state isEqualToString:@"大到暴雨"]||[state isEqualToString:@"暴雨到大暴雨"]||[state isEqualToString:@"大暴雨到特大暴雨"]){
        string = @"weather_icon_rain";
    }else if ([state isEqualToString:@"阵雪"]||[state isEqualToString:@"阵雨夹雪"]){
        string = @"weather_icon_snowShower";
    }else if ([state isEqualToString:@"中雪"]||[state isEqualToString:@"小雪"]|| [state isEqualToString:@"大雪"]||[state isEqualToString:@"暴雪"]||[state isEqualToString:@"小到中雪"]||[state isEqualToString:@"中到大雪"]||[state isEqualToString:@"大到暴雪"]||[state isEqualToString:@"雪"]){
        string = @"weather_icon_lightSnow";
    }else if ([state isEqualToString:@"雾"]||[state isEqualToString:@"薄雾"]||[state isEqualToString:@"霾"]||[state isEqualToString:@"浓雾"]||[state isEqualToString:@"强浓雾"]||[state isEqualToString:@"中度霾"]||[state isEqualToString:@"重度霾"]||[state isEqualToString:@"严重霾"]||[state isEqualToString:@"大雾"]||[state isEqualToString:@"特强浓雾"]){
        string = @"weather_icon_fog";
    }else if ([state isEqualToString:@"沙尘暴"]||[state isEqualToString:@"强沙尘暴"]||[state isEqualToString:@"龙卷风"]||[state isEqualToString:@"风暴"]||[state isEqualToString:@"狂暴风"]||[state isEqualToString:@"飓风"]||[state isEqualToString:@"热带风暴"]){
        string = @"weather_icon_sandStorm";
    }else if ([state isEqualToString:@"浮尘"]||[state isEqualToString:@"扬沙"]){
        string = @"weather_icon_dust";
    }else if ([state isEqualToString:@"飑"]||[state isEqualToString:@"强风劲风"]||[state isEqualToString:@"疾风"]||[state isEqualToString:@"大风"]||[state isEqualToString:@"烈风"]){
        string = @"weather_icon_squall";
    }else{//晴天
        string = @"weather_icon_sun";
    }
    
    return  string;
}

//拨打电话
+ (void)callPhoneWithPhoneStr:(NSString *)tel{
    
    //拨打电话
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",tel];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}



/**
 *  返回截取屏幕的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
    
}

//多个网络请求并发
+ (void)handleMutipleNetworkWithNumber:(int)num block:(void (^) (int i,dispatch_group_t group))block notiBlock:(void (^) (void))notiBlock{
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < num; i ++) {
        dispatch_group_enter(group);
        block(i,group);
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
        notiBlock();
    });
}

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)isNotchScreen {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return NO;
    }
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger notchValue = size.width / size.height * 100;
    
    if (216 == notchValue || 46 == notchValue) {
        return YES;
    }
    
    return NO;
}


//判断文件是否已经在沙盒中已经存在？
+ (BOOL)isFileExist:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

//只能输入字母与数字
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    NSString *str =@"^[A-Za-z0-9]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

//判断长度大于6位后再接着判断是否同时包含数字和大小写字母
+ (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result ;
    NSString * regex =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}

//用户名为6-16位字母加数字组成
+ (NSString *)verifyUserName:(NSString *)userName{
    NSString *message = @"";
    if (userName.length < 6){
        message = @"用户名由6-16位字母加数字组成";
    } else if(userName.length > 16){
        message = @"用户名由6-16位字母加数字组成";
    } else if ([self JudgeTheillegalCharacter:userName]){
        message = @"用户名由6-16位字母加数字组成";
    } else if (![self judgePassWordLegal:userName]){
        message = @"用户名由6-16位字母加数字组成";
    }
    return message;
}

//密码为6-16位数字或字母组成
+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName{
    NSString *message = @"";
    if (passWordName.length < 6){
        message = @"密码不能少于6位，请您重新输入";
    } else if(passWordName.length > 16){
        message = @"密码最大长度为16位，请您重新输入";
    } else if ([self JudgeTheillegalCharacter:passWordName]){
        message = @"密码不能包含特殊字符，请您重新输入";
    }
    return message;
}

/*
 *  处理小数点、price（doubel）。position（保留小数点后几位）。进位或降位修改model即可
 */
-(NSString *)stringByNotRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

//改变文字颜色及大小
+ (NSMutableAttributedString *)changeTextColorFont:(NSString *)str char:(NSString *)charStr color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:charStr];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrStr;
}

//改变文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeTextBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:charStr];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attrStr addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    return attrStr;
}

//改变3个不同文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeThreeBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor char2:(NSString *)charStr2 bgColor2:(UIColor *)bgColor2 color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:charStr];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attrStr addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    NSRange range2 = [str rangeOfString:charStr2];
    [attrStr addAttribute:NSFontAttributeName value:font range:range2];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range2];
    [attrStr addAttribute:NSBackgroundColorAttributeName value:bgColor2 range:range2];
    return attrStr;
}

//添加图标
+ (NSMutableAttributedString *)addPullDownIcon:(NSString *)value color:(UIColor *)color{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ",value]];
    [att addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, value.length)];
    [att addAttribute:NSFontAttributeName value:MyFont(Font_Regular, 15) range:NSMakeRange(0, value.length)];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"drop_down_gray"];
    attach.bounds = Setframe(0, 0, 8, 6);
    [att appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    return att;
}

//添加标签
+ (NSMutableAttributedString *)addLabelsIcon:(NSString *)value img:(UIImage *)img{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:value];
    [att addAttribute:NSForegroundColorAttributeName value:HexString(@"#333333") range:NSMakeRange(0, value.length)];
    [att addAttribute:NSFontAttributeName value:MyFont(Font_Regular, 14) range:NSMakeRange(0, value.length)];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = img;
    attch.bounds = CGRectMake(0, 0, 30, 16);
    //在文字下标第几个添加图片  0就是文字前面添加图片
    [att insertAttributedString:[NSAttributedString attributedStringWithAttachment:attch] atIndex:0];
    return att;
}

//h5转富文本
+ (NSMutableAttributedString *)ChangeToNSMutableAttributedString:(NSString *)contentStr{
    //如果有换行，把\n替换成<br/>
    NSString *detailStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    detailStr = [detailStr stringByReplacingOccurrencesOfString:@"\U0000fffc\n" withString:@""];
    //设置HTMLd图片的宽度
    detailStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@",SCREEN_WIDTH-30,detailStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:[detailStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    //设置富文本文字大小
    [attStr addAttributes:@{NSFontAttributeName:MyFont(Font_Regular, 16)} range:NSMakeRange(0, attStr.length)];
    //字体颜色
    [attStr addAttributes:@{NSForegroundColorAttributeName:HexString(@"#666666")} range:NSMakeRange(0, attStr.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    return attStr;
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString*) idCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

+ (BOOL)isQQ{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isWX{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isSina{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sina://"]]) {
        return YES;
    }
    return NO;
}

//图片添加水印
+ (UIImage *)waterMarkedImage:(UIImage *)img{
    NSString *curTime = [self currentDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attribute = @{NSFontAttributeName: MyFont(Font_Bold, 80),
                                NSForegroundColorAttributeName: [UIColor redColor]
                                };
    [curTime drawInRect:CGRectMake(100, h-400, w-200, 300) withAttributes:attribute];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return aImage;
}

/**
 添加本地推送
 */
+ (void)addLocalNotification:(NSString *)schId time:(NSString *)schTime type:(int)type {
    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //日期格式化格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //日程时间小于当前时间就不管
    NSDate *scheduleTime = [formatter dateFromString:schTime];
    //设置推送时间（截止时间10分钟之前）
    NSTimeInterval time = 10*60;//10分钟
    NSDate *pushTime = [scheduleTime dateByAddingTimeInterval:-time];
    NSDate *curDate = [NSDate date];
    if([self compareOneDay:pushTime withAnotherDay:curDate] == -1){
        return;
    }
    
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = pushTime;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = 0;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        if(type == 1){
            notification.alertBody = @"您有一个日程即将逾期";
        }else{
            notification.alertBody = @"您有一个待办即将逾期";
        }
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 0;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:schId forKey:@"id"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
    }
    
}

/**
 修改本地推送
 */
+ (void)updateLocalNotification:(NSString *)schId time:(NSString *)schTime type:(int)type{
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    bool isExit = false;
    if (localArray.count > 0) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if ([dict[@"id"] isEqualToString:schId]) {
                //已存在 修改
                //设置推送时间（截止时间10分钟之前）
                NSTimeInterval time = 10*60;//10分钟
                //日期格式化格式
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *scheduleTime = [formatter dateFromString:schTime];
                NSDate *pushTime = [scheduleTime dateByAddingTimeInterval:-time];
                if(![pushTime isEqualToDate:noti.fireDate]){
                    noti.fireDate = pushTime;
                }
                isExit = true;
                break;
            }
        }
    }
    if(!isExit){
        //不存在添加
        [self addLocalNotification:schId time:schTime type:type];
    }
}

/**
 删除本地推送
 */
+ (void)deleteLocalNotification{
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    if(localArray.count > 0){
        for (UILocalNotification *notification in localArray){
            [app cancelLocalNotification:notification];
        }
    }
    
}

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
               returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
      }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
       if(!([other rangeOfString:string].location != NSNotFound))
          return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

@end
