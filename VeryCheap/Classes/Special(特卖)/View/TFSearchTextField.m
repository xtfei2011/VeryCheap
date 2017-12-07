//
//  TFSearchTextField.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFSearchTextField.h"

@implementation TFSearchTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView
{
    self.placeholder = @"请输入关键词";
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15.5;
    self.keyboardType = UIKeyboardTypeWebSearch;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search_icon"]];
    img.frame = CGRectMake(10, 0, 20, 20);
    self.leftView = img;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.font = [UIFont fontWithName:@"Arial" size:14];
}

/*** 重写左视图的位置 ***/
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect SearchRect = [super leftViewRectForBounds:bounds];
    SearchRect.origin.x +=10;
    
    return SearchRect;
}

/*** 重写占位符的x值 ***/
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x +=1;
    return placeholderRect;
}

/*** 重写文字输入时的x值 ***/
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x +=10;
    
    return editingRect;
}

/*** 重写文字显示时的X值 ***/
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 10;
    return textRect;
}
@end
