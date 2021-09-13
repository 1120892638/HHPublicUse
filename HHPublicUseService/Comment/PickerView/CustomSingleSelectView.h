//
//  CustomSingleSelectView.h
//  education
//
//  Created by 豆子 on 2019/4/24.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomSingleSelectView : UIView

+ (void)initSingleSelectView:(NSArray *)arr isSingleSelect:(BOOL)isSingle block:(void (^) (NSString *text,CustomSingleSelectView *sView))selctBlock;

@end

NS_ASSUME_NONNULL_END
