//
//  TFSortCommentViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSortCommentViewController.h"
#import "TFSelectView.h"
#import "TFCommentViewCell.h"
#import "TFDetailsViewController.h"

@interface TFSortCommentViewController ()<TFSelectViewDelegate>
/*** 顶部菜单栏 ***/
@property (nonatomic ,strong) TFSelectView *selectView;
/*** 公共数据 ***/
@property (nonatomic ,strong) NSMutableArray<TFComment *> *comment;
@property (nonatomic ,assign) NSInteger page;
@end

@implementation TFSortCommentViewController
static NSString * const CommentID = @"TFCommentViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.sortCommentView];
    
    /*** 获取默认数据 ***/
    [self setupRefresh:@"1"];
}

- (TFSelectView *)selectView
{
    if (!_selectView) {
        
        _selectView = [[TFSelectView alloc] initWithFrame:CGRectMake(0, 64, TFMainScreen_Width, 40)];
        _selectView.delegate = self;
    }
    return _selectView;
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

- (UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0.5;
        _layout.minimumLineSpacing = 0.5;
    }
    return _layout;
}

- (UICollectionView *)sortCommentView
{
    if (_sortCommentView == nil) {
        
        _sortCommentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 105, TFMainScreen_Width, TFMainScreen_Height - 104) collectionViewLayout:self.layout];
        _sortCommentView.backgroundColor = TFGlobalBg;
        _sortCommentView.dataSource = self;
        _sortCommentView.delegate = self;
        
        [self registerSectionReuseViewOrCell];
    }
    return _sortCommentView;
}

/*** 各 section 头部 ReuseView 和 cell 的注册 ***/
- (void)registerSectionReuseViewOrCell
{
    [_sortCommentView registerNib:[UINib nibWithNibName:@"TFCommentViewCell" bundle:nil] forCellWithReuseIdentifier:CommentID];
}

- (void)setupRefresh:(NSString *)loadkey
{
    _sortCommentView.mj_header = [TFRefreshHeader headerWithRefreshingBlock:^{
        [self loadCommentContent:loadkey];
    }];
    [_sortCommentView.mj_header beginRefreshing];
    
    _sortCommentView.mj_footer = [TFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreCommentContent:loadkey];
    }];
}

- (void)loadCommentContent:(NSString *)loadKey
{
    self.page = 1;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"type"] = loadKey;
    params[@"zttype"] = self.type;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DztList";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.sortCommentView.mj_header endRefreshing];
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        commentSelf.comment = [TFComment mj_objectArrayWithKeyValuesArray:dict];
        [commentSelf.sortCommentView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)loadMoreCommentContent:(NSString *)loadKey
{
    self.page ++;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"type"] = loadKey;
    params[@"zttype"] = self.type;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DztList";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.sortCommentView.mj_footer endRefreshing];
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        NSArray<TFComment *> *moreCommentn = [TFComment mj_objectArrayWithKeyValuesArray:dict];
        
        if (moreCommentn.count == 0) {
            [commentSelf.sortCommentView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [commentSelf.comment addObjectsFromArray:moreCommentn];
            [commentSelf.sortCommentView reloadData];
        }
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((TFMainScreen_Width - 0.5)/2, (TFMainScreen_Width - 0.5)/2 + 70);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.comment.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CommentID forIndexPath:indexPath];
    cell.comment = self.comment[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFDetailsViewController *details = [[TFDetailsViewController alloc] init];
    details.selection = (TFSelection *)self.comment[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}
@end
