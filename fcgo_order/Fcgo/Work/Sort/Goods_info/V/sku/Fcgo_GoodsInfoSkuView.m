//
//  Fcgo_GoodsInfoSkuView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoSkuView.h"

#import "Fcgo_SiftMainCollectionCell.h"
#import "Fcgo_SiftMainCollectionHeaderView.h"
#import "Fcgo_GoodsInfoSkuCountHeaderView.h"
#import "Fcgo_SiftMainCollectionFooterView.h"
#import "Fcgo_GoodsAttrsModel.h"


@interface Fcgo_GoodsInfoSkuView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView   *popView;
@property (nonatomic,strong) UIButton *smallImgBtn;
@property (nonatomic,strong) UIButton *addCartBtn,*buyBtn,*lowerBtn;
@property (nonatomic,strong) UILabel  *notBuyLabel;
@property (nonatomic,strong) UILabel  *nameLabel,*priceLabel,*fregihtLabel,*singlePrice,*stock;
@property (nonatomic,assign) NSInteger selectedCount;
@property (nonatomic,strong) UICollectionView *collectionview;

@end

@implementation Fcgo_GoodsInfoSkuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedCount = 1;
        self.hidden = 1;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setNotBuyLabelRefreshTime) name:@"countdown" object:nil];
        [self setupUI];
    }
    return self;
}

- (void)setInfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
{
    _infoModel = infoModel;
    NSString *str = @"";
    switch (self.infoModel.texes.integerValue) {
        case 1:
            str = @"[一般贸易] ";
            break;
        case 2:
            str = @"[跨境保税] ";
            break;
        case 3:
            str = @"[海外直邮] ";
            break;
            
        default:
            break;
    }
    self.nameLabel.text = [str stringByAppendingString:!self.infoModel.goodsName?@"":self.infoModel.goodsName];
    if (self.skuModel && self.skuModel.totalYUAN) {
        return;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.minpriceYUAN floatValue]];
    self.singlePrice.text = [NSString stringWithFormat:@"到店价:¥ %.2f",[infoModel.priceYUAN floatValue]];
    if (!infoModel.freightYUAN && !infoModel.stock) {
        self.stock.text = [NSString stringWithFormat:@"库存:%@",infoModel.stock_s];
    }else{
        self.stock.text = [NSString stringWithFormat:@"库存:%@",infoModel.stock];
    }
    NSString *picurl = infoModel.picUrl[0];
    [self.smallImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:picurl] forState:UIControlStateNormal];
    
}

- (void)setSkuModel:(Fcgo_GoodsSkuModel *)skuModel
{
    _skuModel = skuModel;
    if (!self.infoModel) {
        self.notBuyLabel.text = @"无 货";
        self.notBuyLabel.backgroundColor = UIFontMainGrayColor;
        self.notBuyLabel.hidden = 0;
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 1;
        return;
    }
    if (![self.infoModel.goodsType isEqualToString:@"normal"]) {
        if ([self.infoModel.goodsType isEqualToString:@"integral"] && (self.infoModel.activityModel.status.integerValue == 0)) {
            //[self setNotBuyLabelRefreshTime];
            self.notBuyLabel.backgroundColor = UIFontRed_newColor;
            self.notBuyLabel.hidden = 0;
        }
    }
    if (!skuModel.canBuy)
    {
        self.notBuyLabel.text = @"无 货";
        self.notBuyLabel.backgroundColor = UIFontMainGrayColor;
        self.notBuyLabel.hidden = 0;
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 1;
    }
    [self.collectionview reloadData];
    if(!skuModel.totalYUAN) return;
    
    NSString *total = [NSString stringWithFormat:@"%.2f",round([skuModel.totalYUAN floatValue]*100)/100];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",total];
    self.singlePrice.text = [NSString stringWithFormat:@"到店价: ¥%.2f",[skuModel.unitpriceYUAN floatValue]];
    
    self.fregihtLabel.text =[NSString stringWithFormat:@"(包含运费: %@)",skuModel.postageYUAN];
    
    
    NSString *goodsType = skuModel.goodsType;
    if(![goodsType isEqualToString:@"normal"]){
        if ([goodsType isEqualToString:@"integral"]) {
            if (self.infoModel && (self.infoModel.activityModel.status.integerValue == 2)) {
                goodsType = @"normal";
            }
            else{
                goodsType = @"activity";
            }
        }
        else{
            goodsType = @"activity";
        }
    }else{
        goodsType = @"normal";
    }
    NSInteger stock = 0;
    if ([goodsType isEqualToString:@"normal"]) {
        stock = skuModel.remain.integerValue / skuModel.time.integerValue;
    }else{
        stock = skuModel.remain.intValue;
    }
    self.stock.text = [NSString stringWithFormat:@"库存:%ld",stock];
    //    if (stock<=0) {
    //        self.buyBtn.hidden = 1;
    //        self.addCartBtn.hidden = 1;
    //        self.activityBtn.hidden = 0;
    //        self.activityBtn.enabled = true;
    //        [self.activityBtn setTitle:@"无 货\n请选择其他收货地区" forState:UIControlStateNormal];
    //        [self.activityBtn setBackgroundColor:UIFontMainGrayColor];
    //    }
    
}


- (void)setNotBuyLabelRefreshTime
{
    if (!self.infoModel) {
        return;
    }
    if (![self.infoModel.goodsType isEqualToString:@"integral"]) {
       return;
    }
    if (self.infoModel.activityModel.status.integerValue != 0) {
        return;
    }
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.infoModel.activityModel.time_interval];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.infoModel.activityModel.start.doubleValue/1000];
    NSString *status = @"距离开始抢购";
    NSTimeInterval  timeInterval = [startDate timeIntervalSinceDate:serverDate];
    __block long long timeout = timeInterval;
   WEAKSELF(weakSelf)
    if(timeout<=0){ //倒计时结束，关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            //倒计时完成。用block回调刷新表格
            if (weakSelf.reloadBlock) {
                weakSelf.reloadBlock();
            }
        });
    }else{
        int days = (int)(timeout/(3600*24));
        int hours = (int)((timeout-days*24*3600)/3600);
        int minutes = (int)(timeout-days*24*3600-hours*3600)/60;
        int seconds = (int)timeout-days*24*3600-hours*3600-minutes*60;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *hour = nil;
            NSString *mintue = nil;
            NSString *second = nil;
            int hour_s = hours+ (days*24);
            if (hour_s<10) {
                hour = [NSString stringWithFormat:@"0%d",hour_s];
            }else{
                hour = [NSString stringWithFormat:@"%d",hour_s];
            }
            if (minutes<10) {
                mintue = [NSString stringWithFormat:@"0%d",minutes];
            }else{
                mintue = [NSString stringWithFormat:@"%d",minutes];
            }
            if (seconds<10) {
                second = [NSString stringWithFormat:@"0%d",seconds];
            }else{
                second = [NSString stringWithFormat:@"%d",seconds];
            }
            weakSelf.notBuyLabel.text = [NSString stringWithFormat:@"%@\n%@:%@:%@",status,hour,mintue,second];
        });
    }
}

- (void)showImage
{
    if (self.infoModel) {
        //利用XLImageViewer显示本地图片
        [[XLImageViewer shareInstanse]  showNetImages:self.infoModel.picUrl index:0 fromImageContainer:self.smallImgBtn];
    }
}

- (void)buyMeth
{
    if (self.skuModel.totalYUAN) {
        if (self.buyBlock) {
            self.buyBlock();
        }
    }
    else
    {
        [WSProgressHUD showImage:nil status:@"商品规格未选择完整"];
    }
}

- (void)addCartMeth
{
    if (self.skuModel.totalYUAN) {
        
        if (self.addCartBlock) {
            self.addCartBlock();
        }
    }
    else
    {
        [WSProgressHUD showImage:nil status:@"商品规格未选择完整"];
    }
}

- (void)lowerMeth
{
    if (!self.skuModel) {
        return;
    }
    
    NSString *goodsType = self.skuModel.goodsType;
    if(![goodsType isEqualToString:@"normal"]){
        if ([goodsType isEqualToString:@"integral"]) {
            if (self.infoModel && (self.infoModel.activityModel.status.integerValue == 2)) {
                goodsType = @"normal";
            }
            else{
                goodsType = @"activity";
            }
        }
        else{
            goodsType = @"activity";
        }
    }else{
        goodsType = @"normal";
    }
    if (![goodsType isEqualToString:@"normal"]) {
        [WSProgressHUD showImage:nil status:@"活动商品已是最低价了哦"];
        return;
    }
    if (self.lowerBlock) {
        self.lowerBlock();
    }
}

- (void)showWithType:(SkuViewType)type
{
    WEAKSELF(weakSelf)
    self.notBuyLabel.hidden = 1;
    if (type == SkuViewAddCartType) {
        [self.addCartBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.bottom.mas_offset(0);
            make.right.mas_offset(0);
            make.width.mas_offset(kScreenWidth/3*2);
        }];
        [self.addCartBtn setBackgroundColor:UIFontRedColor];
        [self.addCartBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 0;
    }
    else if (type == SkuViewBuyType) {
        [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.bottom.right.mas_offset(0);
            //make.width.mas_equalTo(kScreenWidth/3*2);
            make.left.mas_equalTo(weakSelf.lowerBtn.mas_right).mas_offset(0);
        }];
        [self.buyBtn setBackgroundColor:UIFontRedColor];
        self.buyBtn.hidden = 0;
        self.addCartBtn.hidden = 1;
    }
    else if (type == SkuViewAddCartAndBuyType) {
        [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.right.bottom.mas_offset(0);
            make.width.mas_offset(kScreenWidth/3);
        }];
        [self.addCartBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50);
            make.bottom.mas_offset(0);
            make.left.mas_equalTo(weakSelf.lowerBtn.mas_right).mas_offset(0);
            make.width.mas_offset(kScreenWidth/3);
        }];
        [self.buyBtn setBackgroundColor:UIFontRedColor];
        [self.addCartBtn setBackgroundColor:UIStringColor(@"#fad8dc")];
        [self.addCartBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        self.buyBtn.hidden = 0;
        self.addCartBtn.hidden = 0;
    }
    //每次弹出，都会重走setSkuModel方法，刷新布局
    self.skuModel = self.skuModel;
    [self show];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    self.hidden = 0;
    WEAKSELF(weakSelf)
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.popView.frame =  CGRectMake(0, KScreenHeight -kAutoWidth6(450), kScreenWidth, kAutoWidth6(450));
    }completion:^(BOOL finished) {}];
}

- (void)dismiss
{
    WEAKSELF(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.popView.frame =  CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(450));
    }completion:^(BOOL finished) {
        weakSelf.hidden = 1;
    }];
}

#pragma mark collectionview meth
#pragma mark delegate dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.infoModel && self.skuModel) {
        //一般贸易，可以加减数量
        if (self.infoModel.texes.integerValue == 1) {
            return self.skuModel.attrsArray.count+1;
        }
        return self.skuModel.attrsArray.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.infoModel && self.skuModel) {
        if (self.skuModel.attrsArray && section < self.skuModel.attrsArray.count)
        {
            Fcgo_GoodsAttrsModel *model = self.self.skuModel.attrsArray[section];
            return model.dataArray.count;
        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SiftMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"siftMainCollectionCell" forIndexPath:indexPath];
    if (self.skuModel) {
        Fcgo_GoodsAttrsModel *model = self.skuModel.attrsArray[indexPath.section];
        Fcgo_GoodsPropertyModel *propertyModel = model.dataArray[indexPath.item];
        cell.object = propertyModel;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.skuModel) {
        return;
    }
    Fcgo_GoodsAttrsModel *model = self.skuModel.attrsArray[indexPath.section];
    Fcgo_GoodsPropertyModel *propertyModel = model.dataArray[indexPath.item];
    Fcgo_SiftMainCollectionCell *cell = (Fcgo_SiftMainCollectionCell *)[collectionView  cellForItemAtIndexPath:indexPath];
    //属性不可选，默认灰色
    if (cell.type == ItemSelectedNotType) {
        return;
    }
    else if (cell.type == ItemSelectedOnType) {
        //属性只有一个，不可取消
        if (model.dataArray.count == 1) {
            return;
        }
        if (self.selectedPropertyBlock) {
            self.selectedPropertyBlock(model.f_properties_name, propertyModel.f_value_name,false, self.selectedCount);
        }
    }
    else if (cell.type == ItemSelectedNormalType) {
        if (self.selectedPropertyBlock) {
            self.selectedPropertyBlock(model.f_properties_name, propertyModel.f_value_name, true, self.selectedCount);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.skuModel) {
        Fcgo_GoodsAttrsModel *model = self.skuModel.attrsArray[indexPath.section];
        Fcgo_GoodsPropertyModel *propertyModel = model.dataArray[indexPath.item];
        CGFloat width = [propertyModel.f_value_name boundingRectWithSize:CGSizeMake(1000, 25) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.width;
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
        if (self.skuModel) {
            if (indexPath.section < self.skuModel.attrsArray.count) {
                Fcgo_SiftMainCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView" forIndexPath:indexPath];
                
                [headerView addSubview:headerView.titleLabel];
                [headerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_offset(0);
                    make.bottom.mas_offset(0);
                    make.left.mas_offset(15);;
                    make.width.mas_offset(100);
                }];
                Fcgo_GoodsAttrsModel *model = self.skuModel.attrsArray[indexPath.section];
                headerView.titleLabel.text = model.f_properties_name;
                return headerView;
            }
            else{
                Fcgo_GoodsInfoSkuCountHeaderView *headerView = [Fcgo_GoodsInfoSkuCountHeaderView headViewWithCollectionView:collectionView headIdentifier:@"goodsInfoSKUCountHeaderView" forIndexPath:indexPath];
                headerView.numberButton.currentNumber = self.selectedCount;
                if (self.skuModel && self.infoModel && self.skuModel.totalYUAN) {
                    NSString *goodsType = self.skuModel.goodsType;
                    if(![goodsType isEqualToString:@"normal"]){
                        if ([goodsType isEqualToString:@"integral"]) {
                            if (self.infoModel && (self.infoModel.activityModel.status.integerValue == 2)) {
                                goodsType = @"normal";
                            }
                            else{
                                goodsType = @"activity";
                            }
                        }
                        else{
                            goodsType = @"activity";
                        }
                    }else{
                        goodsType = @"normal";
                    }
                    if ([goodsType isEqualToString:@"normal"]) {
                        headerView.numberButton.maxValue = self.skuModel.remain.intValue/self.skuModel.time.intValue;
                    }else{
                        headerView.numberButton.maxValue = self.skuModel.remain.intValue;
                    }
                }
                headerView.numberButton.resultBlock = ^(NSString *num){
                    weakSelf.selectedCount = num.integerValue;
                    if (weakSelf.selectedCountBlock) {
                        weakSelf.selectedCountBlock(weakSelf.selectedCount);
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
    if (self.skuModel.attrsArray && section < self.skuModel.attrsArray.count) {
        return UIEdgeInsetsMake(0, 12, 12, 12);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark Lazy method

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"轻松购" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIFontRed_newColor];
        _buyBtn = btn;
    }
    return _buyBtn;
}

- (UIButton *)addCartBtn
{
    if (!_addCartBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [btn setTitleColor:UIRGBColor(34, 34, 34, 1) forState:UIControlStateNormal];
        [btn setBackgroundColor:UIStringColor(@"#fad8dc")];
        _addCartBtn = btn;
    }
    return _addCartBtn;
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

- (UILabel *)notBuyLabel
{
    if (!_notBuyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontWhiteColor;
        label.text = @"无 货";
        label.numberOfLines = 2;
        label.backgroundColor = UIFontMainGrayColor;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.hidden = 1;
        _notBuyLabel = label;
    }
    return _notBuyLabel;
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

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(450))];
    popView.backgroundColor = UIFontWhiteColor;
    [self addSubview:self.popView = popView];
    
    self.smallImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.smallImgBtn.frame = CGRectMake(12, -15, kAutoWidth6(100), kAutoWidth6(100));
    self.smallImgBtn.layer.cornerRadius = 4;
    self.smallImgBtn.layer.borderColor = UISepratorLineColor.CGColor;
    self.smallImgBtn.layer.borderWidth = 1;
    self.smallImgBtn.layer.masksToBounds = YES;
    self.smallImgBtn.userInteractionEnabled = YES;
    self.smallImgBtn.backgroundColor = UIFontWhiteColor;
    [self.smallImgBtn addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:self.smallImgBtn];
    [self.smallImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(-15));
        make.left.mas_offset(15);;
        make.height.width.mas_offset(kAutoWidth6(100));
    }];
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = UIFontMainGrayColor;
    self.nameLabel.numberOfLines = 2;
    [popView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
        make.right.mas_equalTo(-40);
    }];
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.font = UIBoldFontSize(15);
    self.priceLabel.textColor = UIFontRedColor;
    [popView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
    }];
    self.fregihtLabel = [[UILabel alloc]init];
    self.fregihtLabel.font = UIFontSize(12);
    self.fregihtLabel.textColor =  UIFontMainGrayColor;
    self.fregihtLabel.textAlignment = NSTextAlignmentLeft;
    self.fregihtLabel.text = @"(包含运费: --)";
    [popView addSubview:self.fregihtLabel];
    [self.fregihtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.priceLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.priceLabel.mas_right).mas_offset(5);
        make.right.mas_equalTo(-12);
    }];
    
    self.singlePrice = [[UILabel alloc]init];
    self.singlePrice.font = UIFontSize(12);
    self.singlePrice.textColor =  UIFontMainGrayColor;
    self.singlePrice.textAlignment = NSTextAlignmentLeft;
    self.singlePrice.text = @"到店价: --";
    [popView addSubview:self.singlePrice];
    
    [self.singlePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(weakSelf.smallImgBtn.mas_right).mas_offset(10);
    }];
    
    self.stock = [[UILabel alloc]init];
    self.stock.font = UIFontSize(12);
    self.stock.textColor =  UIFontMainGrayColor;
    self.stock.textAlignment = NSTextAlignmentRight;
    self.stock.text = @"库存: --";
    [popView addSubview:self.stock];
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
    [popView addSubview:closeButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, kScreenWidth, 0.5)];
    line.backgroundColor = UISepratorLineColor;
    [popView addSubview:line];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SiftMainCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"siftMainCollectionCell"];
    [self.collectionview registerClass:[Fcgo_SiftMainCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"siftMainCollectionHeaderView"];
    [self.collectionview registerClass:[Fcgo_SiftMainCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"siftMainCollectionFooterView"];
    
    [self.collectionview registerClass:[Fcgo_GoodsInfoSkuCountHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"goodsInfoSKUCountHeaderView"];
    [popView addSubview:self.collectionview];
    
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-50);
    }];
    
    [popView addSubview:self.buyBtn];
    [popView addSubview:self.addCartBtn];
    [popView addSubview:self.lowerBtn];
    [popView addSubview:self.notBuyLabel];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.right.bottom.mas_offset(0);
        make.width.mas_offset(kScreenWidth/3);
    }];
    [self.lowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.width.mas_offset(kScreenWidth/3);
    }];
    [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.lowerBtn.mas_right).mas_offset(0);
        make.width.mas_offset(kScreenWidth/3);
    }];
    [self.notBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.bottom.right.mas_offset(0);
        make.width.mas_offset(kScreenWidth/3*2);
    }];
    
    [self.buyBtn addTarget:self action:@selector(buyMeth) forControlEvents:UIControlEventTouchUpInside];
    [self.addCartBtn addTarget:self action:@selector(addCartMeth) forControlEvents:UIControlEventTouchUpInside];
    [self.lowerBtn addTarget:self action:@selector(lowerMeth) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self
                    action:@selector(dismiss)
          forControlEvents:UIControlEventTouchUpInside];
}
@end
