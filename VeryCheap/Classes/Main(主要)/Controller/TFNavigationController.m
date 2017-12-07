//
//  TFNavigationController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNavigationController.h"
#import "TFNavigationBar.h"

@interface TFNavigationController ()

@end

@implementation TFNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*** 设置导航栏默认的背景颜色 ***/
    [TFNavigationBar xtfei_setDefaultNavBarBarTintColor:TFColor(251, 44, 107)];
    /*** 导航栏底部分割线隐藏 ***/
    [TFNavigationBar xtfei_setDefaultNavBarShadowImageHidden:YES];
    /*** 导航栏所有按钮的默认颜色 ***/
    [TFNavigationBar xtfei_setDefaultNavBarTintColor:[UIColor whiteColor]];
    /*** 航栏标题默认颜色 ***/
    [TFNavigationBar xtfei_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    /*** 设置状态栏样式 ***/
    [TFNavigationBar xtfei_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.view.backgroundColor = TFGlobalBg;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back" target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
