//
//  BaseSectionSelectView.h
//  education_Parent
//
//  Created by 豆子 on 2019/3/27.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSectionSelectView : UIScrollView

@property (nonatomic,strong) UIColor *normalColor;

@property (nonatomic,strong) UIFont *normalFont;

@property (nonatomic,strong) UIColor *selectColor;

@property (nonatomic,strong) UIFont *selectFont;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,copy) void (^sectionClickedBlock) (NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr;

//更改标题
- (void)changeTitleName:(NSInteger)index name:(NSString *)titleName;

@end

NS_ASSUME_NONNULL_END
