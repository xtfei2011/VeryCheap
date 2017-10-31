//
//  TFSlideMenu.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSlideMenu : UIView
/*** 子控制器容器 ***/
@property (nonatomic ,weak) UIView *childView;
/*** 子控制器 Frame ***/
@property (nonatomic ,assign) CGRect childFrame;

/*** 初始化 ***/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles controllers:(NSArray *)controllers;

/**
 刷新数据
 @param titles 标题数组
 @param controllers 控制器数组
 @param index 显示位置
 */
- (void)reloadTitles:(NSArray *)titles controllers:(NSArray *)controllers index:(NSInteger)index;

/**
 滚动到对应位置
 @param index 需要显示的位置
 */
- (void)scrollIndex:(NSInteger)index;
@end
