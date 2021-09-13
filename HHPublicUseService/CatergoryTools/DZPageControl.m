//
//  DZPageControl.m
//  utravel
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "DZPageControl.h"

@implementation DZPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = _pageHeight;
        
        size.width = _pageWidth;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
        
        subview.layer.cornerRadius = _pageHeight/2;
        
        subview.layer.masksToBounds = YES;
        
        
    }
    
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = _pageSide + _pageWidth;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-(newW + _pageWidth)/2, self.frame.origin.y, newW + _pageWidth, self.frame.size.height);
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, _pageWidth, _pageHeight)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, _pageWidth, _pageHeight)];
        }
    }

}
@end
