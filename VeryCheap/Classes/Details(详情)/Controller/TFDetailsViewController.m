//
//  TFDetailsViewController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFDetailsViewController.h"
#import "TFNavigationBar.h"
#import "TFBasicInformationCell.h"
#import "TFDetailsViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "TFWebImageAutoSize.h"
#import "TFDetailBottomTool.h"
#import "TFDetails.h"
#import "TFWebViewController.h"
#import "TFShareManager.h"

#define NAVBAR_COLORCHANGE_POINT (-BannerView_Height + NavigationBar_Height*2)
#define NavigationBar_Height 64
#define BannerView_Height TFMainScreen_Width
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(BannerView_Height + SCROLL_DOWN_LIMIT)

@interface TFDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) SDCycleScrollView *bannerView;
@property (nonatomic ,strong) TFDetails *details;
@property (nonatomic ,strong) NSMutableArray *bannerArray;
@property (nonatomic ,strong) NSMutableArray *detailsArray;
@property (nonatomic ,strong) TFDetailBottomTool *bottomTool;
@property (nonatomic ,strong) TFShareManager *shareView;
@end

@implementation TFDetailsViewController
/** cell的重用标识 */
static NSString * const BasicInformationID = @"TFBasicInformationCell";
static NSString * const DetailsID = @"TFDetailsViewCell";

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, TFMainScreen_Width, TFMainScreen_Height - 55);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = TFGlobalBg;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    
    [self xtfei_setNavBarBarTintColor:TFrayColor(247)];
    [self xtfei_setNavBarBackgroundAlpha:0];
    [self xtfei_setNavBarTintColor:[UIColor whiteColor]];
    
    [self basicSetup];
    [self setupBottomTool];
    [self loadDetailsViewData];
}

- (void)basicSetup
{
    self.tableView.contentInset = UIEdgeInsetsMake(BannerView_Height - 64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFBasicInformationCell class]) bundle:nil] forCellReuseIdentifier:BasicInformationID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFDetailsViewCell class]) bundle:nil] forCellReuseIdentifier:DetailsID];
}

/*** 轮播View ***/
- (void)setBannerArray:(NSMutableArray *)bannerArray
{
    _bannerArray = bannerArray;
    
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -BannerView_Height, TFMainScreen_Width, BannerView_Height) imageNamesGroup:bannerArray];
    _bannerView.pageDotColor = [UIColor lightGrayColor];
    _bannerView.currentPageDotColor = [UIColor whiteColor];
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    
    [self.tableView addSubview:_bannerView];
}

- (void)setupBottomTool
{
    _bottomTool = [TFDetailBottomTool viewFromXib];
    
    __weak typeof(self) homeSelf = self;
    _bottomTool.block = ^(NSInteger index) {
        
        TFLog(@"----->%ld",index);
        [homeSelf bottomToolBtnClick:index];
    };
    [self.view addSubview:_bottomTool];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NavigationBar_Height;
        [self xtfei_setNavBarBackgroundAlpha:alpha];
        [self xtfei_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self xtfei_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self xtfei_setStatusBarStyle:UIStatusBarStyleDefault];
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigation_back_normal" highImage:@"navigation_back_normal" target:self action:@selector(back)];
    } else {
        [self xtfei_setNavBarBackgroundAlpha:0];
        [self xtfei_setNavBarTintColor:[UIColor whiteColor]];
        [self xtfei_setNavBarTitleColor:[UIColor whiteColor]];
        [self xtfei_setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back" target:self action:@selector(back)];
    }
    //限制下拉的距离
    if (offsetY < LIMIT_OFFSET_Y) {
        
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    } else if (offsetY > TFMainScreen_Width/3) {
        self.navigationItem.title = @"详情";
        
    } else {
        self.navigationItem.title = @"宝贝";
    }
    
    // 改变图片框的大小 (上滑的时候不改变)
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < -BannerView_Height) {
        self.bannerView.frame = CGRectMake(0, newOffsetY, TFMainScreen_Width, -newOffsetY);
    }
}

/*** 获取详情页数据 ***/
- (void)loadDetailsViewData
{
    __weak typeof(self) homeSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tbid"] = self.selection.tbid;
    params[@"activityid"] = self.selection.activityid;
    params[@"service"] = @"Default.DDetail";
    
    [TFNetworkTools getResultWithUrl:Comment_DataInterface params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        NSDictionary *contentDict = [responseObject[@"data"] objectForKey:@"list"];
        homeSelf.details = [TFDetails mj_objectWithKeyValues:contentDict];
        [homeSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)setDetails:(TFDetails *)details
{
    _details = details;
    _bottomTool.details = self.details;
    [self loadDatailImage:details.detailurl];
}

- (void)loadDatailImage:(NSString *)url
{
    __weak typeof(self) homeSelf = self;
    [TFNetworkTools getResultBannerWithUrl:url success:^(id content) {
        /*** 顶部轮播图信息 ***/
        NSDictionary *dict = [content[@"data"] objectForKey:@"itemInfoModel"];
        if (dict) {
            homeSelf.bannerArray = [dict objectForKey:@"picsPath"];
        }
        /*** 详情图片信息 ***/
        NSDictionary *detailUrl = [content[@"data"] objectForKey:@"descInfo"];
        if (detailUrl[@"briefDescUrl"]) {
            [self loadDatailImage:detailUrl[@"briefDescUrl"]];
        }
        homeSelf.detailsArray = [content[@"data"] objectForKey:@"images"];
        [homeSelf.tableView reloadData];
    }];
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailsArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 216;
    } else {
        NSString *url = self.detailsArray[indexPath.row - 1];
        return [TFWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:TFMainScreen_Width - 16 estimateHeight:TFMainScreen_Width];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TFBasicInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:BasicInformationID];
        cell.selection = self.selection;
        cell.block = ^(NSInteger index) {
            
            TFLog(@"----->%ld",index);
        };
        return cell;
        
    } else {
        TFDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailsID];
        cell.imageUrl = self.detailsArray[indexPath.row - 1];
        return cell;
    }
}

/*** 底部工具栏点击事件 ***/
- (void)bottomToolBtnClick:(NSInteger)index
{
    switch (index) {
        case 1:{
            TFLog(@"首页");
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2:
            TFLog(@"分享");
            [self shareButtonClicked];
            break;
        case 3:{
            TFLog(@"不领劵");
            TFWebViewController *webView = [[TFWebViewController alloc] init];
            [webView loadWebURLString:self.details.clickurl];
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 4:{
            TFLog(@"领劵");
            TFWebViewController *webView = [[TFWebViewController alloc] init];
            [webView loadWebURLString:self.details.url];
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        default:
            break;
    }
}

/*** 分享 ***/
- (void)shareButtonClicked
{
    _shareView = [[TFShareManager alloc] init];
    
    NSString *sharUrl = [NSString stringWithFormat:@"%@?tbid=%@&xiaoliang=%@&laiyuan=%@&yuanjia=%@&jiage=%@&quan=%@&activityid=%@&baoyou=%@", self.details.shareurl ,self.selection.tbid ,self.selection.xiaoliang ,self.selection.laiyuan ,self.selection.yuanjia ,self.selection.jiage ,self.selection.quan ,self.selection.activityid ,self.selection.baoyou];
    
    [_shareView setupShareViewController:self shareTitle:nil shareContent:self.selection.title shareIcon:self.selection.titlepic shareUrl:sharUrl];
    
    [_shareView show];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
