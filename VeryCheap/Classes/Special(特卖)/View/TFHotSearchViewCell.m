//
//  TFHotSearchViewCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFHotSearchViewCell.h"
#import "TFHotCollectionViewCell.h"

@interface TFHotSearchViewCell ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end
@implementation TFHotSearchViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TFHotSearchViewCell";
    TFHotSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TFHotSearchViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (UICollectionView *)hotSearchView
{
    if (!_hotSearchView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _hotSearchView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, TFMainScreen_Width, 300) collectionViewLayout:layout];
        //这是重点 自动适应
        layout.estimatedItemSize = CGSizeMake(10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 7;
        layout.minimumLineSpacing = 10;
        _hotSearchView.delegate = self;
        _hotSearchView.dataSource = self;
        _hotSearchView.scrollEnabled = NO;
        _hotSearchView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_hotSearchView];
        
        [_hotSearchView registerNib:[UINib nibWithNibName:@"TFHotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TFHotCollectionViewCell"];
    }
    return _hotSearchView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotSearchArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TFHotCollectionViewCell" forIndexPath:indexPath];
    TFSearchModel *searchModel = self.hotSearchArr[indexPath.row];
  
    if (self.hotSearchArr.count != 0) {

        cell.labeltitle.text = searchModel.keyboard;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(20, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFSearchModel *searchModel = self.hotSearchArr[indexPath.row];
    self.block(searchModel.keyboard);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.frame.size.width, 300);
}
@end
