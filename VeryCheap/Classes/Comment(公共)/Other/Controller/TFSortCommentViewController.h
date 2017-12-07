//
//  TFSortCommentViewController.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSortCommentViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *sortCommentView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;

@property (nonatomic ,strong) NSString *type;
@end
