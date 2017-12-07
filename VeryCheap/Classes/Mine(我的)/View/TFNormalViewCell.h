//
//  TFNormalViewCell.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFNormalCellModel.h"

@interface TFNormalViewCell : UITableViewCell
@property (nonatomic ,strong) TFNormalCellModel *normalCell;
+ (instancetype)initWithTableView:(UITableView *)tableview;
@end
