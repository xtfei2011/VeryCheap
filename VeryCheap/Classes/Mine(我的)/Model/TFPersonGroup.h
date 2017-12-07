//
//  TFPersonGroup.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/11.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFPersonGroup : NSObject
@property (nonatomic, strong) NSArray *items;

@end


@interface TFInfoCellModel : NSObject
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *title;

- (TFInfoCellModel *)initWithImage:(NSString *)image title:(NSString *)title;
@end
