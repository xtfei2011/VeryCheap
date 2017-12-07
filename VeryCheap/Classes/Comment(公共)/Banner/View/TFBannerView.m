//
//  TFBannerView.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFBannerView.h"
#import "TFBannerViewCell.h"
#define TFMaxSections 100

@interface TFBannerView ()
@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,assign) CGSize bannerViewSize;
@property (nonatomic ,strong) NSTimer *timer;
@end

@implementation TFBannerView
/** cell的重用标识 */
static NSString *const TFBannerCollectionViewID = @"TFBannerCollectionViewCell";

/*** 初始化 ***/
- (instancetype)initWithFrame:(CGRect)frame viewSize:(CGSize)viewSize
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bannerViewSize = viewSize;
        [self initiateTimer];
    }
    return self;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(self.bannerViewSize.width, self.bannerViewSize.height);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

- (UICollectionView *)bannerCollectionView
{
    if (!_bannerCollectionView) {
        
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _bannerCollectionView.delegate = self;
        _bannerCollectionView.dataSource = self;
        _bannerCollectionView.showsHorizontalScrollIndicator = false;
        _bannerCollectionView.pagingEnabled = true;
        _bannerCollectionView.backgroundColor = [UIColor clearColor];
        [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:TFMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
        
        /*** 注册 CollectionViewCell ***/
        [self registerCollectionViewCell];
    }
    return _bannerCollectionView;
}

/*** 注册 CollectionViewCell ***/
- (void)registerCollectionViewCell
{
    [self addSubview:_bannerCollectionView];
    [self addSubview:_pageControl];
    
    [_bannerCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TFBannerViewCell class]) bundle:nil] forCellWithReuseIdentifier:TFBannerCollectionViewID];
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        CGFloat pageControlY = self.bannerViewSize.height - 12;
        CGFloat pageControlW = self.bannerViewSize.width;
       
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageControlY, pageControlW, 6)];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return TFMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.banner.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TFBannerCollectionViewID forIndexPath:indexPath];
    cell.banner = self.banner[indexPath.row];
    return cell;
}

- (void)setBanner:(NSMutableArray<TFBanner *> *)banner
{
    _banner = banner;
    
    if (_banner.count < 2) {
        self.bannerCollectionView.scrollEnabled = false;
        [self.pageControl setHidden:true];
    } else {
        self.bannerCollectionView.scrollEnabled = true;
        [self.pageControl setHidden:false];
    }
    
    [self.bannerCollectionView reloadData];
    self.pageControl.numberOfPages = banner.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % _banner.count;
    
    self.pageControl.currentPage = page;
}

/*** 添加定时器 ***/
- (void)initiateTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:true];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    if (_banner.count < 2) return;
    
    NSIndexPath *indexPath = [[self.bannerCollectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *indexPathSet = [NSIndexPath indexPathForItem:indexPath.row inSection:TFMaxSections/2];
    
    [self.bannerCollectionView scrollToItemAtIndexPath:indexPathSet atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    NSInteger nextItem = indexPathSet.item + 1;
    NSInteger nextSection = indexPathSet.section;
    
    if (nextItem == _banner.count) {
        nextItem = 0;
        nextSection ++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.bannerCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bannerClick) {
        self.bannerClick(self, _banner[indexPath.row].type ,_banner[indexPath.row].name);
    }
}

/*** 移除定时器 ***/
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self initiateTimer];
}

- (void)bannerViewClick:(void (^)(TFBannerView *, NSString * ,NSString *))block
{
    self.bannerClick = block;
}
@end
