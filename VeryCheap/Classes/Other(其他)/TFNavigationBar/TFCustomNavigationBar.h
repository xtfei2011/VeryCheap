//
//  TFCustomNavigationBar.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCustomNavigationBar : UIView

@property (nonatomic ,copy) void(^onClickLeftButton)(void);
@property (nonatomic ,copy) void(^onClickRightButton)(void);

@property (nonatomic ,copy)   NSString *title;
@property (nonatomic ,strong) UIColor *titleLabelColor;
@property (nonatomic ,strong) UIFont *titleLabelFont;
@property (nonatomic ,strong) UIColor *barBackgroundColor;
@property (nonatomic ,strong) UIImage *barBackgroundImage;

+ (instancetype)customNavigationBar;

- (void)xtfei_setBottomLineHidden:(BOOL)hidden;
- (void)xtfei_setBackgroundAlpha:(CGFloat)alpha;
- (void)xtfei_setTintColor:(UIColor *)color;


- (void)xtfei_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)xtfei_setLeftButtonWithImage:(UIImage *)image;
- (void)xtfei_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;


- (void)xtfei_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)xtfei_setRightButtonWithImage:(UIImage *)image;
- (void)xtfei_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

@end
