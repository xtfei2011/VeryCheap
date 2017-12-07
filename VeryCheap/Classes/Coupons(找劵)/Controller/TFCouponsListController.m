//
//  TFCouponsListController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCouponsListController.h"
#import "TFSelectView.h"
#import "TFHomeListViewCell.h"
#import "TFDetailsViewController.h"

@interface TFCouponsListController ()<TFSelectViewDelegate>
/*** 顶部菜单栏 ***/
@property (nonatomic ,strong) TFSelectView *selectView;
/*** 列表数据源 ***/
@property (nonatomic ,strong) NSMutableArray<TFSelection *> *selection;
@property (nonatomic ,assign) NSInteger page;
@end

@implementation TFCouponsListController
/** cell的重用标识 */
static NSString * const HomeListID = @"TFHomeListViewCell";

- (TFSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[TFSelectView alloc] initWithFrame:CGRectMake(0, 64, TFMainScreen_Width, 40)];
        _selectView.delegate = self;
    }
    return _selectView;
}

- (UITableView *)couponsListTableView
{
    if (!_couponsListTableView) {
        _couponsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_selectView.frame) + 0.5, TFMainScreen_Width, TFMainScreen_Height - CGRectGetMaxY(_selectView.frame))];
        _couponsListTableView.backgroundColor = TFGlobalBg;
        _couponsListTableView.dataSource = self;
        _couponsListTableView.delegate = self;
        _couponsListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _couponsListTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.selectView];
    
    [self.view addSubview:self.couponsListTableView];
    /*** 注册 cell ***/
    [self.couponsListTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFHomeListViewCell class]) bundle:nil] forCellReuseIdentifier:HomeListID];
    
    /*** 获取默认数据 ***/
    [self setupRefresh:@"1"];
}

- (void)selectButton:(TFSelectView *)selectView withIndex:(NSInteger)index withButtonType:(TFButtonClickType)type
{
    if (index == 100) {
        TFLog(@"综合");
        [self setupRefresh:@"1"];
        
    } else if (index == 101) {
        TFLog(@"促销");
        [self setupRefresh:@"2"];
    } else if (index == 102 && type) {
        switch (type) {
            case TFButtonClickTypeNormal:
                TFLog(@"默认排序");
                break;
            case TFButtonClickTypeUp:
                TFLog(@"升序排序");
                [self setupRefresh:@"3"];
                break;
            case TFButtonClickTypeDown:
                TFLog(@"降序排序");
                [self setupRefresh:@"4"];
                break;
                
            default:
                break;
        }
    } else if (index == 103) {
        
        TFLog(@"全部");
        [self setupRefresh:@"5"];
    }
}

- (void)setupRefresh:(NSString *)loadkey
{
    _couponsListTableView.mj_header = [TFRefreshHeader headerWithRefreshingBlock:^{
        [self loadContent:loadkey];
    }];
    [_couponsListTableView.mj_header beginRefreshing];
    
    _couponsListTableView.mj_footer = [TFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreContent:loadkey];
    }];
}

- (void)loadContent:(NSString *)loadKey
{
    self.page = 1;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"keywords"] = self.title;
    params[@"type"] = loadKey;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DList";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.couponsListTableView.mj_header endRefreshing];
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        commentSelf.selection = [TFSelection mj_objectArrayWithKeyValuesArray:dict];
        [commentSelf.couponsListTableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)loadMoreContent:(NSString *)loadKey
{
    self.page ++;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"keywords"] = self.title;
    params[@"type"] = loadKey;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DList";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.couponsListTableView.mj_footer endRefreshing];
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        NSArray<TFSelection *> *moreSelection = [TFSelection mj_objectArrayWithKeyValuesArray:dict];
        
        if (moreSelection.count == 0) {
            [commentSelf.couponsListTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [commentSelf.selection addObjectsFromArray:moreSelection];
            [commentSelf.couponsListTableView reloadData];
        }
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selection.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFHomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeListID];
    cell.selection = self.selection[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFDetailsViewController *details = [[TFDetailsViewController alloc] init];
    details.selection = self.selection[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}
@end
