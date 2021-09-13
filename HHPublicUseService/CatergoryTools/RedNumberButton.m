//
//  RedNumberButton.m
//  MeileTang
//
//  Created by 豆子 on 2019/7/29.
//  Copyright © 2019年 douzi. All rights reserved.
//

#import "RedNumberButton.h"
#import "ConstDefineHeader.h"
#import "ViewInstance.h"
#import "UIView+ViewCayegory.h"

@interface RedNumberButton()

@property (nonatomic,strong) UILabel *redTagLabel;

@end

@implementation RedNumberButton

- (void)setRedNumber:(NSInteger)redNumber{
    _redNumber = redNumber;
    if (_redNumber > 0) {
        self.redTagLabel.hidden = NO;
        NSString *text = _redNumber > 99?@"99+":[NSString stringWithFormat:@"%ld",_redNumber];
        self.redTagLabel.text = text;
        CGFloat width = [text sizeWithAttributes:@{NSFontAttributeName:MyFont(Font_Regular, 10)}].width;
        width = width<15?15:width+5;
        self.redTagLabel.size = CGSizeMake(width, 15);
        [self setNeedsDisplay];
    }else{
        self.redTagLabel.hidden = YES;
    }
}

- (void)setRedTagShow:(BOOL)redTagShow{
    _redTagShow = redTagShow;
    if (_redTagShow) {
        self.redTagLabel.hidden = NO;
        self.redTagLabel.size = CGSizeMake(10, 10);
        ViewBorderRadius(_redTagLabel, 5, 0, [UIColor clearColor]);
        [self setNeedsDisplay];
    }else{
        self.redTagLabel.hidden = YES;
    }
}

- (UILabel *)redTagLabel{
    if (!_redTagLabel) {
        _redTagLabel = [ViewInstance defindLabelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 10)];
        ViewBorderRadius(_redTagLabel, 7, 0, [UIColor clearColor]);
        _redTagLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_redTagLabel];
    }
    return _redTagLabel;
}

- (void)setRedBackColor:(UIColor *)redBackColor{
    _redBackColor = redBackColor;
    [self.redTagLabel setBackgroundColor:redBackColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.redTagLabel.hidden == NO) {
        self.redTagLabel.center = CGPointMake(self.imageView.right, self.imageView.y+5);
    }
}

@end
