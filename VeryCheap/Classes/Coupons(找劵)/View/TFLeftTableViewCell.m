//
//  TFLeftTableViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFLeftTableViewCell.h"

@interface TFLeftTableViewCell ()
@property (nonatomic ,strong) UIView *lineView;
@end

@implementation TFLeftTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = LeftTabelViewCell;
    TFLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TFLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, kLeftWidth, 43.5)];
    self.baseView.backgroundColor = TFGlobalBg;
    [self.contentView addSubview:self.baseView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, _baseView.xtf_width - 3, _baseView.xtf_height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = TFCommentTitleFont;
    self.titleLabel.textColor = TFrayColor (130);
    self.titleLabel.highlightedTextColor = TFColor(251, 44, 107);
    [self.baseView addSubview:self.titleLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
    self.lineView.backgroundColor = TFColor(251, 44, 107);
    [self.baseView addSubview:self.lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.baseView.backgroundColor = selected ? [UIColor whiteColor] : TFGlobalBg;
    
    self.highlighted = selected;
    self.titleLabel.highlighted = selected;
    self.lineView.backgroundColor = selected ? TFColor(251, 44, 107) : TFGlobalBg;;
}

- (void)setLeftCategory:(TFLeftCategory *)leftCategory
{
    _leftCategory = leftCategory;
    self.titleLabel.text = leftCategory.c_name;
}
@end
