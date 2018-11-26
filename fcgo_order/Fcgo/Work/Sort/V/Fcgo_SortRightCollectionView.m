//
//  Fcgo_SortRightCollectionView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortRightCollectionView.h"
#import "Fcgo_SortRightCollectionViewCell.h"
#import "Fcgo_SortFristCollectionHeaderView.h"
#import "Fcgo_SortRightBrandCollectionViewCell.h"
#import "Fcgo_SortRightMoreBrandCollectionViewCell.h"

@interface Fcgo_SortRightCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collection;

@end

@implementation Fcgo_SortRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collection];
    }
    return self;
}

- (void)setSortModel:(Fcgo_SortModel *)sortModel
{
    _sortModel = sortModel;
    [self.collection reloadData];
}

#pragma mark CollectionView delegate dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.sortModel) {
        if (section == 0) {
            return self.sortModel.cateArray.count;
        }
        else{
            if (self.sortModel.brandArray.count>5) {
                return 6;
            }
            return self.sortModel.brandArray.count+1;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Fcgo_SortRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sortRightCollectionViewCell" forIndexPath:indexPath];
        if (self.sortModel)
        {
            cell.model = self.sortModel.cateArray[indexPath.item];
        }
        return cell;
    }
    
    if (self.sortModel) {
        Fcgo_SortRightMoreBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sortRightMoreBrandCollectionViewCell" forIndexPath:indexPath];
        if (self.sortModel.brandArray.count>5) {
            if (indexPath.item == 5)
            {
                 return cell;
            }
        }else{
            if (indexPath.item == self.sortModel.brandArray.count)
            {
                return cell;
            }
        }
    }
    Fcgo_SortRightBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sortRightBrandCollectionViewCell" forIndexPath:indexPath];
    if (self.sortModel)
    {
        
        cell.model = self.sortModel.brandArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        if (self.sortModel)
        {
            Fcgo_CateModel *model = self.sortModel.cateArray[indexPath.item];
            self.didSelectCateBlock(model);
        }
    }
    else if (indexPath.section == 1)
    {
        
        if (self.sortModel.brandArray.count>5) {
            if (indexPath.item == 5)
            {
                if (self.gotTotalBrandBlock) {
                    self.gotTotalBrandBlock();
                }
            }
            else{
                Fcgo_BrandModel *model = self.sortModel.brandArray[indexPath.item];
                self.didSelectBrandBlock(self.sortModel,model);
            }
            
        }else{
            if (indexPath.item == self.sortModel.brandArray.count)
            {
                if (self.gotTotalBrandBlock) {
                    self.gotTotalBrandBlock();
                }
            }
            else{
                Fcgo_BrandModel *model = self.sortModel.brandArray[indexPath.item];
                self.didSelectBrandBlock(self.sortModel,model);
            }
        }
        
//        //更多品牌
//        if (indexPath.item == self.sortModel.brandArray.count) {
//            if (self.gotTotalBrandBlock) {
//                self.gotTotalBrandBlock();
//            }
//        }else{
//            if (self.sortModel)
//            {
//                Fcgo_BrandModel *model = self.sortModel.brandArray[indexPath.item];
//                self.didSelectBrandBlock(model);
//            }
//        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return CGSizeMake((self.mj_w - kAutoWidth6(20))/3-1,(self.mj_w - kAutoWidth6(20))/3+40);
    }
    
    return CGSizeMake((self.mj_w - kAutoWidth6(40))/3,(self.mj_w - kAutoWidth6(40))/3 /2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    return kAutoWidth6(10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf)
    
    if (kind == UICollectionElementKindSectionHeader) {
        Fcgo_SortFristCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sortFristCollectionHeaderView" forIndexPath:indexPath];
        
        [headerView addSubview:headerView.headerBtn];
        [headerView addSubview:headerView.titleLabel];
        if (indexPath.section == 0) {
           [headerView.headerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.left.mas_offset(kAutoWidth6(10));
               make.right.mas_offset(kAutoWidth6(-10));
               make.height.mas_offset((weakSelf.mj_w -24)*300/756);
               
           }];
           [headerView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(headerView.headerBtn.mas_bottom).mas_offset(0);
               make.bottom.left.right.mas_offset(0);
            }];
           
           [headerView.headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.sortModel.sort_picurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"1105X348（活动）"]];
            
            [headerView.headerBtn addTarget:self action:@selector(touchHeaderImage) forControlEvents:UIControlEventTouchUpInside];
             headerView.headerBtn.hidden = 0;
            if (self.sortModel) {
                NSString *name = self.sortModel.sort_name;
                if (name.length<4) {
                    name = [NSString stringWithFormat:@"%@分类",name];
                }
                headerView.titleLabel.text = name;
            }
        }
        else
        {
            headerView.titleLabel.text = @"热门品牌";
            headerView.headerBtn.hidden = 1;
            [headerView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.centerX.mas_equalTo(headerView.mas_centerX);
                make.bottom.mas_offset(0);
            }];
        }
        return headerView;
    }
    return nil;
}

- (void)touchHeaderImage
{
    if (self.didSelectHeaderBlock) {
        self.didSelectHeaderBlock(self.sortModel);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;
    if (section == 0) {
        height = (self.mj_w - kAutoWidth6(20))*300/756 + kAutoWidth6(60) + 12 ;
    }else{
        height = kAutoWidth6(60);
    }
    
    CGSize size = CGSizeMake(self.mj_w, height);
    return size;
}

#pragma mark Lazy method

- (UICollectionView *)collection
{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = kAutoWidth6(1);
        flowLayout.minimumLineSpacing = kAutoWidth6(1);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kAutoWidth6(10), kAutoWidth6(10), kAutoWidth6(10));
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h) collectionViewLayout:flowLayout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = UIFontWhiteColor;
        _collection.showsVerticalScrollIndicator = 0;
        _collection.alwaysBounceVertical = YES;
        [_collection registerClass:[Fcgo_SortFristCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sortFristCollectionHeaderView"];
        [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SortRightCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"sortRightCollectionViewCell"];
        [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SortRightBrandCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"sortRightBrandCollectionViewCell"];
        [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SortRightMoreBrandCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"sortRightMoreBrandCollectionViewCell"];
        if (@available(iOS 11.0, *)) {
            _collection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collection;
}

@end
