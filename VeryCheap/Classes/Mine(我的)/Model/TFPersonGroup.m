//
//  TFPersonGroup.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFPersonGroup.h"

@implementation TFPersonGroup

@end


@implementation TFInfoCellModel
- (TFInfoCellModel *)initWithImage:(NSString *)image title:(NSString *)title
{
    TFInfoCellModel *info = [[TFInfoCellModel alloc] init];
    info.image = image;
    info.title = title;
    return info;
}
@end
