//
//  TFSearchRecordCell.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSearchRecordCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)UILabel *labeText;
@end
