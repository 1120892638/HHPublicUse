//
//  myUILabel.h
//  MeileTang
//
//  Created by admin on 2020/5/27.
//  Copyright © 2020 douzi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VerticalAlignment) {
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
};

@interface myUILabel : UILabel

@property (nonatomic,assign) VerticalAlignment verticalAlignment;

@end

