//
//  MyDefindButton.h
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIMyDefindButtonImageType) {
    
    UIMyDefindButtonImageTypeNormal,//左图片 右文字 内容居中
    
    UIMyDefindButtonImageTypeNormalLeft,//左图片 右文字  内容靠左
    
    UIMyDefindButtonImageTypeNormalRight,//左图片 右文字  内容靠右
    
    UIMyDefindButtonImageTypeRight,//右图片 左文字 内容居中
    
    UIMyDefindButtonImageTypeRightLeft,//右图片  左文字  内容靠左
    
    UIMyDefindButtonImageTypeRightRight,//右图片 左文字 内容靠右
    
    UIMyDefindButtonImageTypeRightCenter,//右图片  左文字  只文字居中
    
    UIMyDefindButtonImageTypeTop,//上图片 下文字
    
    UIMyDefindButtonImageTypeBottom,//下图片 上文字
    
    
};
@interface MyDefindButton : UIButton

@property (nonatomic,assign) CGFloat insertPadding;

@property (nonatomic,assign) UIMyDefindButtonImageType myDefindType;

@end
