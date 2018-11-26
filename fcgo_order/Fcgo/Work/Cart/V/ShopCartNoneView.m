//
//  ShopCartNoneView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartNoneView.h"
#import "ShopCartNoneCell.h"
#import "ShopCartNoneHeaderView.h"
#import "ShopCartNoneFooterView.h"
#import "HotCollectionCell.h"
@interface ShopCartNoneView ()<UICollectionViewDelegate,UICollectionViewDataSource>



@end

@implementation ShopCartNoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        WEAKSELF(weakSelf);
        self.backgroundColor = UIFontWhiteColor;
        
        self.collectionview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
            weakSelf.refreshBlock();
        }];
        [self addSubview:self.collectionview];
        
    }
    return self;
}

- (void)setGoodsNewArray:(NSMutableArray *)goodsNewArray
{
    _goodsNewArray = goodsNewArray;
    [self.collectionview reloadData];
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 7;
        flowLayout.minimumLineSpacing = 7;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 7, 0, 7);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h) collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
       [_collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartNoneCell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCartNoneCell"];
        [_collectionview registerClass:[ShopCartNoneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCartNoneHeaderView"];
        [_collectionview registerClass:[ShopCartNoneFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCartNoneFooterView"];
        [_collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"hotCollectionCell"];
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    if (self.goodsNewArray&&self.goodsNewArray.count>0)
    {
        return self.goodsNewArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShopCartNoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCartNoneCell" forIndexPath:indexPath];
        WEAKSELF(weakSelf);
        cell.goToVisit = ^{
            weakSelf.goToVisit();
        };
       return cell;
    }
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCollectionCell" forIndexPath:indexPath];
    if (self.goodsNewArray&&self.goodsNewArray.count>0)
    {
        Fcgo_HomeGoodsModel *model = self.goodsNewArray[indexPath.item];
        cell.goodsModel = model;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ShopCartNoneHeaderView *heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCartNoneHeaderView" forIndexPath:indexPath];
       
        [heardView addSubview:heardView.likeLabel];
        [heardView.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(heardView.mas_centerY);
            make.centerX.mas_equalTo(heardView.mas_centerX).mas_offset(11);
        }];
        
        [heardView addSubview:heardView.imgView];
        [heardView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(heardView.mas_centerY);
            make.right.mas_equalTo(heardView.likeLabel.mas_left).mas_offset(-4);
            make.width.mas_offset(18);
            make.height.mas_offset(18);
        }];
        return heardView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        ShopCartNoneFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCartNoneFooterView" forIndexPath:indexPath];
        
        [footerView addSubview:footerView.noMoreLabel];
        [footerView.noMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(footerView.mas_centerY);
            make.centerX.mas_equalTo(footerView.mas_centerX);
        }];
        return footerView;
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    
    if (self.goodsNewArray&&self.goodsNewArray.count>0)
    {
        Fcgo_HomeGoodsModel *model = self.goodsNewArray[indexPath.item];
        self.selectItemBlock(model);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth-14, kAutoWidth6px(962));
    }
    
    CGFloat width = (kScreenWidth - 21)/2;
    return CGSizeMake(width, width + 75);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(kScreenWidth, 40);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.goodsNewArray &&self.goodsNewArray.count>0) {
        if (section == 1) {
            return CGSizeMake(kScreenWidth, 40);
        }
    }
    return CGSizeZero;
}

@end
