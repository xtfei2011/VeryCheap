//
//  TFMineViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMineViewController.h"
#import "TFPersonGroup.h"
#import "TFNormalCellModel.h"
#import "TFNormalViewCell.h"
#import "TFClearCacheCell.h"
#import "TFWebViewController.h"

@interface TFMineViewController ()
@property (nonatomic, strong) NSMutableArray *normalArray;
@end

@implementation TFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    self.tableView.tableFooterView = [UIView new];
    [self setupInterface];
}

- (void)setupInterface
{
    self.normalArray = [NSMutableArray array];
    TFPersonGroup *group0 = [[TFPersonGroup alloc] init];
    TFNormalCellModel *info0 = [[TFNormalCellModel alloc] initWithImage:nil title:@"关于我们" subTitle:nil];
    group0.items = @[info0];
    
    [self.normalArray addObject:group0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        TFPersonGroup *temp = self.normalArray[0];
        return temp.items.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.normalArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFClearCacheCell *clear = [TFClearCacheCell cellWithTableView:tableView];
        return clear;
    }else{
        TFNormalViewCell *cell = [TFNormalViewCell initWithTableView:tableView];
        TFPersonGroup *group = self.normalArray[0];
        TFNormalCellModel *normalCell = group.items[indexPath.row];
        cell.normalCell = normalCell;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFWebViewController *webView = [[TFWebViewController alloc] init];
    webView.navigationItem.title = @"关于我们";
    [webView loadWebURLString:@"http://www.haopianyi.com/appmy.html"];
    [self.navigationController pushViewController:webView animated:YES];
    
}
@end
