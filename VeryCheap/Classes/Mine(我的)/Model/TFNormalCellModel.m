//
//  TFNormalCellModel.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFNormalCellModel.h"

@implementation TFNormalCellModel
- (TFNormalCellModel *)initWithImage:(NSString *)image title:(NSString *)titile subTitle:(NSString *)subTitle
{
    TFNormalCellModel *model = [[TFNormalCellModel alloc] init];
    model.image = image;
    model.title = titile;
    model.subTitle = subTitle;
    return model;
}
@end
