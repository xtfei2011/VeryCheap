//
//  TFNormalCellModel.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFNormalCellModel : NSObject
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subTitle;
@property(nonatomic, assign) Class destVc;

- (TFNormalCellModel *)initWithImage:(NSString *)image title:(NSString *)titile subTitle:(NSString *)subTitle;
@end
