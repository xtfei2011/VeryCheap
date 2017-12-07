//
//  TFCommentViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentViewController.h"
#import "TFCommentViewCell.h"
#import "TFDetailsViewController.h"

@interface TFCommentViewController ()
@property (nonatomic ,strong) NSMutableArray<TFComment *> *comment;
@property (nonatomic ,assign) NSInteger page;
@end

@implementation TFCommentViewController
static NSString * const CommentID = @"TFCommentViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TFRandomColor;
    
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    self.collectionView.backgroundColor = TFGlobalBg;
    self.collectionView.contentInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFCommentViewCell" bundle:nil] forCellWithReuseIdentifier:CommentID];
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    return [self initWithCollectionViewLayout:layout];
}

- (void)setLoadKey:(NSString *)loadKey
{
    _loadKey = loadKey;
    
    [self setupRefresh:loadKey];
}

- (void)setupRefresh:(NSString *)loadkey
{
    self.collectionView.mj_header = [TFRefreshHeader headerWithRefreshingBlock:^{
        [self loadCommentContent:loadkey];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [TFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreCommentContent:loadkey];
    }];
}

- (void)loadCommentContent:(NSString *)loadKey
{
    self.page = 1;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"classid"] = loadKey;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DDefault";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.collectionView.mj_header endRefreshing];

        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        commentSelf.comment = [TFComment mj_objectArrayWithKeyValuesArray:dict];
        [commentSelf.collectionView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)loadMoreCommentContent:(NSString *)loadKey
{
    self.page ++;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"classid"] = loadKey;
    params[@"page"] = @(self.page);
    params[@"service"] = @"Default.DDefault";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        [commentSelf.collectionView.mj_footer endRefreshing];
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        NSArray<TFComment *> *moreCommentn = [TFComment mj_objectArrayWithKeyValuesArray:dict];
        
        if (moreCommentn.count == 0) {
            [commentSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [commentSelf.comment addObjectsFromArray:moreCommentn];
            [commentSelf.collectionView reloadData];
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
