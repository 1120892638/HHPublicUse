//
//  EaseTextView.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "EaseTextView.h"
#import "ConstDefineHeader.h"

@interface EaseTextView ()<UITextViewDelegate>

@end

@implementation EaseTextView

#pragma mark - Setters

- (void)setPlaceHolder:(NSString *)placeHolder {
    if([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    NSUInteger maxChars = [EaseTextView maxCharactersPerLine];
    if([placeHolder length] > maxChars) {
        placeHolder = [placeHolder substringToIndex:maxChars - 8];
        placeHolder = [[placeHolder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingFormat:@"..."];
    }
    
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    if([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark - Message text view

- (NSUInteger)numberOfLinesOfText
{
    return [EaseTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text {
    return (text.length / [EaseTextView maxCharactersPerLine]) + 1;
}

#pragma mark - Text view overrides

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

//- (void)setContentInset:(UIEdgeInsets)contentInset {
//    [super setContentInset:contentInset];
//    [self setNeedsDisplay];
//}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    
    if (self.textViewDidChange) {
        
        self.textViewDidChange();
        
    }
    
    [self setNeedsDisplay];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if (self.textViewReturnBlock) {
            self.textViewReturnBlock(self.text);
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark - Life cycle

- (void)setup {
    self.accessibilityIdentifier = @"text_view";
    
    self.leftPadding = 10;
    self.textContainerInset = UIEdgeInsetsMake(self.textContainerInset.top, self.leftPadding-5, self.textContainerInset.bottom, self.leftPadding-5);//设置页边距
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    _placeHolderTextColor = [UIColor lightGrayColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    self.contentInset = UIEdgeInsetsZero;
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
    self.delegate = self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setLeftPadding:(CGFloat)leftPadding{
    
    _leftPadding = leftPadding;
    
    self.textContainerInset = UIEdgeInsetsMake(self.textContainerInset.top, _leftPadding-5, self.textContainerInset.bottom, _leftPadding-5);//设置页边距
    
    [self setNeedsDisplay];
    
}

- (void)dealloc {
    _placeHolder = nil;
    _placeHolderTextColor = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if([self.text length] == 0 && self.placeHolder) {
        CGRect placeHolderRect = CGRectMake(_leftPadding,
                                            7.0f,
                                            rect.size.width,
                                            rect.size.height);
        
        [self.placeHolderTextColor set];
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            //            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = self.textAlignment;
            
            [self.placeHolder drawInRect:placeHolderRect
                          withAttributes:@{ NSFontAttributeName : self.font,
                                            NSForegroundColorAttributeName : self.placeHolderTextColor,
                                            NSParagraphStyleAttributeName : paragraphStyle }];
        }
        else {
            [self.placeHolder drawInRect:placeHolderRect
                                withFont:self.font
                           lineBreakMode:NSLineBreakByTruncatingTail
                               alignment:self.textAlignment];
        }
    }
}

//插入图片
- (void)addImage:(UIImage *)image{
    CGSize  imgSize = image.size;
    CGFloat newImgW = imgSize.width;
    CGFloat newImgH = imgSize.height;
    CGFloat textW   = 200;
    if (newImgW > textW) {
        CGFloat ratio = textW / newImgW;
        newImgW  = textW;
        newImgH *= ratio;
    }
    NSAttributedString *enterStr = [[NSAttributedString alloc] initWithString:@"\n"];
    // 前文
    NSMutableAttributedString *bfStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    /*---------------添加内容 start-----------------*/
    // 转换图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, newImgW, newImgH);
    NSAttributedString *text = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *imageText = [[NSMutableAttributedString alloc] initWithAttributedString:text];
    // 前文换行
    [imageText insertAttributedString:enterStr atIndex:0];
    /*---------------添加内容 end-----------------*/
    // 前文拼接图片
    // 换行
    [imageText insertAttributedString:enterStr atIndex:imageText.length];
    [bfStr insertAttributedString:imageText atIndex:bfStr.length];
    //    // 拼接转换后的attributeStirng
    [bfStr insertAttributedString:enterStr atIndex:bfStr.length];
    NSMutableAttributedString *newAtt = [[NSMutableAttributedString alloc]init];
    [newAtt setAttributedString:bfStr];
    [newAtt addAttribute:NSFontAttributeName value:MyFont(Font_Regular, 15) range:NSMakeRange(0, bfStr.length)];
    self.attributedText = newAtt;
    [self becomeFirstResponder];
}


@end
