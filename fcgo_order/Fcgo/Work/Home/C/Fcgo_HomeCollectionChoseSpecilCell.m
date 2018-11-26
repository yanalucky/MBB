//
//  Fcgo_HomeCollectionChoseSpecilCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionChoseSpecilCell.h"
#import "Fcgo_HomeChoseSpecilCollectionCell.h"

@interface Fcgo_HomeCollectionChoseSpecilCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) UIButton  *specialBtn;

@end

@implementation Fcgo_HomeCollectionChoseSpecilCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.contentView addSubview:self.collectionview];
    [self.contentView addSubview:self.specialBtn];
    
    [self.specialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_offset(kScreenWidth*290/621);
        make.top.mas_offset(0);
    }];
}

- (void)setModel:(Fcgo_HomeTopicModel *)model
{
    _model = model;
    [self.specialBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.href] forState:UIControlStateNormal];
    [self.collectionview setContentOffset:CGPointMake(0, 0)];
    [self.collectionview reloadData];
    
}

- (UIButton *)specialBtn
{
    if (!_specialBtn) {
        _specialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialBtn addTarget:self action:@selector(specialClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _specialBtn;
}

- (void)specialClick
{
    if (!self.specialBlock) {
        return;
    }
    self.specialBlock(self.model);
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = kAutoWidth6px(64);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenWidth*290/621, kScreenWidth, kAutoWidth6px(300)+65) collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIFontWhiteColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.showsHorizontalScrollIndicator = NO;
        [_collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeChoseSpecilCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeChoseSpecilCollectionCell"];
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *specialArray = self.model.datas;
    if (specialArray.count>0)
    {
        return specialArray.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_HomeChoseSpecilCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeChoseSpecilCollectionCell" forIndexPath:indexPath];
    NSArray *specialArray = self.model.datas;
    if (specialArray.count>0)
    {
        Fcgo_HomeGoodsModel *model = specialArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *specialArray = self.model.datas;
    if (specialArray.count>0)
    {
       Fcgo_HomeGoodsModel *model = specialArray[indexPath.row];
        self.selectItemBlock(model);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kAutoWidth6px(300), kAutoWidth6px(300)+64);
}

@end
