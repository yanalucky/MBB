//
//  Fcgo_Market_SetShopBGVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_SetShopBGVC.h"
#import "Fcgo_Market_SetShopBGCell.h"


@interface Fcgo_Market_SetShopBGVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,assign) NSInteger item;

@end

@implementation Fcgo_Market_SetShopBGVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"选择背景图"];
    [self.view addSubview:self.collectionview];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_Market_SetShopBGCell class]) bundle:nil] forCellWithReuseIdentifier:@"market_SetShopBGCell"];
    self.collectionview.frame =  CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight-kTabBarHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_Market_SetShopBGCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"market_SetShopBGCell" forIndexPath:indexPath];
    if (indexPath.item == self.item) {
        cell.selected = YES;
    }
    else{
       cell.selected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_Market_SetShopBGCell *deselectedCell = (Fcgo_Market_SetShopBGCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.item inSection:0]];
    deselectedCell.selected = NO;
    
    Fcgo_Market_SetShopBGCell *selectedCell = (Fcgo_Market_SetShopBGCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectedCell.selected = YES;
    self.item = indexPath.item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (kScreenWidth - 40)/3;
    return CGSizeMake(width, width);
}

#pragma mark Lazy method

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewLeftAlignedLayout *flowLayout= [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIBackGroundColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.alwaysBounceVertical = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

@end



