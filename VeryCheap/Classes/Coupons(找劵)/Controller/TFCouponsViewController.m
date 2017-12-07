//
//  TFCouponsViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCouponsViewController.h"
#import "TFLeftTableViewCell.h"
#import "TFRightReusableView.h"
#import "TFRightCollectionViewCell.h"
#import "TFCouponsListController.h"

@interface TFCouponsViewController ()
/** 分类左边数据 */
@property (nonatomic ,strong) NSMutableArray<TFLeftCategory *> *leftCategory;
/** 分类右边数据 */
@property (nonatomic ,strong) NSMutableArray<TFRightCategory *> *rightCategory;
/*** 存储对应下标 ***/
@property (nonatomic ,assign) NSInteger selectIndex;
@end

@implementation TFCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.selectIndex = 0;
    [self setupMenuData];
}

- (NSArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [[NSArray alloc] init];
    }
    return _rightArray;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kLeftWidth, TFMainScreen_Height - 113)];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 2;
        _layout.minimumLineSpacing = 2;
        
        _layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    }
    return _layout;
}

- (UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kLeftWidth, 64, self.view.xtf_width - kLeftWidth, TFMainScreen_Height - 113) collectionViewLayout:self.layout];
        _rightCollectionView.dataSource = self;
        _rightCollectionView.delegate = self;
        _rightCollectionView.alwaysBounceVertical = YES;
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        /*** 注册cell ***/
        [_rightCollectionView registerClass:[TFRightCollectionViewCell class] forCellWithReuseIdentifier:RightCollectionViewCell];
        [_rightCollectionView registerClass:[TFRightReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RightCollectionHeader];
    }
    return _rightCollectionView;
}

- (void)setupMenuData
{
    __weak typeof(self) homeSelf = self;
    [TFNetworkTools getSortWithDataRequestBlock:^(id content) {
        NSArray *data = content[@"results"];
        homeSelf.leftCategory = [TFLeftCategory mj_objectArrayWithKeyValuesArray:data];
        
        [self setupMenuView];
    }];
}

- (void)setupMenuView
{
    _rightArray = [[self.leftCategory objectAtIndex:0] valueForKey:@"fenlei"];
    
    /*** 左边的视图 ***/
    [self.view addSubview:self.leftTableView];
    /*** 右边的视图 ***/
    [self.view addSubview:self.rightCollectionView];
    
    if (self.leftCategory.count > 0) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
}

#pragma mark -- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFLeftTableViewCell *cell = [TFLeftTableViewCell cellWithTableView:tableView];
    cell.leftCategory = self.leftCategory[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    _rightArray = [[self.leftCategory objectAtIndex:indexPath.row] valueForKey:@"fenlei"];
    [self.rightCollectionView reloadData];
}

/**
 *  右边菜单
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = [[_rightArray objectAtIndex:section] valueForKey:@"fenlei"];
    return [array count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_rightArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((TFMainScreen_Width - kLeftWidth - 8)/3, 35);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RightCollectionViewCell forIndexPath:indexPath];
    
    NSArray *array = [[_rightArray objectAtIndex:indexPath.section] valueForKey:@"fenlei"];
    self.rightCategory = [TFRightCategory mj_objectArrayWithKeyValuesArray:array];
    cell.rightCategory = self.rightCategory[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TFRightReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:RightCollectionHeader forIndexPath:indexPath];
    
    NSString *title = [[_rightArray objectAtIndex:indexPath.section] valueForKey:@"c_name"];
    view.headerTitile.text = title;
    
    return self.selectIndex > 1 ? view : nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {TFMainScreen_Width,44};
    return self.selectIndex >1 ? size : CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [[_rightArray objectAtIndex:indexPath.section] valueForKey:@"fenlei"];
    self.rightCategory = [TFRightCategory mj_objectArrayWithKeyValuesArray:array];
    
    TFCouponsListController *chief = [[TFCouponsListController alloc] init];
    chief.title = self.rightCategory[indexPath.row].c_name;
    [self.navigationController pushViewController:chief animated:YES];
}
@end
