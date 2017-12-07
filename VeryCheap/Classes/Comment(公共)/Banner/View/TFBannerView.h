//
//  TFBannerView.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFBannerView,TFBanner;
typedef void(^BannerViewClick)(TFBannerView *bannerView ,NSString *type ,NSString *name);

@interface TFBannerView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *bannerCollectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;
/*** 数据源 ***/
@property (nonatomic ,strong) NSMutableArray<TFBanner *> *banner;
@property (nonatomic ,copy) BannerViewClick bannerClick;

/*** 初始化 ***/
- (instancetype)initWithFrame:(CGRect)frame viewSize:(CGSize)viewSize;
/*** 点击事件 Block ***/
- (void)bannerViewClick:(void(^)(TFBannerView *barnerView ,NSString *type ,NSString *name))block;
@end
