//
//  STPickerArea.h
//  MeileTang
//
//  Created by admin on 2019/7/31.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "BasicController.h"
#import "STPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@class STPickerArea;

@protocol  STPickerAreaDelegate<NSObject>

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end

@interface STPickerArea : STPickerView

/** 1.中间选择框的高度，default is 32*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <STPickerAreaDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
