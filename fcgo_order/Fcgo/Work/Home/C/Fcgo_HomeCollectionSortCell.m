//
//  Fcgo_HomeCollectionSortCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionSortCell.h"
#import "Fcgo_HomeSortIconCollectionViewCell.h"

#define ItemWidth   ((kScreenWidth - 2*kAutoWidth6(15))/5)
#define ItemHeight  ((ItemWidth - kAutoWidth6(30)) + 23)

@interface Fcgo_HomeCollectionSortCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *sortIconCollectionView;

@end

@implementation Fcgo_HomeCollectionSortCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.sortIconCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeSortIconCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeSortIconCollectionViewCell"];
    [self.contentView addSubview:self.sortIconCollectionView];
    [self.sortIconCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
}

- (void)setSortIconArray:(NSMutableArray *)sortIconArray
{
    _sortIconArray = sortIconArray;
    [self.sortIconCollectionView setContentOffset:CGPointMake(0, 0)];
    [self.sortIconCollectionView reloadData];
    
    static int a = 0;
    if (a != 0) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        a = 1;
        CGFloat x = self.sortIconCollectionView.contentSize.width;
        [UIView animateWithDuration:1 animations:^{
//            [self.sortIconCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:sortIconArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             [self.sortIconCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//        });
        self.sortIconCollectionView.contentOffset = CGPointMake(x-kScreenWidth, 0);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                self.sortIconCollectionView.contentOffset = CGPointMake(0, 0);
            }];
        }];
    });
}

#pragma mark CollectionView delegate dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.sortIconArray&&self.sortIconArray.count>0)
    {
        return self.sortIconArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_HomeSortIconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeSortIconCollectionViewCell" forIndexPath:indexPath];
    if (self.sortIconArray&&self.sortIconArray.count>0)
    {
        Fcgo_HomeSortIconModel *sortIconModel = self.sortIconArray[indexPath.item];
        cell.sortIconModel = sortIconModel;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sortIconArray&&self.sortIconArray.count>0)
    {
        Fcgo_HomeSortIconModel *sortIconModel = self.sortIconArray[indexPath.item];
        self.sortIconBlock(sortIconModel);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ItemWidth,ItemHeight);
}

- (UICollectionView *)sortIconCollectionView
{
    if (!_sortIconCollectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(kAutoWidth6(15), kAutoWidth6(10), kAutoWidth6(15), kAutoWidth6(10));
        _sortIconCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ItemHeight*2 + kAutoWidth6(15)*2 + 15) collectionViewLayout:flowLayout];
        _sortIconCollectionView.backgroundColor = [UIColor clearColor];
        _sortIconCollectionView.delegate = self;
        _sortIconCollectionView.dataSource = self;
        _sortIconCollectionView.showsHorizontalScrollIndicator = 0;
        _sortIconCollectionView.backgroundColor = UIFontWhiteColor;
        if (@available(iOS 11.0, *)) {
            _sortIconCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _sortIconCollectionView;
}
@end
