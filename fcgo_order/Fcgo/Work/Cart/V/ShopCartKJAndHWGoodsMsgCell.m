//
//  ShopCartKJAndHWGoodsMsgCell.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartKJAndHWGoodsMsgCell.h"

@implementation ShopCartKJAndHWGoodsMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    WEAKSELF(weakSelf)
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.topView.backgroundColor = UIBackGroundColor;
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.height.mas_offset(116);
        make.top.mas_equalTo(self.contentView).offset(20);
        
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
    
    self.goodsStatus.hidden = 1;
    
    [self.goodsStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@70);
        make.centerY.mas_equalTo(self.goodsImg.mas_centerY);
        make.centerX.mas_equalTo(self.goodsImg.mas_centerX);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.right.mas_offset(0);
        make.width.height.mas_offset(25);
    }];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = [UIFont systemFontOfSize:15];
    self.goodsName.numberOfLines = 2;
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImg);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
    }];
    
    self.goodsAttrs.textColor = UIFontMiddleGrayColor;
    self.goodsAttrs.font = [UIFont systemFontOfSize:12];
    
    [self.goodsAttrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg.mas_top).mas_offset(45);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
    }];
    
    self.goodsSingleAndAdvicePrice.textColor = UIFontRedColor;
    self.goodsSingleAndAdvicePrice.font = [UIFont systemFontOfSize:12];
    
    [self.goodsSingleAndAdvicePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsAttrs.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
    }];
    
    self.goodsPrice.textColor = UIRGBColor(246, 51, 120, 1);
    self.goodsPrice.font = [UIFont systemFontOfSize:15];
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.goodsSingleAndAdvicePrice.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.goodsImg.mas_right).mas_offset(5);
    }];
    
    [self.contentView addSubview:self.numberButton];
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsPrice.mas_centerY);
        make.right.mas_offset(-15);
        make.width.mas_offset(kAutoWidth6(90));
        make.height.mas_offset(30);
    }];
    
    self.middleView.backgroundColor = UISepratorLineColor;
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    [self.contentView addSubview:self.tapControl];
    [self.tapControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImg.mas_left);
        make.top.mas_offset(0);
        make.right.mas_offset(-25);
        make.bottom.mas_equalTo(self.goodsSingleAndAdvicePrice.mas_top);
    }];
    
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleView.mas_bottom).mas_offset(7);
        make.right.mas_offset(-15);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    [self.buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    self.buyBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.buyBtn.layer.borderWidth   = 0.5;
    self.buyBtn.layer.cornerRadius  = 3;
    self.buyBtn.layer.masksToBounds = 1;
    [self.buyBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
   
    self.sumupLabel.textColor = UIFontMainGrayColor;
    self.sumupLabel.font = [UIFont systemFontOfSize:12];
    [self.sumupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.buyBtn.mas_centerY);
        
    }];
    self.sumupPrice.textColor = UIFontRedColor;
    self.sumupPrice.font = [UIFont systemFontOfSize:17];
    [self.sumupPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.buyBtn.mas_centerY);
        make.left.mas_equalTo(self.sumupLabel.mas_right).mas_offset(3);
    }];
}

- (void)buyClick
{
    if (self.buyBlock) {
        self.buyBlock(self.model);
    }
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
//         [WSProgressHUD showImage:nil status:@"该商品已失效,暂不能查看"];
//    }
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
       
    }
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
        numberButton.textField.enabled = NO;
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
    
    self.buyBtn.enabled  = NO;
    self.goodsStatus.hidden = NO;
   
    self.buyBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.buyBtn.layer.borderWidth   = 0.5;
    self.buyBtn.layer.cornerRadius  = 3;
    self.buyBtn.layer.masksToBounds = 1;
    [self.buyBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    
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
    if (model.f_status.intValue == 1)
    {
        self.buyBtn.enabled  = YES;
        self.goodsStatus.hidden = YES;
        self.buyBtn.layer.borderColor   = UIFontRedColor.CGColor;
        self.buyBtn.layer.borderWidth   = 0.5;
        self.buyBtn.layer.cornerRadius  = 3;
        self.buyBtn.layer.masksToBounds = 1;
        [self.buyBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
        [self.buyBtn setTitle:@"去支付" forState:UIControlStateNormal];
    }
    else if (model.f_status.intValue == 2)
    {
        self.goodsStatus.text = @"该地区无货";
         [self.buyBtn setTitle:@"该地区无货" forState:UIControlStateNormal];
    }
    else if (model.f_status.intValue == 3)
    {
        self.goodsStatus.text = @"已下架";
        [self.buyBtn setTitle:@"已下架" forState:UIControlStateNormal];
    }
//    else if (model.f_status.intValue == 3)
//    {
//        self.goodsStatus.text = @"已失效";
//         [self.buyBtn setTitle:@"已失效" forState:UIControlStateNormal];
//    }else if (model.f_status.intValue == 4){
//        [self setGoodStatusWithCircle:NO];
//        self.goodsStatus.text = @"当前区域无法配送";
//        [self.buyBtn setTitle:@"当前区域无法配送" forState:UIControlStateNormal];
//    }
    
    if(model.f_number && model.f_number.intValue>0)
    {
        if (model.remain.intValue/model.f_number.intValue <= 0) {
            self.buyBtn.enabled  = NO;
            self.goodsStatus.hidden = NO;
            self.goodsStatus.text = @"该地区无货";
            [self.buyBtn setTitle:@"该地区无货" forState:UIControlStateNormal];
            self.buyBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
            self.buyBtn.layer.borderWidth   = 0.5;
            self.buyBtn.layer.cornerRadius  = 3;
            self.buyBtn.layer.masksToBounds = 1;
            [self.buyBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
            
        }
    }
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.logo]placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsName.text = model.goodsName;
   
    self.goodsSingleAndAdvicePrice.text=[NSString stringWithFormat:@"折后单价:¥ %.2f", round([model.priceYUAN floatValue]*100)/100];
    
    self.goodsPrice.text=[NSString stringWithFormat:@"¥ %.2f",round([model.totalPriceYUAN floatValue]*100)/100];
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
        model.number = count;
    }
    self.numberButton.maxValue = count;
   
    NSString *goodsPrice = [NSString stringWithFormat:@"%.2f",round([model.totalPriceYUAN doubleValue]* model.number*100)/100];
    self.sumupPrice.text = [NSString stringWithFormat:@"¥ %@",goodsPrice];
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSString *)number
{
    self.model.number = number.intValue;
    self.sumupPrice.text = [NSString stringWithFormat:@"¥ %.2f",round([self.model.totalPriceYUAN doubleValue]* self.model.number*100)/100];
    self.countBlock(self.model);
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

@end
