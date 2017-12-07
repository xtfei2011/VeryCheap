//
//  TFRightCollectionViewCell.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFRightCategory;
@interface TFRightCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,strong) TFRightCategory *rightCategory;
@end
