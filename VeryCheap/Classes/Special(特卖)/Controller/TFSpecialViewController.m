//
//  TFSpecialViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSpecialViewController.h"
#import "TFCommentViewCell.h"
#import "TFDetailsViewController.h"

@interface TFSpecialViewController ()
@property (nonatomic ,strong) NSMutableArray<TFComment *> *comment;
@property (nonatomic ,assign) NSInteger page;
@end

@implementation TFSpecialViewController

static NSString * const CommentID = @"TFCommentViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TFRandomColor;
    
    [self setupCollectionView];
    [self loadCommentContent];
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

- (void)loadCommentContent
{
    self.page = 1;
    __weak typeof(self) commentSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"page"] = [NSString stringWithFormat:@"%ld",self.page];
    params[@"service"] = @"Default.D9kuai9";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject[@"data"] objectForKey:@"list"];
        
        commentSelf.comment = [TFComment mj_objectArrayWithKeyValuesArray:dict];
        
        [commentSelf.collectionView reloadData];
        
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
