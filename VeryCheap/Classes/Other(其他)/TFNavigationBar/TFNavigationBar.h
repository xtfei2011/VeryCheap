//
//  TFNavigationBar.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCustomNavigationBar;
@interface TFNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (int)navBarBottom;
+ (int)screenWidth;
+ (int)screenHeight;
@end

#pragma mark - Default
@interface TFNavigationBar (TFDefault)

/** set default barTintColor of UINavigationBar */
+ (void)xtfei_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default tintColor of UINavigationBar */
+ (void)xtfei_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)xtfei_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)xtfei_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)xtfei_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (TFAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)xtfei_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)xtfei_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)xtfei_getTranslationY;

@end



#pragma mark - UIViewController
@interface UIViewController (TFAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: xtfei_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)xtfei_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)xtfei_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)xtfei_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)xtfei_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)xtfei_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)xtfei_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)xtfei_setNavBarTintColor:(UIColor *)color;
- (UIColor *)xtfei_navBarTintColor;

/** record current ViewController titleColor */
- (void)xtfei_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)xtfei_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)xtfei_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)xtfei_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)xtfei_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)xtfei_navBarShadowImageHidden;

@end
