//
//  TFMenueBarShowController.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMenueBarShowController.h"
#import "TFMenuViewCell.h"

#define kRowCount 4
#define kMargin 6
#define kCellH 80

@interface TFMenueBarShowController ()

@end

@implementation TFMenueBarShowController
static NSString *const reuseIdentifier = @"menue";

- (void)setProtocol:(NSArray<id<TFSegmentProtocol>> *)protocol
{
    _protocol = protocol;
    
    NSInteger rows = (_protocol.count + (kRowCount - 1)) / kRowCount;
    CGFloat height = rows * (kCellH + kMargin);
    self.collectionView.xtf_height = height;
    self.expectedHeight = height;
    [self.collectionView reloadData];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (TFMainScreen_Width - kMargin * (kRowCount + 1)) / kRowCount;
    CGFloat height = kCellH;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = kMargin;
    flowLayout.minimumInteritemSpacing = kMargin;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (instancetype)init
{
    return [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"TFMenuViewCell" bundle:currentBundle];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.protocol.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.menuLabel.text = self.protocol[indexPath.row].classname;
    [cell.menuImageView sd_setImageWithURL:[NSURL URLWithString:self.protocol[indexPath.row].icon]];

    return cell;
}
@end
