//
//  Fcgo_SiftMainView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SiftMainView.h"
#import "Fcgo_SiftMainCollectionCell.h"
#import "Fcgo_SiftMainCollectionHeaderView.h"
#import "Fcgo_SiftMainCollectionFooterView.h"
#import "Fcgo_SiftCateModel.h"//一级分类
#import "Fcgo_SiftCatemModel.h"//二级分类
#import "Fcgo_BrandModel.h"

@interface Fcgo_SiftMainView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIButton         *confirmBtn;
@property (nonatomic,strong) UIButton         *replaceBtn;
@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) NSMutableArray   *flagArray;
//因为贸易类型不在服务器返回数据中，所以声明变量来记录她是否选中，m默认是-1，初始进来都不选中
@property (nonatomic,assign) NSInteger        tradeSelectIndex;

@end


@implementation Fcgo_SiftMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontWhiteColor;
        [self addSubview:self.collectionview];
        [self addSubview:self.replaceBtn];
        [self addSubview:self.confirmBtn];
        self.tradeSelectIndex = -1;
        
        [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SiftMainCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"siftMainCollectionCell"];
        [self.collectionview registerClass:[Fcgo_SiftMainCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView"];
        [self.collectionview registerClass:[Fcgo_SiftMainCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"siftMainCollectionFooterView"];
        
        self.collectionview.frame =  CGRectMake(0, 20, self.mj_w, self.mj_h - 20 - kAutoWidth6(50));
        self.replaceBtn.frame =  CGRectMake(0, self.mj_h - kAutoWidth6(50), self.mj_w/2, kAutoWidth6(50));
        self.confirmBtn.frame = CGRectMake(self.mj_w/2, self.mj_h - kAutoWidth6(50), self.mj_w/2, kAutoWidth6(50));
        [self.replaceBtn addTarget:self action:@selector(replace) forControlEvents:UIControlEventTouchUpInside];
        [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)replace
{
    if (self.resetBlock) {
        self.resetBlock();
    }
    
}

- (void)confirm
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)show:(Fcgo_IndexButton *)btn
{
    
    Fcgo_SiftMainCollectionHeaderView *headerView =  (Fcgo_SiftMainCollectionHeaderView *) [self.collectionview supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:btn.section]];
    NSString *flag = self.flagArray[btn.section];
    
    if (flag.intValue == 0) {
        [UIView animateWithDuration:0.15 animations:^{
            headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI );
        }
         completion:^(BOOL finished) {
             [self.collectionview reloadSections:[NSIndexSet indexSetWithIndex:btn.section]];
         }];
        
        [self.flagArray replaceObjectAtIndex:btn.section withObject:@"1"];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
        }completion:^(BOOL finished) {
            [self.collectionview reloadSections:[NSIndexSet indexSetWithIndex:btn.section]];
        }];
        [self.flagArray replaceObjectAtIndex:btn.section withObject:@"0"];
    }
}

- (void)setSiftArray:(NSMutableArray *)siftArray
{
    _siftArray = siftArray;
    
    [self.flagArray removeAllObjects];
    if (self.flagArray.count<=0) {
        for (int i = 0; i < siftArray.count; i ++) {
            [self.flagArray addObject:@"0"];
        }
    }
//    else if (self.flagArray.count < siftArray.count)
//    {
//        for (int i = (int)self.flagArray.count; i < siftArray.count; i ++) {
//            [self.flagArray addObject:@"0"];
//        }
//    }
//    
//    else if (self.flagArray.count > siftArray.count)
//    {
//        for (int i = (int)siftArray.count; i < self.flagArray.count; i ++) {
//            [self.flagArray removeObject:self.flagArray[i]];
//        }
//    }
    [self.collectionview reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.siftArray) {
        return self.siftArray.count;
    }
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.siftArray) {
        NSDictionary *siftDict = self.siftArray[section];
        NSArray *siftSubArray = siftDict[@"list"];
        NSString *flag = self.flagArray[section];
        if(flag.intValue == 0)
        {
            if (siftSubArray.count>8) {
                return 6;
            }
            else{
                return siftSubArray.count;
            }
        }
        else{
            return siftSubArray.count;

        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SiftMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"siftMainCollectionCell" forIndexPath:indexPath];
    if (self.siftArray) {
        NSDictionary *siftDict = self.siftArray[indexPath.section];
        NSArray *siftSubArray = siftDict[@"list"];
        id object = siftSubArray[indexPath.item];
        cell.object = object;
        //第0区始终是贸易类型，需记录和判断是否选中
        if (indexPath.section == 0) {
            if (indexPath.row == self.tradeSelectIndex) {
                cell.select = YES;
            }
            else{
                cell.select = NO;
            }
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *siftDict = self.siftArray[indexPath.section];
    Fcgo_SiftMainCollectionCell *cell = (Fcgo_SiftMainCollectionCell *)[collectionView  cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        //如果是第0区的贸易类型，点击已经选中的item，是记录选中的tradeSelectIndex至为-1
        if (cell.select) {
            self.tradeSelectIndex = -1;
            self.selectTradeItemBlock(@"",siftDict[@"type"]);
        }
        else
        {
            //如果没选中，首先是选中的变为未选中
            if (self.tradeSelectIndex>=0) {
                 Fcgo_SiftMainCollectionCell *selectedCell = (Fcgo_SiftMainCollectionCell *)[collectionView  cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.tradeSelectIndex inSection:0]];
                selectedCell.select = NO;
            }
            self.tradeSelectIndex = indexPath.item;
            self.selectTradeItemBlock([NSString stringWithFormat:@"%d",indexPath.item+1],siftDict[@"type"]);
        }
    }
    NSString *name = siftDict[@"name"];
    NSArray *siftSubArray = siftDict[@"list"];
    id object = siftSubArray[indexPath.item];
    
    if (cell.select) {
        if ([name isEqualToString:@"分类"])
        {
            self.selectCateItemBlock(@"",siftDict[@"type"]);
        }
        else if ([name isEqualToString:@"品牌"])
        {
            self.selectBrandItemBlock(@"",siftDict[@"type"]);
        }
        else if ([name isEqualToString:@"详细分类"])
        {
            self.selectCatemItemBlock(@"",siftDict[@"type"]);
        }

        else  if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *attrDict = object;
            self.selectAttrItemBlock(attrDict[@"name"],siftDict[@"type"],NO);
        }
    }
    else
    {
        if ([name isEqualToString:@"分类"])
        {
            Fcgo_SiftCateModel *model = object;
            
            self.selectCateItemBlock([NSString stringWithFormat:@"%@",model.f_cate_id],siftDict[@"type"]);
        }
        else if ([name isEqualToString:@"品牌"])
        {
            Fcgo_BrandModel *model = object;
            self.selectBrandItemBlock([NSString stringWithFormat:@"%@",model.brand_id],siftDict[@"type"]);
        }
        else if ([name isEqualToString:@"详细分类"])
        {
            Fcgo_SiftCatemModel *model = object;
            self.selectCatemItemBlock([NSString stringWithFormat:@"%@",model.f_catem_Id],siftDict[@"type"]);
        }
        else  if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *attrDict = object;
            self.selectAttrItemBlock(attrDict[@"name"],siftDict[@"type"],YES);
        }
    }
    cell.select = !cell.select;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake( 75, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        Fcgo_SiftMainCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView" forIndexPath:indexPath];
        
        [headerView addSubview:headerView.arrowImageView];
        [headerView addSubview:headerView.descriptionLabel];
        [headerView addSubview:headerView.titleLabel];
        [headerView addSubview:headerView.showBtn];
        headerView.showBtn.section = indexPath.section;
        [headerView.showBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.bottom.mas_offset(0);
            make.left.mas_offset(15);
            make.width.mas_offset(100);
        }];
        
        [headerView.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView.titleLabel.mas_centerY);
            make.right.mas_offset(-10);
            make.width.mas_offset(7*22/11);
            make.height.mas_offset(7);
        }];
        [headerView.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_equalTo(headerView.arrowImageView.mas_left).mas_offset(-5);
        }];
        [headerView.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        if (self.siftArray) {
            NSDictionary *siftDict = self.siftArray[indexPath.section];
            headerView.titleLabel.text = siftDict[@"name"];
            
            NSString *flag = self.flagArray[indexPath.section];
            if (flag.intValue == 0) {
                 headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            }
            else
            {
                headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI );
            }
        }
        return headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        Fcgo_SiftMainCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"siftMainCollectionFooterView" forIndexPath:indexPath];
        footerView.backgroundColor = UISepratorLineColor;
        return footerView;
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake(self.mj_w, 50);
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(self.mj_w, 0.5);
    return size;
}


#pragma mark Lazy method

- (UIButton *)replaceBtn
{
    if (!_replaceBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"重置" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIStringColor(@"fad8dc")];
        _replaceBtn = btn;
    }
    return _replaceBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIFontRedColor];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewLeftAlignedLayout *flowLayout= [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIFontWhiteColor;
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

- (NSMutableArray *)flagArray
{
    if (!_flagArray) {
        _flagArray = [[NSMutableArray alloc]init];
    }
    return _flagArray;
}

@end


