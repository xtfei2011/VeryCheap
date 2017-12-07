//
//  TFNormalViewCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFNormalViewCell.h"

@implementation TFNormalViewCell
+ (instancetype)initWithTableView:(UITableView *)tableview
{
    TFNormalViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"normalcell"];
    if (cell == nil) {
        cell = [[TFNormalViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"normalcell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = TFCommentTitleFont;
        self.detailTextLabel.font = TFCommodityTitleFont;
    }
    return self;
}

- (void)setNormalCell:(TFNormalCellModel *)normalCell
{
    _normalCell = normalCell;
    
    self.imageView.image = [UIImage imageNamed:normalCell.image];
    self.textLabel.text = normalCell.title;
    
    self.detailTextLabel.text = (normalCell.subTitle) ? normalCell.subTitle : nil;
}
@end
