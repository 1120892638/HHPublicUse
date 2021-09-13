//
//  MyDefindButton.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "MyDefindButton.h"
#import "UIView+ViewCayegory.h"
#import "ConstDefineHeader.h"

@implementation MyDefindButton

- (instancetype)init{
    if (self = [super init]) {
        _insertPadding = 2;//默认间距为2
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    if (titleF.size.height == 0) {
        CGFloat height = self.height-imageF.size.height-_insertPadding;
        titleF = Setframe(titleF.origin.x, titleF.origin.y, titleF.size.width, height);
    }
    
    switch (self.myDefindType) {
        case UIMyDefindButtonImageTypeNormal:{
            
            imageF.origin.x = self.width/2-((titleF.size.width + imageF.size.width+_insertPadding)/2);
            
            self.imageView.frame = imageF;
            
            titleF.origin.x = CGRectGetMaxX(imageF) + _insertPadding;
            self.titleLabel.frame = titleF;
            
        }
            
            break;
            
        case UIMyDefindButtonImageTypeTop:{
            
            CGRect newImageRect;
            
            newImageRect.origin.x = self.width/2-(imageF.size.width/2);
            
            newImageRect.origin.y = self.height/2 - ((imageF.size.height+_insertPadding+titleF.size.height)/2);
            
            newImageRect.size.width = imageF.size.width;
            
            newImageRect.size.height = imageF.size.height;
            
            self.imageView.frame = newImageRect;
            
            self.titleLabel.frame = CGRectMake(0, self.imageView.bottom+_insertPadding, self.width, titleF.size.height);
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }
            break;
        case UIMyDefindButtonImageTypeRight:{
            
            titleF.origin.x = self.width/2-((titleF.size.width + imageF.size.width+_insertPadding)/2);
            
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = CGRectGetMaxX(titleF) + _insertPadding;
            self.imageView.frame = imageF;
            
        }
            break;
            
        case UIMyDefindButtonImageTypeBottom:{
            
            CGRect newTitleRect;
            
            newTitleRect.origin.x = self.width/2-(titleF.size.width/2);
            
            newTitleRect.origin.y = self.height/2 - ((imageF.size.height+_insertPadding+titleF.size.height)/2);
            
            newTitleRect.size.width = titleF.size.width;
            
            newTitleRect.size.height = titleF.size.height;
            
            self.titleLabel.frame = CGRectMake(0, newTitleRect.origin.y, self.width, newTitleRect.size.height);
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.imageView.frame = CGRectMake(self.width/2-(imageF.size.width/2), self.titleLabel.bottom+_insertPadding, imageF.size.width, imageF.size.height);
            
        }
            break;
            
        case UIMyDefindButtonImageTypeRightRight:{
            imageF.origin.x = self.width-imageF.size.width;
            self.imageView.frame = imageF;
            
            titleF.origin.x = self.width-(titleF.size.width+imageF.size.width+_insertPadding);
            self.titleLabel.frame = titleF;
        }
            break;            
        case UIMyDefindButtonImageTypeRightLeft:{
            titleF.origin.x = 0;
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = titleF.size.width + _insertPadding;
            self.imageView.frame = imageF;
        }
            break;
        case UIMyDefindButtonImageTypeRightCenter:{
            titleF.origin.x = self.width/2-(titleF.size.width/2);
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = CGRectGetMaxX(titleF) + _insertPadding;
            self.imageView.frame = imageF;
        }
            break;
        case UIMyDefindButtonImageTypeNormalLeft:{
            imageF.origin.x = 0;
            self.imageView.frame = imageF;
            
            titleF.origin.x = imageF.size.width + _insertPadding;
            self.titleLabel.frame = titleF;
        }
            break;
        case UIMyDefindButtonImageTypeNormalRight:{
            titleF.origin.x = self.width-titleF.size.width;
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = self.width-(titleF.size.width+imageF.size.width+_insertPadding);
            self.imageView.frame = imageF;
        }
            break;
        default:
            break;
    }
    
}

@end
