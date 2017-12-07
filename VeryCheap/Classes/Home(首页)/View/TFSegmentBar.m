//
//  TFSegmentBar.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSegmentBar.h"
#import "TFSegmentLeftRightBtn.h"
#import "TFMenueBarShowController.h"

#define kShowMoreBtnW (self.bounds.size.height + 30)
@interface TFSegmentBar ()<UICollectionViewDelegate>

/** 用于显示内容选项卡的视图 */
@property (nonatomic ,strong) UIScrollView *contentScrollView;

/** 用于标识选项卡的指示器 */
@property (nonatomic ,strong) UIView *indicatorView;

/** 用于存储选项按钮数组 */
@property (nonatomic ,strong) NSMutableArray <UIButton *>*segBtns;

/** 用于记录上次选项 */
@property (nonatomic ,weak) UIButton *lastBtn;

/** 选项卡显示配置 ,修改此模型属性之后 ,需要调用updateViewWithConfig 生效 */
@property (nonatomic ,strong) TFSegmentConfig *segmentConfig;

@property (nonatomic ,strong) TFSegmentLeftRightBtn *showMoreBtn;
@property (nonatomic ,nonnull ,strong) UIView *coverView;
@property (nonatomic ,strong) TFMenueBarShowController *showDetailVC;

@end

@implementation TFSegmentBar

- (TFMenueBarShowController *)showDetailVC {
    if (!_showDetailVC) {
        _showDetailVC = [[TFMenueBarShowController alloc] init];
        _showDetailVC.collectionView.delegate = self;
    }
    if (_showDetailVC.collectionView.superview != self.superview) {
        _showDetailVC.collectionView.frame = CGRectMake(0, self.xtf_y + self.xtf_height, self.xtf_width, 0);
        [self.superview addSubview:_showDetailVC.collectionView];
    }
    
    return _showDetailVC;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, self.xtf_y + self.xtf_height, self.xtf_width, 0)];
        _coverView.backgroundColor = TFRGBColor(55, 55, 55, 0.4);
        UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetailPane)];
        [_coverView addGestureRecognizer:gester];
    }
    if (!_coverView.superview) {
        [self.superview insertSubview:_coverView belowSubview:self.showDetailVC.collectionView];
    }
    return _coverView;
}

- (TFSegmentLeftRightBtn *)showMoreBtn
{
    if (!_showMoreBtn) {
        
        UIImage *showImage = [UIImage imageNamed:@"descending_order"];
        UIImage *hideImage = [UIImage imageNamed:@"ascending_order"];
        
        _showMoreBtn = [[TFSegmentLeftRightBtn alloc] init];
        [_showMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_showMoreBtn setImage:showImage forState:UIControlStateNormal];
        
        [_showMoreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_showMoreBtn setImage:hideImage forState:UIControlStateSelected];
        _showMoreBtn.imageView.contentMode = UIViewContentModeCenter;
        [_showMoreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        // 添加分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 1, 20)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_showMoreBtn addSubview:line];
        
        [_showMoreBtn addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_showMoreBtn];
    }
    return _showMoreBtn;
}

#pragma mark - 懒加载属性
/** 用于显示内容选项卡的视图 */
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

/** 用于标识选项卡的指示器 */
- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.xtf_height - self.segmentConfig.indicatorHeight, 0, self.segmentConfig.indicatorHeight)];
        _indicatorView.backgroundColor = self.segmentConfig.indicatorColor;
        [self.contentScrollView addSubview:_indicatorView];
    }
    return _indicatorView;
}

/** 用于存储选项卡的数组 */
- (NSMutableArray<UIButton *> *)segBtns
{
    if (!_segBtns) {
        _segBtns = [NSMutableArray array];
    }
    return _segBtns;
}

/**
 *  根据配置选项, 创建一个选项卡条
 *
 *  @param config 选项卡配置
 *
 *  @return 选项卡
 */
+ (instancetype)segmentBarWithConfig:(TFSegmentConfig *)config {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect defaultFrame = CGRectMake(0, 0, width, 40);
    TFSegmentBar *segBar = [[TFSegmentBar alloc] initWithFrame:defaultFrame];
    segBar.segmentConfig = config;
    return segBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.segmentConfig = [TFSegmentConfig defaultConfig];
    }
    return self;
}

/**
 *  监听选项卡配置的改变
 *
 *  @param segmentConfig 选项卡配置模型
 */
- (void)updateViewWithConfig:(void(^)(TFSegmentConfig *config))configBlock
{
    if (configBlock != nil) {
        configBlock(self.segmentConfig);
    }
    self.segmentConfig = self.segmentConfig;
    
}
-(void)setSegmentConfig:(TFSegmentConfig *)segmentConfig
{
    _segmentConfig = segmentConfig;
    
    // 指示器颜色
    self.indicatorView.backgroundColor
    = segmentConfig.indicatorColor;
    self.indicatorView.xtf_height = segmentConfig.indicatorHeight;
    
    // 选项颜色/字体
    for (UIButton *btn in self.segBtns) {
        [btn setTitleColor:segmentConfig.segNormalColor forState:UIControlStateNormal];
        if (btn != self.lastBtn) {
            btn.titleLabel.font = segmentConfig.segNormalFont;
        }else {
            btn.titleLabel.font = segmentConfig.segSelectedFont;
        }
        [btn setTitleColor:segmentConfig.segSelectedColor forState:UIControlStateSelected];
    }
    
    // 最小间距
    [self layoutIfNeeded];
    [self layoutSubviews];
}
/**
 *  根据配置, 更新视图
 */
- (void)updateViewWithConfig
{
    self.segmentConfig = self.segmentConfig;
}

/**
 *  监听选项卡数据源的改变
 *
 *  @param protocol 选项卡数据源
 */
- (void)setProtocol:(NSArray<id<TFSegmentProtocol>> *)protocol
{
    _protocol = protocol;
    
    if (self.segmentConfig.isShowMore) {
        self.showDetailVC.protocol = _protocol;
        self.showDetailVC.collectionView.xtf_height = 0;
    }
    
    // 移除之前所有的子控件
    [self.segBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.segBtns = nil;
    self.lastBtn = nil;
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
    
    // 添加最新的子控件
    int i = 0;
    for (NSObject<TFSegmentProtocol> *segM in protocol) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        i ++;

        [btn addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = self.segmentConfig.segNormalFont;
        [btn setTitleColor:self.segmentConfig.segNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.segmentConfig.segSelectedColor forState:UIControlStateSelected];
        [btn setTitle:segM.classname forState:UIControlStateNormal];
        [self.contentScrollView addSubview:btn];
        [btn sizeToFit];
        
        // 保存到一个数组中
        [self.segBtns addObject:btn];
    }
    // 重新布局
    [self layoutIfNeeded];
    [self layoutSubviews];
    
    // 默认选中第一个选项卡
    [self segClick:[self.segBtns firstObject]];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (UIButton *btn in self.segBtns) {
        if (btn.tag == selectedIndex) {
            [self segClick:btn];
            break;
        }
    }
}

/**
 *  点击某个选项卡调用的事件
 */
- (void)segClick:(UIButton *)btn
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentBarDidSelectIndex:fromIndex:)])
    {
        _selectedIndex = btn.tag;
        [self.delegate segmentBarDidSelectIndex:_selectedIndex fromIndex:self.lastBtn.tag];
    }
    
    // 修改状态
    self.lastBtn.selected = NO;
    self.lastBtn.titleLabel.font = self.segmentConfig.segNormalFont;
    [self.lastBtn sizeToFit];
    self.lastBtn.xtf_height = self.contentScrollView.xtf_height - self.segmentConfig.indicatorHeight;
    
    btn.selected = YES;
    btn.titleLabel.font = self.segmentConfig.segSelectedFont;
    [btn sizeToFit];
    btn.xtf_height = self.contentScrollView.xtf_height - self.segmentConfig.indicatorHeight;
    self.lastBtn = btn;
    
    if (self.segmentConfig.isShowMore) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.lastBtn.tag inSection:0];
        [self.showDetailVC.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self hideDetailPane];
    }
    
    // 移动指示器位置
    [UIView animateWithDuration:0.2 animations:^{
        
        // 控制宽度, 和中心
        NSString *text = btn.titleLabel.text;
        NSDictionary *fontDic = @{
                                  NSFontAttributeName : btn.titleLabel.font
                                  };
        CGSize size = [text sizeWithAttributes:fontDic];
        self.indicatorView.xtf_y = self.contentScrollView.xtf_height - self.segmentConfig.indicatorHeight;
        self.indicatorView.xtf_width = size.width + self.segmentConfig.indicatorExtraWidth;
        self.indicatorView.xtf_centerX = btn.xtf_centerX;
        
    }];
    
    // 自动滚动到中间位置
    CGFloat shouldScrollX = btn.xtf_centerX - self.contentScrollView.xtf_width * 0.5;
    
    if (shouldScrollX < 0) {
        shouldScrollX = 0;
    }
    
    if (shouldScrollX > self.contentScrollView.contentSize.width - self.contentScrollView.xtf_width) {
        shouldScrollX = self.contentScrollView.contentSize.width - self.contentScrollView.xtf_width;
    }
    [self.contentScrollView setContentOffset:CGPointMake(shouldScrollX, 0) animated:YES];
}

- (void)showOrHide:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showDetailPane];
    }else {
        [self hideDetailPane];
    }
}

- (void)showDetailPane
{
    self.showMoreBtn.selected = YES;
    self.showDetailVC.collectionView.hidden = NO;
    self.coverView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.xtf_height = self.showDetailVC.expectedHeight;
        self.coverView.xtf_height = [UIScreen mainScreen].bounds.size.height;
    }];
}

- (void)hideDetailPane
{
    self.showMoreBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.xtf_height = 0;
        self.coverView.xtf_height = 0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.showDetailVC.collectionView.hidden = YES;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentScrollView.frame = self.bounds;
    
    if (!self.segmentConfig.isShowMore) {
        self.contentScrollView.frame = self.bounds;
        self.showMoreBtn.xtf_width = -1;
    }else {
        self.contentScrollView.frame = CGRectMake(0, 0, self.xtf_width - kShowMoreBtnW, self.xtf_height);
        self.showMoreBtn.frame = CGRectMake(self.xtf_width - kShowMoreBtnW, 0, kShowMoreBtnW, self.xtf_height);
    }
    
    // 1. 计算间距
    CGFloat titleTotalW = 0;
    for (int i = 0; i < self.segBtns.count; i++)  {
        [self.segBtns[i] sizeToFit];
        CGFloat width = self.segBtns[i].xtf_width;
        titleTotalW += width;
    }
    
    CGFloat margin = (self.contentScrollView.xtf_width - titleTotalW) / (self.protocol.count + 1);
    margin = margin < self.segmentConfig.limitMargin ? self.segmentConfig.limitMargin : margin;
    
    // 布局topmMenue 内部控件
    CGFloat btnY = 0;
    
    CGFloat btnHeight = self.contentScrollView.xtf_height - self.segmentConfig.indicatorHeight;
    UIButton *lastBtn;
    for (int i = 0; i < self.segBtns.count; i++) {
        
        // 计算每个控件的宽度
        CGFloat btnX = CGRectGetMaxX(lastBtn.frame) + margin;
        self.segBtns[i].xtf_x = btnX;
        self.segBtns[i].xtf_y = btnY;
        self.segBtns[i].xtf_height = btnHeight;
        
        lastBtn = self.segBtns[i];
    }
    self.contentScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame) + margin, 0);
    // 修正指示器的位置, 控制宽度, 和中心
    if (self.lastBtn) {
        NSString *text = self.lastBtn.titleLabel.text;
        NSDictionary *fontDic = @{
                                  NSFontAttributeName : self.lastBtn.titleLabel.font
                                  };
        CGSize size = [text sizeWithAttributes:fontDic];
        self.indicatorView.xtf_y = self.contentScrollView.xtf_height - self.segmentConfig.indicatorHeight;
        self.indicatorView.xtf_width = size.width + self.segmentConfig.indicatorExtraWidth;
        self.indicatorView.xtf_centerX = self.lastBtn.xtf_centerX;
    }
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self hideDetailPane];
}
@end
