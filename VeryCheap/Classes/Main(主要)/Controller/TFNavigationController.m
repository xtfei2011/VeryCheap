//
//  TFNavigationController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNavigationController.h"

@interface TFNavigationController ()

@end

@implementation TFNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = TFColor(245, 80, 83);
    
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16], NSFontAttributeName, nil]];
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
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"" highImage:@"" target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
