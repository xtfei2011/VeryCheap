//
//  TFTabBarController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFTabBarController.h"
#import "TFNavigationController.h"
#import "TFHomeViewController.h"
#import "TFCouponsViewController.h"
#import "TFSpecialViewController.h"
#import "TFMineViewController.h"

@interface TFTabBarController ()

@end

@implementation TFTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
}

- (void)setupItemTitleTextAttributes
{
    /*** 默认状态下 TabarItem 的 Font 、 Color ***/
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = TFCommodityTitleFont;
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    /*** 选中状态下 TabarItem 的 Font 、 Color ***/
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = TFColor(251, 44, 107);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setupChildViewController:[[TFHomeViewController alloc] init] title:@"首页" image:@"tabBar_home" selectedImage:@"tabBar_home_selected"];
    [self setupChildViewController:[[TFSpecialViewController alloc] init] title:@"9.9包邮" image:@"tabBar_gift" selectedImage:@"tabBar_gift_selected"];
    [self setupChildViewController:[[TFCouponsViewController alloc] init] title:@"分类" image:@"tabBar_category" selectedImage:@"tabBar_category_selected"];
    [self setupChildViewController:[[TFMineViewController alloc] init] title:@"我的" image:@"tabBar_me" selectedImage:@"tabBar_me_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param viewController            子控制器
 *  @param title                     标题
 *  @param image                     图标
 *  @param selectedImage             选中的图标
 */
- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    /*** 给外面传进来的控制器包装导航控制器 ***/
    TFNavigationController *nav = [[TFNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nav];
}
@end
