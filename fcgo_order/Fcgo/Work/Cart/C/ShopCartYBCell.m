//
//  ShopCartYBCell.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartYBCell.h"

@implementation ShopCartYBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kAutoWidth6(12));
        make.width.height.mas_offset(30);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(8);
        make.width.height.mas_offset(116);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    
    self.goodStyleImg.hidden = YES;
//    self.goodStyleImg.backgroundColor = UIFontRedColor;
    [self.goodStyleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.goodsImg);
        make.bottom.equalTo(self.goodsImg);
        make.centerX.equalTo(self.goodsImg);
        make.height.equalTo(@(20));
    }];
    
    self.goodsStatus.backgroundColor = UIRGBColor(0, 0, 0, 0.47);
    self.goodsStatus.layer.cornerRadius = 35;
    self.goodsStatus.layer.masksToBounds = YES;
    self.goodsStatus.textColor = UIFontWhiteColor;
    self.goodsStatus.font = [UIFont systemFontOfSize:15];
    self.goodsStatus.text = @"已下架";
    self.goodsStatus.hidden = 1;
    self.goodsStatus.adjustsFontSizeToFitWidth = YES;
    [self.goodsStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@70);
        make.centerY.mas_equalTo(self.goodsImg.mas_centerY);
        make.centerX.mas_equalTo(self.goodsImg.mas_centerX);
    }];
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = [UIFont systemFontOfSize:15];
    self.goodsName.numberOfLines = 0;
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(@(40));
    }];
    
    [self.contentView addSubview:self.numberButton];
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-13);
        make.right.mas_offset(-15);
        make.width.mas_offset(kAutoWidth6(90));
        make.height.mas_offset(30);
    }];
    
    self.goodsPrice.textColor = UIRGBColor(246, 51, 120, 1);
    self.goodsPrice.font = [UIFont systemFontOfSize:16];
    [self.goodsPrice adjustsFontSizeToFitWidth];
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberButton.mas_centerY);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.numberButton.mas_left).mas_offset(-5);
    }];
    
    self.goodsSingleAndAdvicePrice.textColor = UIFontRedColor;
    self.goodsSingleAndAdvicePrice.font = [UIFont systemFontOfSize:12];
    
    [self.goodsSingleAndAdvicePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.numberButton.mas_top).mas_offset(-8);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
    }];
    
    self.goodsAttrs.textColor = UIFontMiddleGrayColor;
    self.goodsAttrs.font = [UIFont systemFontOfSize:12];
    
    [self.goodsAttrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodsSingleAndAdvicePrice.mas_top).mas_offset(-8);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.width.height.mas_offset(25);
    }];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomView.backgroundColor = UISepratorLineColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    [self.contentView addSubview:self.tapControl];
    
    [self.tapControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImg.mas_left);
        make.top.mas_offset(0);
        make.right.mas_offset(-25);
        make.bottom.mas_equalTo(self.goodsSingleAndAdvicePrice.mas_top);
    }];
}

- (UIControl *)tapControl
{
    if (!_tapControl) {
        _tapControl= [[UIControl alloc]init];
        [_tapControl addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
        _tapControl.backgroundColor = UIFontClearColor;
    }
    return _tapControl;
}
- (void)jump
{
    if (self.model.f_status.intValue == 1) {
        if (self.jumpBlock) {
            self.jumpBlock(self.model);
        }
        
    }
    else if (self.model.f_status.intValue == 2)
    {
        [WSProgressHUD showImage:nil status:@"该地区无货"];
    }
    else if (self.model.f_status.intValue == 3)
    {
        [WSProgressHUD showImage:nil status:@"该商品已下架,暂不能查看"];
    }
//    else if (self.model.f_status.intValue == 3)
//    {
//        [WSProgressHUD showImage:nil status:@"该商品已失效,暂不能查看"];
//    }else if (self.model.f_status.intValue == 4)
//    {
//        [WSProgressHUD showImage:nil status:@"该商品当前区域无法配送,暂不能查看"];
//
//    }
}

- (void)selectClick
{
    if (!self.selectBtn.select)
    {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    self.selectBtn.select = !self.selectBtn.select;
    self.model.select = self.selectBtn.select;
    self.selectBlock(self.model);
}

- (void)deleteClick
{
    WEAKSELF(weakSelf)
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确定从购物车删除该商品吗" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        if (weakSelf.deleteBlock) {
            weakSelf.deleteBlock(self.model);
        }
    }];
}

- (PPNumberButton *)numberButton
{
    if (!_numberButton) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth - 112, 12.5, 100, 30)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        numberButton.delegate = self;
        //设置边框颜色
        numberButton.borderColor = UIRGBColor(216, 216, 216, 1);
        numberButton.increaseTitle = @"＋";
        numberButton.decreaseTitle = @"－";
        numberButton.minValue = 1;
        _numberButton = numberButton;
    }
    return _numberButton;
}
-(void)setGoodStatusWithCircle:(BOOL)isCircle{
    self.goodsStatus.layer.masksToBounds = YES;
    if (isCircle) {
        self.goodsStatus.layer.cornerRadius = 35;
    }else{
        self.goodsStatus.layer.cornerRadius = 0;
    }
    self.goodsStatus.font = [UIFont systemFontOfSize:isCircle?15:8];
    if (isCircle) {
        [self.goodsStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(@70);
            make.centerY.mas_equalTo(self.goodsImg.mas_centerY);
            make.centerX.mas_equalTo(self.goodsImg.mas_centerX);
        }];
    }else{
        [self.goodsStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.goodsImg);
            make.bottom.equalTo(self.goodsImg);
            make.centerX.equalTo(self.goodsImg);
            make.height.mas_equalTo(@20);
        }];
    }
    
}
- (void)setModel:(Fcgo_CartModel *)model
{
    _model = model;
    
    self.selectBtn.enabled  = NO;
    self.goodsStatus.hidden = NO;
    
    
    if (![model.goodsType isEqualToString:@"normal"]) {
        NSString *imgName = @"";
        if ([model.goodsType isEqualToString:@"integral"]) {
            imgName= @"bg_seckill";
        }else if ([model.goodsType isEqualToString:@"combal"]){
            imgName = @"bg_group";
        }else if ([model.goodsType isEqualToString:@"specialarea"]){
            imgName = @"bg_promotion";
        }
        [self.goodStyleImg setImage:[UIImage imageNamed:imgName]];
         self.goodStyleImg.hidden = NO;
    }else{
        self.goodStyleImg.hidden = YES;
    }
    
    [self setGoodStatusWithCircle:YES];
    self.numberButton.userInteractionEnabled = YES;
    if (model.f_status.intValue == 1)
    {
        self.selectBtn.enabled  = YES;
        self.goodsStatus.hidden = YES;
        if (model.select)
        {
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
        }else{
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        }
        self.selectBtn.select = model.select;
    }
    else if (model.f_status.intValue == 2)
    {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
        self.goodsStatus.text = @"该地区无货";
        self.numberButton.userInteractionEnabled = NO;
        
    }
    else if (model.f_status.intValue == 3)
    {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
       
         self.goodsStatus.text = @"已下架";
        self.numberButton.userInteractionEnabled = NO;

    }

//    else if (model.f_status.intValue == 3)
//    {
//        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
//        self.goodsStatus.text = @"已失效";
//        self.numberButton.userInteractionEnabled = NO;
//
//
//    }else if (model.f_status.intValue == 4)
//    {
//        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
//        [self setGoodStatusWithCircle:NO];
//        self.goodsStatus.text = @"当前区域无法配送";
//        self.numberButton.userInteractionEnabled = NO;
//
//    }
    if(model.f_number&& model.f_number.intValue>0)
    {
        if (model.remain.intValue/model.f_number.intValue <= 0) {
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
            self.goodsStatus.text = @"该地区无货";
            self.goodsStatus.hidden = NO;
            self.numberButton.userInteractionEnabled = NO;
            self.selectBtn.enabled  = NO;
            
        }
    }
    
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.logo]placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsName.text = model.goodsName;
    self.goodsSingleAndAdvicePrice.text=[NSString stringWithFormat:@"折后单价:¥ %.2f", round([model.priceYUAN floatValue]*100)/100];
    
    NSString *goodsPrice = [NSString stringWithFormat:@"%.2f",round([model.totalPriceYUAN floatValue]*100)/100];
    
    self.goodsPrice.text=[NSString stringWithFormat:@"¥ %@",goodsPrice];
    if (!model.property) {
        model.property = @"  ";
    }
    self.goodsAttrs.text = model.property;
    self.numberButton.currentNumber = model.number;
    
    
    NSInteger count = 0;
    if ([model.goodsType isEqualToString:@"normal"]) {
        count = model.remain.intValue/model.f_number.intValue;
    }else{
        count = model.remain.intValue;
    }
    
    if (count <= model.number) {
        self.numberButton.maxValue = model.number;
    }
    self.numberButton.maxValue = count;
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSString *)number
{
    self.model.number = number.intValue;
    self.countBlock(self.model);
}
@end
