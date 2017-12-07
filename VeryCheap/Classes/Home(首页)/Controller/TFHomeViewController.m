//
//  TFHomeViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHomeViewController.h"
#import "TFSegmentBar.h"
#import "TFCommentViewController.h"
#import "TFSelectionViewController.h"
#import "TFCategory.h"
#import "TFBanner.h"
#import "TFSearchViewController.h"

@interface TFHomeViewController ()<UIScrollViewDelegate ,TFSegmentBarDelegate>

@property (nonatomic, strong) TFSegmentBar *segmentBar;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray<TFCategory *> *category;
@property (nonatomic ,strong) NSMutableArray<TFBanner *> *banner;
@end

@implementation TFHomeViewController

- (TFSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        TFSegmentConfig *config = [TFSegmentConfig defaultConfig];
        config.isShowMore = YES;
        _segmentBar = [TFSegmentBar segmentBarWithConfig:config];
        _segmentBar.xtf_y = 64;
        _segmentBar.backgroundColor = [UIColor whiteColor];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + self.segmentBar.xtf_height, TFMainScreen_Width, TFMainScreen_Height - 64 - self.segmentBar.xtf_height)];
        scrollView.pagingEnabled = true;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(scrollView.xtf_width * self.childViewControllers.count, 0);
        _contentScrollView = scrollView;
    }
    return _contentScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"好便宜";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"ic_search" highImage:@"ic_search" target:self action:@selector(jumpSearchView)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = TFGlobalBg;
    
    /*** 添加内容视图 ***/
    [self.view addSubview:self.contentScrollView];
    
    /*** 设置菜单栏 ***/
    [self.view addSubview:self.segmentBar];
    
    /*** 加载数据 ***/
    [self loadDataSource];
}

- (void)jumpSearchView
{
    TFSearchViewController *seaarch = [[TFSearchViewController alloc] init];
    [self.navigationController pushViewController:seaarch animated:YES];
}

- (void)loadDataSource
{
    __weak typeof(self) homeSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"service"] = @"Default.DPublic";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        homeSelf.banner = [TFBanner mj_objectArrayWithKeyValuesArray:dict[@"banner"]];
        homeSelf.category = [TFCategory mj_objectArrayWithKeyValuesArray:dict[@"fenlei"]];
    } failure:^(NSError *error) { }];
}

- (void)setCategory:(NSMutableArray<TFCategory *> *)category
{
    _category = category;
    
    /*** 添加子控制器 ***/
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (int i = 0; i < category.count; i++) {
        if (i == 0) {
            TFSelectionViewController *selection = [[TFSelectionViewController alloc] init];
            selection.banner = self.banner;
            [self addChildViewController:selection];
        }
        TFCommentViewController *vc = [[TFCommentViewController alloc] init];
        vc.view.backgroundColor = TFRandomColor;
        [self addChildViewController:vc];
    }
    /*** 设置菜单项展示 ***/
    self.segmentBar.protocol = (NSArray *)category;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.xtf_width *category.count, 0);
    self.segmentBar.selectedIndex = 0;
}

- (void)showControllerView:(NSInteger)index
{
    UIView *view;
    if (index == 0) {
        TFSelectionViewController *cvc = self.childViewControllers[index];
        cvc.loadKey = self.category[index].classid;
        view = cvc.view;
    } else {
        TFCommentViewController *cvc = self.childViewControllers[index];
        cvc.loadKey = self.category[index].classid;
        view = cvc.view;
    }
    CGFloat contentViewW = self.contentScrollView.xtf_width;
    view.frame = CGRectMake(contentViewW *index, 0, contentViewW, self.contentScrollView.xtf_height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW *index, 0) animated:YES];
}

- (void)segmentBarDidSelectIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex
{
    [self showControllerView:selectedIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.xtf_width;
    self.segmentBar.selectedIndex = page;
}
@end
