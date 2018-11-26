//
//  Fcgo_GoodsDetailBottomView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailBottomView.h"

@interface Fcgo_GoodsDetailBottomView ()

@property (nonatomic,strong)  UIButton  *buyBtn,*addCartBtn;
@property (nonatomic,strong)  UIButton  *showSKUAdressBtn,*showSoldOutBtn,*showWillIntegralBtn;
@property (nonatomic,strong)  Fcgo_GoodsDetailBottomButton *cartBtn;
@property (nonatomic,strong)  UIView    *lineView;

@end


@implementation Fcgo_GoodsDetailBottomView


- (void)setIsSoldOut:(BOOL)isSoldOut
{
    _isSoldOut = isSoldOut;
    self.showSoldOutBtn.hidden = !isSoldOut;
}

- (void)setIsDefaultAddress:(BOOL)isDefaultAddress
{
    _isDefaultAddress = isDefaultAddress;
    if (isDefaultAddress) {
         [self.showSKUAdressBtn setTitle:@"门店所在地区暂不供货\n点击选择其它地区" forState:UIControlStateNormal];
    }else{
        [self.showSKUAdressBtn setTitle:@"所选地区暂不供货\n点击选择其它地区" forState:UIControlStateNormal];
    }
}

- (void)setIsSKU:(BOOL)isSKU
{
    _isSKU = isSKU;
    if (isSKU) {
        self.showSKUAdressBtn.hidden = 1;
    }
    else
    {
        self.showSKUAdressBtn.hidden = 0;
    }
}

- (void)setIsIntegral:(BOOL)isIntegral
{
    _isIntegral = isIntegral;
    
    if (isIntegral) {
        self.showWillIntegralBtn.hidden = 1;
    }else{
        self.showWillIntegralBtn.hidden = 0;
    }
}



- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    [self.buyBtn setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    [self addSubview:self.buyBtn];
    [self addSubview:self.addCartBtn];
    [self addSubview:self.cartBtn];
    [self addSubview:self.collectBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.showSKUAdressBtn];
    [self addSubview:self.showSoldOutBtn];
    [self addSubview:self.showWillIntegralBtn];
    
    WEAKSELF(weakSelf);
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(123));
    }];
    
    [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.buyBtn.mas_left);
        make.width.mas_offset(kAutoWidth6(122));
    }];
    
    [self.showSKUAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(123*2));
    }];
    
    [self.showSoldOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(123*2));
    }];
    
    [self.showWillIntegralBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(123*2));
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
    [self.showSKUAdressBtn addTarget:self action:@selector(showSKUAdress) forControlEvents:UIControlEventTouchUpInside];
    [self.showSoldOutBtn addTarget:self action:@selector(showSoldOut) forControlEvents:UIControlEventTouchUpInside];
    [self.cartBtn addTarget:self action:@selector(touchCart) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn addTarget:self action:@selector(touchCollect) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showSoldOut
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchShowSoldOutType,NO);
    }
}

- (void)showSKUAdress
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchShowAddressType,NO);
    }
}

- (void)touchBuy
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchBuyType,NO);
    }
}

- (void)touchAdd
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchAddCartType,NO);
    }
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
    //self.cartBtn.backgroundColor = [UIColor blueColor];
    //self.cartBtn.iconCountLabel.frame = CGRectMake(self.cartBtn.mj_w-width-7, self.cartBtn.iconImageView.mj_y, width+7, 10);
    self.cartBtn.iconCountLabel.center = CGPointMake( self.cartBtn.iconImageView.mj_x+self.cartBtn.iconImageView.mj_w, self.cartBtn.iconImageView.mj_y+5);
    self.cartBtn.iconCountLabel.bounds = CGRectMake(0, 0, width+7, 10);
}

- (void)touchCart
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchCartType,NO);
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

- (void)touchCollect
{
    if (self.didTouchBlock) {
        self.didTouchBlock(GoodsDetailTouchCollectType,!self.collectBtn.select);
    }
}

- (void)setIsFavourite:(BOOL)isFavourite
{
    _isFavourite = isFavourite;
    self.collectBtn.select = isFavourite;
    if (isFavourite) {
        [self.collectBtn.heartButton notAnimationSelect];
        self.collectBtn.iconTitleLabel.textColor = UIFontRedColor;
    }
    else{
        [self.collectBtn.heartButton deselect];
        self.collectBtn.iconTitleLabel.textColor = UIFontMainGrayColor;
    }
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
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
        [_addCartBtn setTitleColor:UIRGBColor(34, 34, 34, 1) forState:UIControlStateNormal];
        
        _addCartBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _addCartBtn.backgroundColor = UIStringColor(@"fad8dc");
    }
    return _addCartBtn;
}

- (UIButton *)showSKUAdressBtn
{
    if (!_showSKUAdressBtn) {
        _showSKUAdressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
       [_showSKUAdressBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        _showSKUAdressBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _showSKUAdressBtn.titleLabel.numberOfLines = 2;
        [_showSKUAdressBtn setTitle:@"门店所在地区暂不供货\n点击选择其它地区" forState:UIControlStateNormal];
        _showSKUAdressBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:151/255.0 blue:6/255.0 alpha:1];//UIFontPhotoColor;
        _showSKUAdressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _showSKUAdressBtn.hidden = 1;
    }
    return _showSKUAdressBtn;
}

- (UIButton *)showSoldOutBtn
{
    if (!_showSoldOutBtn) {
        _showSoldOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_showSoldOutBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        _showSoldOutBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _showSoldOutBtn.titleLabel.numberOfLines = 2;
        [_showSoldOutBtn setTitle:@"所选属性暂不供货\n点击选择其它属性" forState:UIControlStateNormal];
        _showSoldOutBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:151/255.0 blue:6/255.0 alpha:1];//UIFontPhotoColor;
        _showSoldOutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _showSoldOutBtn.hidden = 1;
    }
    return _showSoldOutBtn;
}

- (UIButton *)showWillIntegralBtn
{
    if (!_showWillIntegralBtn) {
        _showWillIntegralBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_showWillIntegralBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        _showWillIntegralBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _showWillIntegralBtn.titleLabel.numberOfLines = 2;
        [_showWillIntegralBtn setTitle:@"活动未开始\n请耐心等待" forState:UIControlStateNormal];
        _showWillIntegralBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:151/255.0 blue:6/255.0 alpha:1];//UIFontPhotoColor;
        _showWillIntegralBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _showWillIntegralBtn.hidden = 1;
    }
    return _showWillIntegralBtn;
}

- (Fcgo_GoodsDetailBottomButton *)cartBtn
{
    if (!_cartBtn) {
        _cartBtn = [Fcgo_GoodsDetailBottomButton buttonWithType:UIButtonTypeSystem];
        _cartBtn.iconTitleLabel.text = @"购物车";
        _cartBtn.heartButton.hidden = YES;
        _cartBtn.iconImageView.image = [UIImage imageNamed:@"cart_detail"];
    }
    return _cartBtn;
}

- (Fcgo_GoodsDetailBottomButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [Fcgo_GoodsDetailBottomButton buttonWithType:UIButtonTypeSystem];
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

@end
