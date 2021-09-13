//
//  MyTextField.m
//  xiangshiji
//
//  Created by 豆子 on 2018/1/5.
//  Copyright © 2018年 豆子. All rights reserved.
//

#import "MyTextField.h"
#import "GlobalModel.h"
#import "ConstDefineHeader.h"

@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.maxInputLength = 50;//默认最大50
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification" object:self];
        
    }
    
    return self;
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:self];
    
}

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > self.maxInputLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxInputLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:self.maxInputLength];
                [self showAlert];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxInputLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
                [self showAlert];
            }
        }
    }
}

//弹出提示框
- (void)showAlert{
    
    [GlobalModel showTipToView:KWindow andTipText:[NSString stringWithFormat:@"最多输入%ld个字",self.maxInputLength]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
