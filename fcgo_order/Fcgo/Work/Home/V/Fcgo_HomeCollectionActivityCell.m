//
//  Fcgo_HomeCollectionActivityCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionActivityCell.h"
#import "Fcgo_HomeCollectionActivityImgCell.h"

@interface Fcgo_HomeCollectionActivityCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation Fcgo_HomeCollectionActivityCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setPromoteMutableArray:(NSMutableArray *)promoteMutableArray
{
    _promoteMutableArray = promoteMutableArray;
    [self.collectionView reloadData];
}

- (void)setupUI
{
   [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionActivityImgCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionActivityImgCell"];
   
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
}

#pragma mark CollectionView delegate dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.promoteMutableArray && self.promoteMutableArray.count>0) {
        return self.promoteMutableArray.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_HomeCollectionActivityImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionActivityImgCell" forIndexPath:indexPath];
    if (self.promoteMutableArray && self.promoteMutableArray.count>0) {
        NSDictionary *dict = self.promoteMutableArray[indexPath.item];
        NSString *imgUrl = dict[@"picUrl"];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"580X580"]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.promoteMutableArray && self.promoteMutableArray.count>0) {
        NSDictionary *dict = self.promoteMutableArray[indexPath.item];
        if (self.didTouchBlock) {
            self.didTouchBlock(dict);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-10)/2,(kScreenWidth-10)/2*300/612);
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIFontWhiteColor;
        collectionView.showsHorizontalScrollIndicator = 0;
        _collectionView = collectionView;
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

@end

