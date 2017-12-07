//
//  TFCouponsViewController.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCouponsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong) UITableView *leftTableView;
@property (nonatomic ,strong) UICollectionView *rightCollectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout * layout;
@property (nonatomic ,strong) NSArray *rightArray;
@end
