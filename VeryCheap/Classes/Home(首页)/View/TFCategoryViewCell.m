//
//  TFCategoryViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCategoryViewCell.h"
#import "UIButton+AFNetworking.h"

@interface TFCategoryViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *upperBtn;
@property (weak, nonatomic) IBOutlet UIButton *lowerBtn;
@end

@implementation TFCategoryViewCell

static NSString *const cellID = @"CategoryViewCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    #define Button_BackgroundImage_Montage(A)  [NSString stringWithFormat:@"http://www.haopianyi.com/wx/dl/res/nb4/%@",A]
    
    [self.leftBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:Button_BackgroundImage_Montage(@"nb4_1.png")] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
    
    [self.rightBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:Button_BackgroundImage_Montage(@"nb4_21.png")] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
    
    [self.upperBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:Button_BackgroundImage_Montage(@"nb4_3.png")] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
    
    [self.lowerBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:Button_BackgroundImage_Montage(@"nb4_4.png")] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    TFCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TFCategoryViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (IBAction)categoryButton:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(sortButtonClick:)]){
        [_delegate sortButtonClick:sender];
    }
}
@end
