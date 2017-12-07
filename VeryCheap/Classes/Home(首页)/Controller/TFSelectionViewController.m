//
//  TFSelectionViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSelectionViewController.h"
#import "TFBannerView.h"
#import "TFBanner.h"
#import "TFCategoryViewCell.h"
#import "TFHomeListViewCell.h"
#import "TFSortCommentViewController.h"
#import "TFDetailsViewController.h"

@interface TFSelectionViewController ()<TFCategoryBtnDelegate>
/*** 列表数据源 ***/
@property (nonatomic ,strong) NSMutableArray<TFSelection *> *selection;
@property (nonatomic ,assign) NSInteger page;
@end

@implementation TFSelectionViewController
/** cell的重用标识 */
static NSString * const HomeListID = @"TFHomeListViewCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTopView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TFGlobalBg;
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFHomeListViewCell class]) bundle:nil] forCellReuseIdentifier:HomeListID];
   
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [TFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeViewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [TFRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHomeTmallData)];
}

/*** 轮播View ***/
- (void)setupTopView  
{
    CGFloat bannerH = 2 *TFMainScreen_Width/5;
    
    TFBannerView *bannerView = [[TFBannerView alloc] initWithFrame:CGRectMake(0, 64, TFMainScreen_Width, bannerH) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds), bannerH)];
    bannerView.banner = self.banner;
    self.tableView.tableHeaderView = bannerView;
    
    [bannerView bannerViewClick:^(TFBannerView *barnerView ,NSString *type ,NSString *name) {
        [self jumpSortCommentView:type title:name];
    }];
}

- (void)loadHomeViewData
{
    self.page = 1;
    __weak typeof(self) homeSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"service"] = @"Default.DDefault";
    params[@"page"] = @(self.page);
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [homeSelf.tableView.mj_header endRefreshing];
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        
        homeSelf.selection = [TFSelection mj_objectArrayWithKeyValuesArray:dict];
        [homeSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)loadMoreHomeTmallData
{
    self.page ++;
    __weak typeof(self) homeSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"service"] = @"Default.DDefault";
    params[@"page"] = @(self.page);
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        
        NSArray<TFSelection *> *moreSelection = [TFSelection mj_objectArrayWithKeyValuesArray:dict];
        [homeSelf.tableView.mj_footer endRefreshing];
        
        if (moreSelection.count == 0) {
            [homeSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [homeSelf.selection addObjectsFromArray:moreSelection];
            [homeSelf.tableView reloadData];
        }
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? self.selection.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 170 : 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFCategoryViewCell *cell = [TFCategoryViewCell cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    } else {
        TFHomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeListID];
        cell.selection = self.selection[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFDetailsViewController *details = [[TFDetailsViewController alloc] init];
    details.selection = self.selection[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

- (void)sortButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
            [self jumpSortCommentView:@"tqg" title:@"淘抢购"];
            break;
        case 1001:
            [self jumpSortCommentView:@"jhs" title:@"聚划算"];
            break;
        case 1002:
            [self jumpSortCommentView:@"ppq" title:@"品牌券"];
            break;
        case 1003:
            [self jumpSortCommentView:@"bmqd" title:@"必买清单"];
            break;
            
        default:
            break;
    }
}

- (void)jumpSortCommentView:(NSString *)type title:(NSString *)title
{
    TFSortCommentViewController *sortComment = [[TFSortCommentViewController alloc] init];
    sortComment.navigationItem.title = title;
    sortComment.type = type;
    [self.navigationController pushViewController:sortComment animated:YES];
}
@end
