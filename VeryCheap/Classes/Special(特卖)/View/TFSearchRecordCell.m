//
//  TFSearchRecordCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFSearchRecordCell.h"

@implementation TFSearchRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TFSearchRecordCell";
    TFSearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TFSearchRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width, 50)];
        backgroundView.image = [UIImage imageNamed:@"mainCellBackground"];
        backgroundView.userInteractionEnabled = YES;
        [self.contentView addSubview:backgroundView];
        
        self.labeText = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, TFMainScreen_Width - 30, 50)];
        self.labeText.font = TFCommentTitleFont;
        [backgroundView addSubview:self.labeText];
    }
    return self;
}
@end
