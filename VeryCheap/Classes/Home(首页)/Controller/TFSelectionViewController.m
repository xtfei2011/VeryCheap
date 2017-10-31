//
//  TFSelectionViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSelectionViewController.h"
#import "TFBannerView.h"
#import "TFBanner.h"
#import "TFCategoryViewCell.h"
#import "TFHomeListViewCell.h"

@interface TFSelectionViewController ()
/*** 数据源 ***/
@property (nonatomic ,strong) NSMutableArray<TFBanner *> *banner;
@end

@implementation TFSelectionViewController
/** cell的重用标识 */
static NSString * const HomeListID = @"TFHomeListViewCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFHomeListViewCell class]) bundle:nil] forCellReuseIdentifier:HomeListID];
    [self loadHomeViewData];
}

- (void)setupTopView
{
    CGFloat bannerH = 8 *TFMainScreen_Width/25;
    TFBannerView *bannerView = [[TFBannerView alloc] initWithFrame:CGRectMake(0, 64, TFMainScreen_Width, bannerH) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds), bannerH)];
    bannerView.banner = self.banner;
    self.tableView.tableHeaderView = bannerView;
    
    [bannerView bannerViewClick:^(TFBannerView *barnerView, NSInteger index) {
        TFLog(@"--->点击了%ld张图",index);
    }];
}

- (void)loadHomeViewData
{
    __weak typeof(self) homeSelf = self;
    
    [TFNetworkTools getResultWithUrl:@"http://api.17gwx.com/index/element?app_installtime=1509330284&app_version=1.3.4&channel_name=AppStore&client_id=4&device_id=AA3E27E6-3390-433E-A8BE-D85916EA34A9&device_info=iPhone6%2C2&gender=0&network=Wifi&os_version=10.3.1&sign=ed5b48d2c28ad0c8463f3f1e8e9c2644&timestamp=1509331218" params:nil success:^(id responseObject) {
        
        [responseObject writeToFile:@"/Users/xietengfei/Desktop/veryCheap.plist" atomically:YES];
        NSDictionary *dict = responseObject[@"data"];
        
        homeSelf.banner = [TFBanner mj_objectArrayWithKeyValuesArray:dict[@"banner_element"]];
        [self setupTopView];
        [homeSelf.tableView reloadData];
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 10 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 140 : 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFCategoryViewCell *cell = [TFCategoryViewCell cellWithTableView:tableView];
        return cell;
    } else {
        TFHomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeListID];
        return cell;
    }
}
@end
