//
//  TFHotSearchViewCell.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSearchModel.h"

typedef void(^HotSearchblock) (NSString *title);
@interface TFHotSearchViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,retain) NSMutableArray *hotSearchArr;
@property (nonatomic, retain) UICollectionView *hotSearchView;
@property (nonatomic ,strong) HotSearchblock block;
@end
