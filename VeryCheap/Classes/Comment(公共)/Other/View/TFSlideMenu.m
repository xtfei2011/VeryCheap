//
//  TFSlideMenu.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSlideMenu.h"
#import "UIButton+TFExtension.h"

@interface TFSlideMenu ()<UIScrollViewDelegate>
/*** 左边索引 ***/
@property (nonatomic ,assign) NSInteger leftIndex;
/*** 右边索引 ***/
@property (nonatomic ,assign) NSInteger rightIndex;
/*** 子控制器数组 ***/
@property (nonatomic ,strong) NSArray *controllers;
/*** 标题数组 ***/
@property (nonatomic ,strong) NSArray *titles;
/*** item数组 ***/
@property (nonatomic ,strong) NSMutableArray *itemArray;
/*** 菜单文字滚动条 ***/
@property (nonatomic ,strong) UIScrollView *titleScrollView;
/*** 子控制器滚动视图 ***/
@property (nonatomic ,strong) UIScrollView *childScrollView;
/*** 下标视图 ***/
@property (nonatomic ,strong) UIView *indicatorView;
/*** 选中索引 ***/
@property (nonatomic ,assign) NSInteger currentIndex;
@end

@implementation TFSlideMenu
/*** 菜单文字滚动条 ***/
- (UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _titleScrollView.showsVerticalScrollIndicator = false;
        _titleScrollView.showsHorizontalScrollIndicator = false;
        _titleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _titleScrollView;
}

/*** 下标视图 ***/
- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = TFColor(245, 80, 83);
        _indicatorView.layer.cornerRadius = 1;
        _indicatorView.layer.masksToBounds = true;
    }
    return _indicatorView;
}

/*** 子控制器滚动视图 ***/
- (UIScrollView *)childScrollView
{
    if (!_childScrollView) {
        _childScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _childScrollView.showsVerticalScrollIndicator = false;
        _childScrollView.showsHorizontalScrollIndicator = false;
        _childScrollView.bounces = false;
        _childScrollView.delegate = self;
        _childScrollView.pagingEnabled = true;
    }
    return _childScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles controllers:(NSArray *)controllers
{
    self = [super initWithFrame:frame];
    if (self) {
        self.controllers = controllers;
        self.titles = titles;
        
        self.itemArray = [NSMutableArray array];
        
        [self addSubview:self.titleScrollView];
        [self.titleScrollView addSubview:self.indicatorView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, self.xtf_width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self addSubview:lineView];
    }
    return self;
}

- (void)reloadTitles:(NSArray *)titles controllers:(NSArray *)controllers index:(NSInteger)index
{
    self.titles = titles;
    self.controllers = controllers;
    self.currentIndex = index;
    
    [self setNeedsLayout];
}

/*** 调整位置 ***/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleScrollView.frame = self.bounds;
    
    [self setupMenuTitle];
    [self setupChildScrollView];
    [self loadChildScrollViewAtIndex:_currentIndex];
    [self resetTitleScrollViewFrame];
    
    self.childScrollView.contentSize = CGSizeMake(self.childScrollView.xtf_width *_controllers.count, self.childScrollView.xtf_height);
    [self.childScrollView setContentOffset:CGPointMake(self.childScrollView.xtf_width * self.currentIndex, 0) animated:false];

    [self setupIndicatorView];
}
/*** 菜单滚动视图 ***/
- (void)setupIndicatorView
{
    UIButton *currentItem = self.itemArray[_currentIndex];
    CGRect frame = currentItem.frame;
    frame.origin.y = self.xtf_height - 4;
    frame.size.height = 2;
    
    frame.origin.x = CGRectGetMidX(frame) - 30 *0.5;
    frame.size.width = 30;
    
    self.indicatorView.frame = frame;
}
/*** 菜单按钮 ***/
- (void)setupMenuTitle
{
    for (UIButton *item in self.itemArray) {
        [item removeFromSuperview];
    }
    [self.itemArray removeAllObjects];
    
    CGFloat originX = 0;   CGFloat textLength = 0;
    for (int i = 0; i < self.titles.count; i ++) {
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:self.titles[i] forState:UIControlStateNormal];
        [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [item setTitleColor:TFColor(245, 80, 83) forState:UIControlStateSelected];
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize size = [self.titles[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        item.frame = CGRectMake(originX, 0, size.width + 30, self.xtf_height);
        item.textWidth = size.width;
        originX = CGRectGetMaxX(item.frame);
        [self.itemArray addObject:item];
        [self.titleScrollView addSubview:item];
        item.selected = i == _currentIndex;
        textLength += size.width;
    }
    _titleScrollView.contentSize = CGSizeMake(originX, self.xtf_height);
}

- (void)itemClicked:(UIButton *)button
{
    if (button.selected) return;
    [self scrollIndex:[_itemArray indexOfObject:button]];
}

/*** 设置子控制器滚动视图 ***/
- (void)setupChildScrollView
{
    if (self.childView == nil) {
        [self.superview addSubview:self.childScrollView];
    } else {
        [self.childView addSubview:self.childScrollView];
    }
}

/*** 加载子控制器 ***/
- (void)loadChildScrollViewAtIndex:(NSInteger)index
{
    UIViewController *vc = _controllers[index];
    
    if (!vc.viewLoaded) {
        vc.view.frame = self.childScrollView.bounds;
        vc.view.center = CGPointMake(CGRectGetWidth(self.childScrollView.frame) *(index + 0.5), self.childScrollView.xtf_height *0.5);
        [self.childScrollView addSubview:vc.view];
    }
}
/*** 滚动内容视图 Frame ***/
- (void)setChildFrame:(CGRect)childFrame
{
    self.childScrollView.frame = childFrame;
    self.childScrollView.contentSize = CGSizeMake(childFrame.size.width *self.controllers.count, childFrame.size.height);
}
/*** 调整滚动偏移量 ***/
- (void)scrollIndex:(NSInteger)index
{
    if (_itemArray.count <= index) {
        _currentIndex = index;
        return;
    }
    UIButton *fromItem = _itemArray[_currentIndex];
    UIButton *item = _itemArray[index];
    
    _currentIndex = index;
    
    fromItem.selected = false;
    item.selected = true;
    CGRect bounds = self.indicatorView.bounds;
    bounds.size.width = item.textWidth;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.bounds = bounds;
        self.indicatorView.center = CGPointMake(item.xtf_centerX, self.indicatorView.xtf_centerY);
        self.indicatorView.center = CGPointMake(item.center.x, self.indicatorView.center.y);
    } completion:^(BOOL finished) {
        [self.childScrollView setContentOffset:CGPointMake(self.childScrollView.xtf_width *index, 0) animated:false];
        [self resetTitleScrollViewFrame];
    }];
}

- (void)resetTitleScrollViewFrame
{
    UIButton *selectedItem = self.itemArray[_currentIndex];
    CGFloat titleScrollW = self.titleScrollView.xtf_width;
    CGFloat reviseX;
    
    if (selectedItem.xtf_centerX + titleScrollW *0.5 >= self.titleScrollView.contentSize.width) {
        reviseX = self.titleScrollView.contentSize.width - titleScrollW;
    } else if (selectedItem.xtf_centerX - titleScrollW *0.5 <= 0) {
        reviseX = 0;
    } else {
        reviseX = selectedItem.xtf_centerX - titleScrollW *0.5;
    }
    [self.titleScrollView setContentOffset:CGPointMake(reviseX, 0) animated:true];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.childScrollView) {
        
        CGFloat offsetX = scrollView.contentOffset.x;
        _currentIndex = lroundf(offsetX / scrollView.xtf_width);
        NSInteger index = _currentIndex;
        
        if (offsetX > scrollView.xtf_width * _currentIndex) {
            index = (_currentIndex + 1) >= _itemArray.count ? _currentIndex : _currentIndex + 1;
        } else if (offsetX < scrollView.xtf_width *_currentIndex) {
            index = (_currentIndex - 1) < 0 ? 0 : _currentIndex - 1;
        }
        [self loadChildScrollViewAtIndex:index];
        
        if (offsetX <= 0) {
            
            self.leftIndex = 0;
            self.rightIndex = self.leftIndex;
        } else if (offsetX >= scrollView.contentSize.width - scrollView.xtf_width) {
            
            self.leftIndex = self.itemArray.count - 1;
            self.rightIndex = self.leftIndex;
        } else {
            self.leftIndex = (NSInteger)(offsetX / scrollView.xtf_width);
            self.rightIndex = self.leftIndex + 1;
        }
        CGFloat relativeLocation = (offsetX / scrollView.xtf_width - self.leftIndex);
        if (relativeLocation == 0) return;
        
        [self updateIndicatorStyle:relativeLocation];
        [self updateTitleStyle:relativeLocation];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.childScrollView) {
        self.currentIndex = scrollView.contentOffset.x / scrollView.xtf_width;
        [self resetTitleScrollViewFrame];
    }
}

- (void)updateIndicatorStyle:(CGFloat)relativeLocation
{
    UIButton *leftItem = self.itemArray[self.leftIndex];
    UIButton *rightItem = self.itemArray[self.rightIndex];
    CGFloat widthMax = rightItem.textWidth - leftItem.textWidth;
    self.indicatorView.xtf_width = leftItem.textWidth + widthMax *relativeLocation;
    self.indicatorView.frame = self.indicatorView.frame;
    
    CGFloat max = rightItem.xtf_centerX - leftItem.xtf_centerX;
    self.indicatorView.center = CGPointMake(leftItem.xtf_centerX + max *relativeLocation, self.indicatorView.xtf_centerY);
}

- (void)updateTitleStyle:(CGFloat)relativeLocation
{
    UIButton *leftItem = self.itemArray[self.leftIndex];
    UIButton *rightItem = self.itemArray[self.rightIndex];
    
    leftItem.selected = relativeLocation <= 0.5;
    rightItem.selected = !leftItem.selected;
    
    CGFloat percent = relativeLocation <= 0.5 ? (1-relativeLocation) : relativeLocation;
    [leftItem setTitleColor:[self titleNormalColor:[UIColor grayColor] selectedColor:TFColor(245, 80, 83) percent:percent] forState:UIControlStateSelected];
    [leftItem setTitleColor:[self titleNormalColor:TFColor(245, 80, 83) selectedColor:[UIColor grayColor] percent:percent] forState:UIControlStateNormal];
    [rightItem setTitleColor:[self titleNormalColor:[UIColor grayColor] selectedColor:TFColor(245, 80, 83) percent:percent] forState:UIControlStateSelected];
    [rightItem setTitleColor:[self titleNormalColor:TFColor(245, 80, 83) selectedColor:[UIColor grayColor] percent:percent] forState:UIControlStateNormal];
}

- (UIColor *)titleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor percent:(CGFloat)percent
{
    CGFloat NormalRed = 0;
    CGFloat NormalGreen = 0;
    CGFloat NormalBlue = 0;
    CGFloat NormalAlpha = 0;
    [normalColor getRed:&NormalRed green:&NormalGreen blue:&NormalBlue alpha:&NormalAlpha];
    
    CGFloat SelectedRed = 0;
    CGFloat SelectedGreen = 0;
    CGFloat SelectedBlue = 0;
    CGFloat SelectedAlpha = 0;
    [selectedColor getRed:&SelectedRed green:&SelectedGreen blue:&SelectedBlue alpha:&SelectedAlpha];
    
    CGFloat Red = NormalRed + (SelectedRed - NormalRed) *percent;
    CGFloat Green = NormalGreen + (SelectedGreen - NormalGreen) *percent;
    CGFloat Blue = NormalBlue + (SelectedBlue - NormalBlue) *percent;
    CGFloat Alpha = NormalAlpha + (SelectedAlpha - NormalAlpha) *percent;
    [normalColor getRed:&NormalRed green:&NormalGreen blue:&NormalBlue alpha:&NormalAlpha];
    
    return [UIColor colorWithRed:Red green:Green blue:Blue alpha:Alpha];
}
@end
