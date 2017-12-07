//
//  TFCouponsListController.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCouponsListController : UIViewController <UITableViewDataSource,UITableViewDelegate>
/*** 列表 TableView ***/
@property (nonatomic ,strong) UITableView *couponsListTableView;
@end
