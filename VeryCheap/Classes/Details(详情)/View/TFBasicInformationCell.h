//
//  TFBasicInformationCell.h
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/20.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSelection.h"

typedef void(^MerchandiseBasicInfoBlock)(NSInteger index);

@interface TFBasicInformationCell : UITableViewCell

@property (nonatomic ,strong) TFSelection *selection;
@property (nonatomic ,copy) MerchandiseBasicInfoBlock block;

@end
