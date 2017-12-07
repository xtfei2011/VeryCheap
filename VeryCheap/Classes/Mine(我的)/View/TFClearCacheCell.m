//
//  TFClearCacheCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/12.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFClearCacheCell.h"
#import "NSString+TFExtension.h"

@interface TFClearCacheCell ()
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *subTitleLabel;
@end
@implementation TFClearCacheCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ClearCacheCell";
    TFClearCacheCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TFClearCacheCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, TFMainScreen_Width/3, 50)];
        _titleLabel.text = @"清除缓存";
        _titleLabel.font = TFCommentTitleFont;
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TFMainScreen_Width * 2/3, 0, TFMainScreen_Width/3 - 30, 50)];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_subTitleLabel];
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            unsigned long long size = TFCustomCacheFile.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            if (weakSelf == nil) return;
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            NSString *text = [NSString stringWithFormat:@"(%@)", sizeText];
            
            dispatch_async(dispatch_get_main_queue(), ^{
           
                weakSelf.subTitleLabel.text = text;
                weakSelf.subTitleLabel.font = TFCommentTitleFont;
          
                weakSelf.accessoryView = nil;
    
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                
                weakSelf.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}

/**
 *  清除缓存
 */
- (void)clearCache
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.labelText = @"正在清理中";
    hud.mode = MBProgressHUDModeDeterminate;
    [TFkeyWindowView addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        
        while (hud.progress < 1.0) {
            hud.progress += 0.01;
            [NSThread sleepForTimeInterval:0.02];
        }
        hud.labelText = @"清理完成";
    } completionBlock:^{
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:TFCustomCacheFile error:nil];
                [manager createDirectoryAtPath:TFCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.subTitleLabel.text = @"(0B)";
                });
            });
        }];
    }];
}

/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}
@end
