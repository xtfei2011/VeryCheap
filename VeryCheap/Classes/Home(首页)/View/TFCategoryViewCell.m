//
//  TFCategoryViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCategoryViewCell.h"

@interface TFCategoryViewCell ()
@property (nonatomic ,strong) UIView *baseView;
@property (nonatomic ,strong) UIImageView *imageViewOne;
@property (nonatomic ,strong) UIImageView *imageViewTwo;
@property (nonatomic ,strong) UIImageView *imageViewThree;
@property (nonatomic ,strong) UIImageView *imageViewSix;
@end

@implementation TFCategoryViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"release";
    TFCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TFCategoryViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellAccessoryNone;
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
    self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width, 140)];
    self.baseView.backgroundColor = TFRandomColor;
    [self.contentView addSubview:self.baseView];
}
@end
