//
//  TFSearchViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/4.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSearchViewController.h"
#import "TFSearchTextField.h"
#import "TFHotSearchViewCell.h"
#import "TFSearchRecordCell.h"
#import "TFSearchSectionHeader.h"
#import "TFSearchModel.h"
#import "TFCouponsListController.h"

#define KSearchRecordArr @"KsearchRecordArr"
@interface TFSearchViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) TFSearchTextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, retain) NSMutableArray *hotSearchArr;
@property (nonatomic, strong) TFSearchModel *searchModel;

@end

@implementation TFSearchViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTextField = [[TFSearchTextField alloc] initWithFrame:CGRectMake(50, 33, TFMainScreen_Width - 90, 31)];
    self.searchTextField.delegate = self;
    self.navigationItem.titleView = self.searchTextField;
    [self loadingData];
}

- (void)loadingData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [defaults objectForKey:KSearchRecordArr];
    
    if ((!(arr.count == 0))&&(![arr isKindOfClass:[NSNull class]])) {
        
        self.dataArr = [arr mutableCopy];
    }
    self.hotSearchArr = [NSMutableArray array];
    
    [TFNetworkTools getSearchWithUrl:@"http://ppapi.haopianyi.com/Public/hpyapi/?service=Shop.Skeywords&sign=a7a45014d7a5fcec5c73c3633d585b61" success:^(id content) {
        
        NSArray *data = content[@"data"][@"list"];
        
        for (NSDictionary *dic in data) {
            TFSearchModel *searchModel = [[TFSearchModel alloc] init];
            [searchModel setValuesForKeysWithDictionary:dic];
            [self.hotSearchArr addObject:searchModel];
        }
        [self.tableView reloadData];
    }];
}

- (void)deleteBtnAction:(UIButton *)sender
{
    [self createdAlertview:@"确定要删除历史记录"];
}

#pragma mark 提示框
- (void)createdAlertview:(NSString *)str
{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str  preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dataArr removeAllObjects];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.dataArr forKey:KSearchRecordArr];
        [defaults synchronize];
        [self.tableView reloadData];
    }]];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1: self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 ) {
        TFSearchRecordCell *cell = [TFSearchRecordCell cellWithTableView:tableView];
        if (self.dataArr.count != 0) {
            cell.labeText.text = self.dataArr[self.dataArr.count - 1 - indexPath.row];
        }
        return cell;
        
    }else{
        
        TFHotSearchViewCell *cell = [TFHotSearchViewCell cellWithTableView:tableView];
        
        if (self.hotSearchArr.count != 0) {
            cell.hotSearchArr = self.hotSearchArr;
            [cell.hotSearchView reloadData];
            
            cell.block = ^(NSString *title){
                
                TFCouponsListController *couponsList = [[TFCouponsListController alloc] init];
                couponsList.title = title;
                [self.navigationController pushViewController:couponsList animated:YES];
            };
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 110 : 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TFSearchSectionHeader *footer = [[TFSearchSectionHeader alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width, 45)];
    
    if (section == 1) {
        
        footer.iconImage.image = [UIImage imageNamed:@"Search_icon"];
        footer.titleLbael.text = @"历史搜索";
        [footer.deletBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }else{
        footer.iconImage.image = [UIImage imageNamed:@"hot_Search"];
        footer.titleLbael.text = @"热门搜索";
        footer.deletBtn.hidden = YES;
        return footer;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        
        TFCouponsListController *couponsList = [[TFCouponsListController alloc] init];
        couponsList.title = self.dataArr[self.dataArr.count - 1 - indexPath.row];;
        [self.navigationController pushViewController:couponsList animated:YES];
    }
}

#pragma mark textFild的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        [TFProgressHUD showInfoMsg:@"搜索商品不能为空！"];
        return;
    }
    [self.dataArr addObject:textField.text];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.dataArr forKey:KSearchRecordArr];
    [defaults synchronize];
    [self.tableView reloadData];
    
    TFCouponsListController *couponsList = [[TFCouponsListController alloc] init];
    couponsList.title = textField.text;
    [self.navigationController pushViewController:couponsList animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchTextField resignFirstResponder];
    return YES;
}
@end
