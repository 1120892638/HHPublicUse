//
//  BaseSectionSelectView.m
//  education_Parent
//
//  Created by 豆子 on 2019/3/27.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import "BaseSectionSelectView.h"
#import "ConstDefineHeader.h"
#import "ViewInstance.h"
#import "UIView+ViewCayegory.h"

@interface BaseSectionSelectView(){
    UILabel *_selectLabel;
}

@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,strong) NSMutableArray *labels;

@property (nonatomic,strong) NSMutableArray *textWidths;

@property (nonatomic,strong) UILabel *colorView;

@end

@implementation BaseSectionSelectView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.normalColor = HexString(@"#555555");
        self.normalFont = MyFont(Font_Regular, 15);
        self.selectColor = HexString(@"#333333");
        self.selectFont = MyFont(Font_Bold, 15);
        self.titleArr = [NSArray arrayWithArray:titleArr];
        self.labels = [NSMutableArray array];
        self.textWidths = [NSMutableArray array];
        _selectIndex = 0;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    if (self.titleArr.count == 0) {
        return;
    }
    __block CGFloat maxWidth = 0;
    [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text = obj;
        CGFloat width = [text sizeWithAttributes:@{NSFontAttributeName:self.normalFont}].width;
        UILabel *label = [ViewInstance defindLabelWithFrame:CGRectZero text:text textColor:self.normalColor textAlignment:NSTextAlignmentCenter font:self.normalFont];
        [self addSubview:label];
        label.frame = Setframe(maxWidth, 0, width + 30, CGRectGetHeight(self.bounds));
        maxWidth = label.right;
        [self.labels addObject:label];
        [self.textWidths addObject:@(width)];
        label.userInteractionEnabled = YES;
        label.tag = idx;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionClicked:)]];
    }];
    
    UIView *rightView = [self.labels lastObject];
    if (rightView.right < self.width) {
        //等分
        CGFloat width = self.width/self.titleArr.count;
        [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = self.labels[idx];
            label.frame = Setframe(idx*width, 0, width, self.height);
            NSString *text = obj;
            CGFloat secwidth = [text sizeWithAttributes:@{NSFontAttributeName:self.normalFont}].width;
            [self.textWidths replaceObjectAtIndex:idx withObject:@(secwidth)];
        }];
    }else{
        self.contentSize = CGSizeMake(rightView.right, self.height);
    }
    
    UILabel *colorLine = [ViewInstance defindLinelWithFrame:Setframe(0, self.height-5, [self.textWidths[0] floatValue], 3) backGroundColor:self.selectColor];
    ViewBorderRadius(colorLine, 2, 0, [UIColor clearColor]);
    [self addSubview:colorLine];
    self.colorView = colorLine;
    UILabel *label = self.labels[0];
    _selectLabel = label;
    label.font = self.selectFont;
    label.textColor = self.selectColor;
    self.colorView.center = CGPointMake(label.centerX, self.colorView.centerY);
}

- (void)settingColorLineFrameWithIndex:(NSInteger)index{
    
    UILabel *label = self.labels[index];
    if ([label isEqual:_selectLabel]) {
        return;
    }
    CGFloat lineWidth = [self.textWidths[index] floatValue];
    [UIView animateWithDuration:0.25 animations:^{
        self->_selectLabel.font = self.normalFont;
        self->_selectLabel.textColor = self.normalColor;
        label.font = self.selectFont;
        label.textColor = self.selectColor;
        self.colorView.width = lineWidth;
        self.colorView.center = CGPointMake(label.centerX, self.colorView.centerY);
        self->_selectLabel = label;
    }];
}

- (void)sectionClicked:(UITapGestureRecognizer *)tap{
    [self settingColorLineFrameWithIndex:tap.view.tag];
    _selectIndex = tap.view.tag;
    if (self.sectionClickedBlock) {
        self.sectionClickedBlock(tap.view.tag);
    }
    
    if (self.contentSize.width <= self.width) {
        return;
    }
    if (tap.view.centerX <= self.width/2) {
        [self setContentOffset:CGPointZero animated:YES];
    }else if (self.contentSize.width-tap.view.centerX > self.width/2){
        [self setContentOffset:CGPointMake(tap.view.centerX-(self.width/2), 0) animated:YES];
    }else{
        [self setContentOffset:CGPointMake(fabs(self.contentSize.width-self.width), 0) animated:YES];
    }
    
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    [self settingColorLineFrameWithIndex:selectIndex];
    if (self.sectionClickedBlock) {
        self.sectionClickedBlock(selectIndex);
    }
    
    if (self.contentSize.width <= self.width) {
        return;
    }
    UIView *view = self.labels[selectIndex];
    if (view.centerX <= self.width/2) {
        [self setContentOffset:CGPointZero animated:YES];
    }else if (self.contentSize.width-view.centerX > self.width/2){
        [self setContentOffset:CGPointMake(view.centerX-(self.width/2), 0) animated:YES];
    }else{
        [self setContentOffset:CGPointMake(fabs(self.contentSize.width-self.width), 0) animated:YES];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UILabel *label in _labels) {
        if ([label isEqual:_selectLabel]) {
            [label setTextColor:self.selectColor];
            [label setFont:self.selectFont];
        }else{
            [label setTextColor:self.normalColor];
            [label setFont:self.normalFont];
        }
    }
}

- (void)changeTitleName:(NSInteger)index name:(NSString *)titleName{
    UILabel *label = self.labels[index];
    label.text = titleName;
}

@end
