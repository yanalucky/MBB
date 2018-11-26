//
//  Fcgo_GoodsSKUView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsSKUView.h"
#import "Fcgo_SiftMainCollectionCell.h"
#import "Fcgo_SiftMainCollectionHeaderView.h"
#import "Fcgo_GoodsSKUCountHeaderView.h"
#import "Fcgo_SiftMainCollectionFooterView.h"
#import "Fcgo_GoodsAttrModel.h"//一级分类
#import "Fcgo_AttrModel.h"

@interface Fcgo_GoodsSKUView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIButton *smallImgBtn;


@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UILabel *goodsStatus,*nameLabel,*priceLabel,*fregihtLabel,*singlePrice,*stock;
@property (nonatomic,strong) UIButton         *confirmBtn;
@property (nonatomic,strong) UIButton         *lowerBtn;

@property (nonatomic,strong) UICollectionView *collectionview;

@end

@implementation Fcgo_GoodsSKUView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.count  = 1;
        
        WEAKSELF(weakSelf)
        self.backgroundColor = UIFontWhiteColor;
        
        self.smallImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.smallImgBtn.frame = CGRectMake(12, -15, kAutoWidth6(100), kAutoWidth6(100));
        self.smallImgBtn.layer.cornerRadius = 4;
        self.smallImgBtn.layer.borderColor = UISepratorLineColor.CGColor;
        self.smallImgBtn.layer.borderWidth = 1;
        self.smallImgBtn.layer.masksToBounds = YES;
        self.smallImgBtn.userInteractionEnabled = YES;
        [self.smallImgBtn addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:self.smallImgBtn];
        
        [self.smallImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kAutoWidth6(-15));
            make.left.mas_offset(15);;
            make.height.width.mas_offset(kAutoWidth6(100));
        }];
        
        self.goodsStatus = [[UILabel alloc]init];
        self.goodsStatus.backgroundColor = UIRGBColor(0, 0, 0, 0.47);
        self.goodsStatus.layer.cornerRadius = kAutoWidth6(35);
        self.goodsStatus.layer.masksToBounds = YES;
        self.goodsStatus.textColor = UIFontWhiteColor;
        self.goodsStatus.font = [UIFont systemFontOfSize:12];
        self.goodsStatus.textAlignment = NSTextAlignmentCenter;
        self.goodsStatus.text = @"已售罄";
        self.goodsStatus.hidden = 1;
        [self addSubview:self.goodsStatus];
        
        [self.goodsStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.smallImgBtn.mas_centerX);
            make.centerY.mas_equalTo(weakSelf.smallImgBtn.mas_centerY);
            make.height.width.mas_offset(kAutoWidth6(70));
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = UIFontMainGrayColor;
        self.nameLabel.numberOfLines = 2;
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
            make.right.mas_equalTo(-40);
        }];
        
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.font = UIBoldFontSize(15);
        self.priceLabel.textColor = UIFontRedColor;
        [self addSubview:self.priceLabel];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).mas_offset(8);
            make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
            
        }];
        
        self.fregihtLabel = [[UILabel alloc]init];
        self.fregihtLabel.font = UIFontSize(12);
        self.fregihtLabel.textColor =  UIFontMainGrayColor;
        self.fregihtLabel.textAlignment = NSTextAlignmentLeft;
        self.fregihtLabel.text = @"(包含运费: --)";
        [self addSubview:self.fregihtLabel];
        [self.fregihtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.priceLabel.mas_centerY);
            make.left.mas_equalTo(weakSelf.priceLabel.mas_right).mas_offset(5);
            make.right.mas_equalTo(-12);
        }];
        
        self.singlePrice = [[UILabel alloc]init];
        self.singlePrice.font = UIFontSize(12);
        self.singlePrice.textColor =  UIFontMainGrayColor;
        self.singlePrice.textAlignment = NSTextAlignmentLeft;
        self.singlePrice.text = @"折合单价: --";
        [self addSubview:self.singlePrice];
        
        [self.singlePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).mas_offset(8);
            make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
        }];

        
        self.stock = [[UILabel alloc]init];
        self.stock.font = UIFontSize(12);
        self.stock.textColor =  UIFontMainGrayColor;
        self.stock.textAlignment = NSTextAlignmentRight;
        self.stock.text = @"库存: --";
        [self addSubview:self.stock];
        [self.stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).mas_offset(8);
            make.right.mas_equalTo(-12);
        }];

        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.frame = CGRectMake(kScreenWidth - 35, 5, 30, 30);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"btn-shut down"] forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(dismiss)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, kScreenWidth, 0.5)];
        line.backgroundColor = UISepratorLineColor;
        [self addSubview:line];
        
        [self addSubview:self.collectionview];
        [self addSubview:self.confirmBtn];
        [self addSubview:self.lowerBtn];
        [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SiftMainCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"siftMainCollectionCell"];
        [self.collectionview registerClass:[Fcgo_SiftMainCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView"];
        [self.collectionview registerClass:[Fcgo_SiftMainCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"siftMainCollectionFooterView"];
        
        [self.collectionview registerClass:[Fcgo_GoodsSKUCountHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"goodsSKUCountHeaderView"];
        
        
        self.collectionview.frame =  CGRectMake(0, 100, self.mj_w, self.mj_h - 100 - kAutoWidth6(50));
        self.confirmBtn.frame = CGRectMake(kAutoWidth6(125), self.mj_h - kAutoWidth6(50), self.mj_w -  kAutoWidth6(125), kAutoWidth6(50));
        [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        self.lowerBtn.frame = CGRectMake(0, self.mj_h-kAutoWidth6(50), kAutoWidth6(125), kAutoWidth6(50));
        [self.lowerBtn addTarget:self action:@selector(lowerPrice) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)dismiss
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
}
- (void)setInfoModel:(Fcgo_GoodsInfoModel *)infoModel
{
    _infoModel = infoModel;
    if (!self.bestSKUModel) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.minpriceYUAN floatValue]];
        self.singlePrice.text = [NSString stringWithFormat:@"到店价: ¥%.2f",[infoModel.priceYUAN floatValue]];
        
        if (!infoModel.freightYUAN && !infoModel.stock) {
            self.stock.text = [NSString stringWithFormat:@"库存: %@",infoModel.stock_s];
        }else{
            self.stock.text = [NSString stringWithFormat:@"库存: %@",infoModel.stock];
        }
    }
    self.nameLabel.text = infoModel.goodsName;
    NSString *picurl = infoModel.picUrl[0];
    [self.smallImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:picurl] forState:UIControlStateNormal];
}

- (void)setBestSKUModel:(Fcgo_BestSKUModel *)bestSKUModel
{
    _bestSKUModel = bestSKUModel;
    
    NSString *total = [NSString stringWithFormat:@"%.2f",round([bestSKUModel.totalYUAN floatValue]*100)/100];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",total];
    self.singlePrice.text = [NSString stringWithFormat:@"到店价: ¥%.2f",[bestSKUModel.unitpriceYUAN floatValue]];
    
    self.fregihtLabel.text =[NSString stringWithFormat:@"(包含运费: %@)",bestSKUModel.postageYUAN];

    if ([self.goodsType isEqualToString:@"normal"]) {
        self.stock.text = [NSString stringWithFormat:@"库存: %d",bestSKUModel.remain.intValue / bestSKUModel.time.intValue];
    }else{
        self.stock.text = [NSString stringWithFormat:@"库存: %d",bestSKUModel.remain.intValue];
    }
    if (bestSKUModel.time.intValue == 0) {
        self.goodsStatus.hidden = 0;
    }
    [self.collectionview reloadData];
}

- (void)setAttrArray:(NSMutableArray *)attrArray
{
    _attrArray = attrArray;
    [self.collectionview reloadData];
}

- (void)showImage
{
    if (self.infoModel) {
        //利用XLImageViewer显示本地图片
        [[XLImageViewer shareInstanse]  showNetImages:self.infoModel.picUrl index:0 fromImageContainer:self.smallImgBtn];
    }
}

- (void)confirm
{
    if (self.selectAttrItemBlock) {
        self.selectAttrItemBlock(@"",@"",YES,self.count);
    }
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)lowerPrice{
    if (self.lowerPriceBlock) {
        self.lowerPriceBlock();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.attrArray) {
        if (self.attrArray.count<=0) {
            return 0;
        }
        return self.attrArray.count+1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.attrArray && section<self.attrArray.count)
    {
        Fcgo_GoodsAttrModel *model = self.attrArray[section];
        return model.dataArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SiftMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"siftMainCollectionCell" forIndexPath:indexPath];
    if (self.attrArray) {
        Fcgo_GoodsAttrModel *model = self.attrArray[indexPath.section];
        Fcgo_AttrModel *attrModel = model.dataArray[indexPath.item];
        cell.object = attrModel;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_GoodsAttrModel *model = self.attrArray[indexPath.section];
    Fcgo_AttrModel *attrModel = model.dataArray[indexPath.item];
    
    Fcgo_SiftMainCollectionCell *cell = (Fcgo_SiftMainCollectionCell *)[collectionView  cellForItemAtIndexPath:indexPath];
    if (cell.type == ItemSelectedNotType) {
        return;
    }
    if (cell.type == ItemSelectedOnType) {
        self.selectAttrItemBlock(model.f_properties_name,attrModel.f_value_name,NO,self.count);
    }
    else if (cell.type == ItemSelectedNormalType) {
        self.selectAttrItemBlock(model.f_properties_name,attrModel.f_value_name,YES,self.count);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.attrArray) {
        Fcgo_GoodsAttrModel *model = self.attrArray[indexPath.section];
        Fcgo_AttrModel *attrModel = model.dataArray[indexPath.item];
        CGFloat width = [attrModel.f_value_name boundingRectWithSize:CGSizeMake(1000, 25) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.width;
        if (width+kAutoWidth6(10)+10<kAutoWidth6(65)) {
            width = kAutoWidth6(65);
        }
        else{
            width = width+kAutoWidth6(10)+10;
        }
        return CGSizeMake(width, 25);
    }
    return CGSizeMake(0, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf)
    if (kind == UICollectionElementKindSectionHeader) {
        if (self.attrArray) {
            if (indexPath.section<self.attrArray.count) {
                Fcgo_SiftMainCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView" forIndexPath:indexPath];
                
                [headerView addSubview:headerView.titleLabel];
                [headerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_offset(0);
                    make.bottom.mas_offset(0);
                    make.left.mas_offset(15);;
                    make.width.mas_offset(100);
                }];
                if (self.attrArray) {
                    Fcgo_GoodsAttrModel *model = self.attrArray[indexPath.section];
                    
                    headerView.titleLabel.text = model.f_properties_name;
                }
                return headerView;
            }
            else{
                Fcgo_GoodsSKUCountHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"goodsSKUCountHeaderView" forIndexPath:indexPath];
                [headerView addSubview:headerView.titleLabel];
                [headerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_offset(0);
                    make.bottom.mas_offset(0);
                    make.left.mas_offset(15);;
                    make.width.mas_offset(100);
                }];
                headerView.titleLabel.text = @"数量";
                [headerView addSubview:headerView.numberButton];
                headerView.numberButton.minValue = 1;
                headerView.numberButton.inputFieldFont = 13;
                if (self.infoModel.texes.intValue == 2||self.infoModel.texes.intValue == 3) {
                    headerView.numberButton.textField.enabled = NO;
                    headerView.numberButton.increaseBtn.enabled = NO;
                    headerView.numberButton.decreaseBtn.enabled = NO;
                    headerView.numberButton.decreaseBtn.backgroundColor = UISepratorLineColor;
                    headerView.numberButton.increaseBtn.backgroundColor = UISepratorLineColor;
                    self.count = 1;
                }
                headerView.numberButton.currentNumber = self.count;
                if (self.bestSKUModel) {
                    if ([self.goodsType isEqualToString:@"normal"]) {
                        headerView.numberButton.maxValue = self.bestSKUModel.remain.intValue/self.bestSKUModel.time.intValue;
                    }else{
                        headerView.numberButton.maxValue = self.bestSKUModel.remain.intValue;
                    }
                }
                __weak __typeof(&*headerView)wHeaderView = headerView;
                headerView.numberButton.resultBlock = ^(NSString *num){
                    
                    if (self.attrArray.count <= 0) {
                        wHeaderView.numberButton.currentNumber = self.count;
                        return ;
                    }
                    
                    if (self.attrArray.count > self.saveAttrArray.count) {
                        wHeaderView.numberButton.currentNumber = self.count;
                        [WSProgressHUD showImage:nil status:@"请选择全部属性"];
                        return;
                    }
                    weakSelf.count = num.integerValue;
                    if (weakSelf.selectCountBlock) {
                        weakSelf.selectCountBlock(num.integerValue);
                    }
                };
                return headerView;
            }
        }
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.attrArray && section<self.attrArray.count) {
        return UIEdgeInsetsMake(0, 12, 12, 12);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark Lazy method

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"选好了" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIFontRedColor];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}

- (UIButton *)lowerBtn
{
    if (!_lowerBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"一键最低价" forState:UIControlStateNormal];
        [btn setTitleColor:UIRGBColor(246, 51, 120, 1) forState:UIControlStateNormal];
        [btn setBackgroundColor:UIRGBColor(235, 235, 235, 1)];
        [btn setImage:[[UIImage imageNamed:@"icon_lower  price"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _lowerBtn = btn;
    }
    return _lowerBtn;
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewLeftAlignedLayout *flowLayout= [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
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

@end
