//
//  TFHomeViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHomeViewController.h"
#import "TFSlideMenu.h"
#import "TFSelectionViewController.h"
#import "TFCommentViewController.h"

@interface TFHomeViewController ()

@end

@implementation TFHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self setupSlideView];
}

- (void)setupSlideView
{
    NSArray *titles = @[@"精选" ,@"专场" ,@"美妆" ,@"女士护理" ,@"居家" ,@"女装" ,@"内衣" ,@"食品保健" ,@"女鞋" ,@"箱包装饰" ,@"手机周边" ,@"母婴童装" ,@"家用电器" ,@"宠物" ,@"运动健身" ,@"成人用品"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < titles.count; i ++) {
        if (i == 0) {
            TFSelectionViewController *selectionVC = [TFSelectionViewController new];
            [arr addObject:selectionVC];
        } else {
            TFCommentViewController *commentVC = [TFCommentViewController new];
            commentVC.isHome = i;
            [arr addObject:commentVC];
        }
    }
    
    TFSlideMenu *menu = [[TFSlideMenu alloc] initWithFrame:CGRectMake(0, 64, self.view.xtf_width, 35) titles:titles controllers:arr];
    menu.childView = self.view;
    menu.childFrame = CGRectMake(0, 64 + 35, self.view.xtf_width, self.view.xtf_height - 64 - 35);
    [self.view addSubview:menu];
}
@end
