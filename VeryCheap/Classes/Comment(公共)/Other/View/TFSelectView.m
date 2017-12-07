//
//  TFSelectView.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSelectView.h"
#import "UIButton+TFExtension.h"
#import <Masonry.h>
#import <objc/runtime.h>

@implementation TFSelectView
static char *const btnKey = "btnKey";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIView *mainView = [UIView new];
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.top.equalTo(self);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = TFrayColor(222);
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(mainView);
        make.top.mas_equalTo(mainView.mas_bottom);
    }];
    
    NSArray *titleArr = @[@"默认",@"销量",@"价格",@"天猫"];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titleArr[i] forState:UIControlStateNormal ];
        button.titleLabel.font = TFCommentTitleFont;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:TFColor(251, 44, 107) forState:UIControlStateSelected];
        [mainView addSubview:button];
        button.tag = 100+i;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(mainView).offset(TFMainScreen_Width/4*i);
            make.top.bottom.equalTo(mainView);
            make.width.mas_equalTo(TFMainScreen_Width/4);
        }];
        
        if (i == 0) {
            button.selected = YES;
        }
        
        if (i == 2) {
            [button setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
            [button setButtonImageTitleStyle:TFButtonImageTitleStyleRight padding:2];
            objc_setAssociatedObject(button, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
        }
    }
}

- (void)selectClick:(UIButton *)sender
{
    for (int i = 0; i<4 ;i ++) {
        UIButton *button = [self viewWithTag:i+100];
        button.selected = NO;
    }
    sender.selected = YES;
    
    TFButtonClickType type = TFButtonClickTypeNormal;
    
    if (sender.tag == 102) {
        
        NSString *flag = objc_getAssociatedObject(sender, btnKey);
        
        if ([flag isEqualToString:@"1"]) {
            [sender setImage:[UIImage imageNamed:@"ascending_order"] forState:UIControlStateNormal];
            objc_setAssociatedObject(sender, btnKey, @"2", OBJC_ASSOCIATION_ASSIGN);
            type = TFButtonClickTypeUp;
            
        } else if ([flag isEqualToString:@"2"]){
            [sender setImage:[UIImage imageNamed:@"descending_order"] forState:UIControlStateNormal];
            objc_setAssociatedObject(sender, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
            type = TFButtonClickTypeDown;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(selectButton:withIndex:withButtonType:)]) {
        [self.delegate selectButton:self withIndex:sender.tag withButtonType:type];
    }
}
@end
