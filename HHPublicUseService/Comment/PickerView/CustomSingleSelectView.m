//
//  CustomSingleSelectView.m
//  education
//
//  Created by 豆子 on 2019/4/24.
//  Copyright © 2019年 豆子. All rights reserved.
//

#import "CustomSingleSelectView.h"
#import "ConstDefineHeader.h"
#import "ViewInstance.h"
#import "UIView+ViewCayegory.h"

@interface CustomSingleSelectView()

@property (nonatomic,strong) NSArray *textArr;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,assign) BOOL isMutiSelect;
@property (nonatomic,strong) NSMutableArray *butArr;

@property (nonatomic,strong) NSMutableArray *selBut;
@property (nonatomic,copy) void (^selectBlock) (NSString *text,CustomSingleSelectView *sView);

@end

@implementation CustomSingleSelectView

+ (void)initSingleSelectView:(NSArray *)arr isSingleSelect:(BOOL)isSingle block:(void (^) (NSString *text,CustomSingleSelectView *sView))selctBlock{
    CustomSingleSelectView *view = [[CustomSingleSelectView alloc] initWithFrame:KWindow.bounds withSecArr:arr withIsSingle:isSingle];
    view.selectBlock = selctBlock;
    [KWindow addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame withSecArr:(NSArray *)arr withIsSingle:(BOOL)isSingle{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KWindowColor;
        self.butArr = [NSMutableArray array];
        self.selBut = [NSMutableArray array];
        self.isMutiSelect = !isSingle;
        self.textArr = arr;
        UIView *content = [ViewInstance defindViewWithFrame:Setframe(0, SCREENH_HEIGHT, SCREEN_WIDTH, 60 + (55*arr.count)) backgroundColor:[UIColor whiteColor]];
        [self addSubview:content];
        self.contentView = content;
        
        for (int i = 0; i < arr.count; i ++) {
            UIButton *but = [[UIButton alloc] initWithFrame:Setframe(0, 55*i, SCREEN_WIDTH, 55)];
            [content addSubview:but];
            [but setTitleColor:HexString(@"#333333") forState:UIControlStateNormal];
            but.titleLabel.font = MyFont(Font_Regular, 17);
            but.tag = i;
            [but addTarget:self action:@selector(sectionAction:) forControlEvents:1<<6];
            if (self.isMutiSelect) {
                [but setImage:[UIImage imageNamed:@"not_selected"] forState:UIControlStateNormal];
                [but setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
                [but setTitle:[NSString stringWithFormat:@"  %@",arr[i]] forState:UIControlStateNormal];
            }else{
                [but setTitle:arr[i] forState:UIControlStateNormal];
            }
            [self.butArr addObject:but];
            if (i < arr.count-1) {
                UIView *line = [ViewInstance defindViewWithFrame:Setframe(0, but.height-0.75, SCREEN_WIDTH, 0.75) backgroundColor:HexString(@"#E6E6E6")];
                [but addSubview:line];
            }
        }
        
        UIView *line = [ViewInstance defindViewWithFrame:Setframe(0, content.height-60, SCREEN_WIDTH, 5) backgroundColor:HexString(@"#F2F2F2")];
        [content addSubview:line];
        
        UIButton *but = [[UIButton alloc] initWithFrame:Setframe(0, line.bottom, SCREEN_WIDTH, 55)];
        [content addSubview:but];
        [but setTitle:@"取消" forState:UIControlStateNormal];
        [but setTitleColor:HexString(@"#333333") forState:UIControlStateNormal];
        but.titleLabel.font = MyFont(Font_Regular, 17);
        [but addTarget:self action:@selector(cancelSelect) forControlEvents:1<<6];
        
        if (self.isMutiSelect) {
            but.width = SCREEN_WIDTH/2;
            UIButton *sureBut = [[UIButton alloc] initWithFrame:Setframe(SCREEN_WIDTH/2, line.bottom, SCREEN_WIDTH/2, 55)];
            [content addSubview:sureBut];
            [sureBut setTitle:@"确定" forState:UIControlStateNormal];
            [sureBut setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            sureBut.titleLabel.font = MyFont(Font_Regular, 17);
            [sureBut addTarget:self action:@selector(sureSelect) forControlEvents:1<<6];
            
            UIView *vLine = [ViewInstance defindViewWithFrame:CGRectMake(SCREEN_WIDTH/2-1, line.bottom+7.5, 2, 40) backgroundColor:HexString(@"eeeeee")];
            [content addSubview:vLine];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self->_contentView.y = SCREENH_HEIGHT-self->_contentView.height;
        } completion:^(BOOL finished) {
        }];
        
    }
    return self;
}

- (void)sectionAction:(UIButton *)sender{
    if (self.isMutiSelect) {
        sender.selected = !sender.selected;
        [self.selBut addObject:sender];
        return;
    }
    if (self.selectBlock) {
        self.selectBlock(self.textArr[sender.tag],self);
    }
    [self cancle];
}

-(void)cancelSelect{
    if (self.isMutiSelect) {
        [self.selBut enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *but = (UIButton *)obj;
            but.selected = !but.selected;
        }];
        [self.selBut removeAllObjects];
    }
    [self cancle];
}

- (void)cancle{
    [UIView animateWithDuration:0.25 animations:^{
//        self->_contentView.y = SCREENH_HEIGHT;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
        self.hidden = YES;
    }];
}

- (void)sureSelect{
    __block NSString *string = @"";
    [self.selBut removeAllObjects];
    [self.butArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *but = (UIButton *)obj;
        if (but.selected) {
            if (string.length == 0) {
                string = self.textArr[idx];
            }else{
                string = [string stringByAppendingString:[NSString stringWithFormat:@",%@",self.textArr[idx]]];
            }
        }
    }];
    if (string.length == 0) {
        return;
    }
    if (self.selectBlock) {
        self.selectBlock(string,self);
    }
    [self cancle];
}

@end
