//
//  Fcgo_GoodsInfoBottomView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoBottomView.h"

@interface Fcgo_GoodsInfoBottomView ()

@property (nonatomic,strong)  UIButton  *buyBtn,*addCartBtn;
@property (nonatomic,strong)  UIButton  *activityBtn;//这是活动按钮，覆盖购买和加入购物车按钮，可用于活动未开始,请耐心等待，活动抢购，无货等三种状态

@property (nonatomic,strong) UILabel  *notBuyLabel;

@property (nonatomic,strong)  Fcgo_GoodsInfoBottomButton *cartBtn;
@property (nonatomic,strong)  Fcgo_GoodsInfoBottomButton *collectBtn;
@property (nonatomic,strong)  UIView    *lineView;

@end

@implementation Fcgo_GoodsInfoBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setInfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
{
    _infoModel = infoModel;
}

- (void)setSkuModel:(Fcgo_GoodsSkuModel *)skuModel
{
    _skuModel = skuModel;
    if (!self.infoModel) {
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 1;
        self.activityBtn.hidden = 0;
        self.activityBtn.enabled = true;
        [self.activityBtn setTitle:@"无 货\n请选择其他收货地区" forState:UIControlStateNormal];
        [self.activityBtn setBackgroundColor:UIFontMainGrayColor];
        
        return;
    }
    if ([self.infoModel.goodsType isEqualToString:@"normal"]) {
        self.buyBtn.hidden = 0;
        self.addCartBtn.hidden = 0;
        self.activityBtn.hidden = 1;
    }
    else
    {
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 1;
        self.activityBtn.hidden = 0;
        self.activityBtn.enabled = true;
        if ([self.infoModel.goodsType isEqualToString:@"integral"]) {
            //整点抢的商品过时
            if (self.infoModel.activityModel.status.integerValue == 2) {
                self.buyBtn.hidden = 0;
                self.addCartBtn.hidden = 0;
                self.activityBtn.hidden = 1;
            }
            else if (self.infoModel.activityModel.status.integerValue == 1) {
                [self.activityBtn setTitle:@"轻松购" forState:UIControlStateNormal];
                [self.activityBtn setBackgroundColor:UIFontRedColor];
                self.activityBtn.enabled = true;
            }
            else if (self.infoModel.activityModel.status.integerValue == 0) {
                [self.activityBtn setTitle:@"活动未开始,请耐心等待" forState:UIControlStateNormal];
                [self.activityBtn setBackgroundColor:UIFontRed_newColor];
                self.activityBtn.enabled = true;
            }
        }
        else
        {
            [self.activityBtn setTitle:@"轻松购" forState:UIControlStateNormal];
            [self.activityBtn setBackgroundColor:UIFontRedColor];
            
        }
    }
    if (!skuModel.canBuy)
    {
        self.buyBtn.hidden = 1;
        self.addCartBtn.hidden = 1;
        self.activityBtn.hidden = 0;
        self.activityBtn.enabled = true;
        [self.activityBtn setTitle:@"无 货\n请选择其他收货地区" forState:UIControlStateNormal];
        [self.activityBtn setBackgroundColor:UIFontMainGrayColor];
    }
    if(!skuModel.totalYUAN) return;
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
//    if (stock<=0) {
//        self.buyBtn.hidden = 1;
//        self.addCartBtn.hidden = 1;
//        self.activityBtn.hidden = 0;
//        self.activityBtn.enabled = true;
//        [self.activityBtn setTitle:@"无 货\n请选择其他收货地区" forState:UIControlStateNormal];
//        [self.activityBtn setBackgroundColor:UIFontMainGrayColor];
//    }
}

- (void)setCartCount:(NSInteger)cartCount
{
    _cartCount = cartCount;
    NSString *countString = [NSString stringWithFormat:@"%ld",(long)cartCount];
    self.cartBtn.iconCountLabel.text = countString;
    if (cartCount<=0) {
        self.cartBtn.iconCountLabel.hidden = 1;
    }else{
        self.cartBtn.iconCountLabel.hidden = 0;
    }
    CGFloat width = 3;
    if (cartCount>9) {
        width = [countString boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(8)} context:nil].size.width;
    }
    self.cartBtn.iconCountLabel.frame = CGRectMake(self.cartBtn.mj_w-width-7, self.cartBtn.iconImageView.mj_y, width+7, 10);
}

- (void)setCollect:(BOOL)collect
{
    _collect = collect;
    self.collectBtn.select = collect;
    if (collect) {
        [self.collectBtn.heartButton notAnimationSelect];
        self.collectBtn.iconTitleLabel.textColor = UIFontRedColor;
    }
    else{
        [self.collectBtn.heartButton deselect];
        self.collectBtn.iconTitleLabel.textColor = UIFontMainGrayColor;
    }
}

- (void)collectAnimation
{
    if (!self.collectBtn.select) {
        self.collectBtn.iconTitleLabel.textColor = UIFontRedColor;
        [self.collectBtn.heartButton select];
    }
    else
    {
        self.collectBtn.iconTitleLabel.textColor = UIFontMainGrayColor;
        [self.collectBtn.heartButton deselect];
    }
    self.collectBtn.select = !self.collectBtn.select;
}

- (void)addCartAnimation
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.20f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-3.5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:3.5];
    shakeAnimation.autoreverses = YES;
    [self.cartBtn.iconImageView.layer addAnimation:shakeAnimation forKey:nil];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.4f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.6, 1.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.cartBtn.iconCountLabel.layer addAnimation:animation forKey:nil];
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buyBtn setTitle:@"轻松购" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _buyBtn.backgroundColor = UIFontRedColor;
    }
    return _buyBtn;
}

- (UIButton *)addCartBtn
{
    if (!_addCartBtn) {
        _addCartBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addCartBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        _addCartBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _addCartBtn.backgroundColor = UIStringColor(@"#fad8dc");
    }
    return _addCartBtn;
}

- (UIButton *)activityBtn
{
    if (!_activityBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.numberOfLines = 2;
        //[button setTitle:@"活动未开始\n请耐心等待" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:246/255.0 green:151/255.0 blue:6/255.0 alpha:1];//UIFontPhotoColor;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.hidden = 1;
        _activityBtn = button;
    }
    return _activityBtn;
}

- (Fcgo_GoodsInfoBottomButton *)cartBtn
{
    if (!_cartBtn) {
        _cartBtn = [Fcgo_GoodsInfoBottomButton buttonWithType:UIButtonTypeSystem];
        _cartBtn.iconTitleLabel.text = @"购物车";
        _cartBtn.heartButton.hidden = YES;
        _cartBtn.iconImageView.image = [UIImage imageNamed:@"goodsinfo_car"];
    }
    return _cartBtn;
}

- (Fcgo_GoodsInfoBottomButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [Fcgo_GoodsInfoBottomButton buttonWithType:UIButtonTypeSystem];
        _collectBtn.iconTitleLabel.text = @"收藏";
        _collectBtn.iconCountLabel.hidden = 1;
        _collectBtn.iconImageView.hidden = 1;
    }
    return _collectBtn;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = UINavSepratorLineColor;
    }
    return _lineView;
}

- (void)setupFrameAndAddTarget
{
    WEAKSELF(weakSelf);
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(120));
    }];
    
    [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.buyBtn.mas_left);
        make.width.mas_offset(kAutoWidth6(120));
    }];
    
    [self.activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(120*2));
    }];
    
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(65));
    }];
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.collectBtn.mas_right);
        make.width.mas_offset(kAutoWidth6(65));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    [self.buyBtn addTarget:self action:@selector(touchBuy) forControlEvents:UIControlEventTouchUpInside];
    [self.addCartBtn addTarget:self action:@selector(touchAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.activityBtn addTarget:self action:@selector(activity) forControlEvents:UIControlEventTouchUpInside];
    [self.cartBtn addTarget:self action:@selector(touchCart) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn addTarget:self action:@selector(touchCollect) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupUI
{
    self.backgroundColor = UIFontWhiteColor;
    [self addSubview:self.buyBtn];
    [self addSubview:self.addCartBtn];
    [self addSubview:self.cartBtn];
    [self addSubview:self.collectBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.activityBtn];
    self.buyBtn.hidden = 1;
    self.addCartBtn.hidden = 1;
    self.activityBtn.hidden = 1;
    [self setupFrameAndAddTarget];
}

- (void)activity
{
    if ([self.activityBtn.titleLabel.text isEqualToString:@"活动未开始,请耐心等待"]) {
        if (self.selectedTypeBlock) {
            self.selectedTypeBlock(GoodsInfoBottomViewSelectedBuyType, false);
        }
        //return;
    }
    else if ([self.activityBtn.titleLabel.text isEqualToString:@"轻松购"]){
        if (self.selectedTypeBlock) {
            self.selectedTypeBlock(GoodsInfoBottomViewSelectedBuyType, false);
        }
    }
    else if ([self.activityBtn.titleLabel.text containsString:@"无 货"]){
        if (self.selectedTypeBlock) {
            self.selectedTypeBlock(GoodsInfoBottomViewSelectedAddressType, false);
        }
    }
}

- (void)touchBuy
{
    if (self.selectedTypeBlock) {
        self.selectedTypeBlock(GoodsInfoBottomViewSelectedBuyType, false);
    }
}

- (void)touchAdd
{
    if (self.selectedTypeBlock) {
        self.selectedTypeBlock(GoodsInfoBottomViewSelectedAddCartType, false);
    }
}

- (void)touchCart
{
    if (self.selectedTypeBlock) {
        self.selectedTypeBlock(GoodsInfoBottomViewSelectedPushCartType, false);
    }
}

- (void)touchCollect
{
    if (self.selectedTypeBlock) {
        self.selectedTypeBlock(GoodsInfoBottomViewSelectedCollectType, !self.collectBtn.select);
    }
}

@end
