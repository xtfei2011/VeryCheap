//
//  TFSelectView.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,TFButtonClickType) {
    
    TFButtonClickTypeNormal = 0,
    TFButtonClickTypeUp = 1,
    TFButtonClickTypeDown = 2,
};

@class TFSelectView;
@protocol TFSelectViewDelegate <NSObject>
/*** 按钮的点击事件 ***/
- (void)selectButton:(TFSelectView *)selectView withIndex:(NSInteger)index withButtonType:(TFButtonClickType)type;
@end

@interface TFSelectView : UIView

@property (nonatomic ,strong) id<TFSelectViewDelegate>delegate;
@end
