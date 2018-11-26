//
//  Fcgo_OrderDetailGoodsTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailGoodsTableViewCell.h"

@interface Fcgo_OrderDetailGoodsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView      *topLineView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel     *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsAttrsLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsSinglePriceLabel;
@property (weak, nonatomic) IBOutlet Fcgo_IndexButton    *applyBtn;
@property (weak, nonatomic) IBOutlet UIButton    *signBtn;


@end

@implementation Fcgo_OrderDetailGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.topLineView.backgroundColor = UISepratorLineColor;
    
    self.goodsImageView.layer.masksToBounds = YES;
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.topLineView.mas_bottom).mas_offset(kAutoWidth6(15));
        make.left.mas_offset(15);
        make.height.width.mas_offset(kAutoWidth6(70));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.topLineView.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(12);
        make.right.mas_offset(-15);
    }];
    
    self.goodsNameLabel.textColor = UIFontMainGrayColor;
    self.goodsNameLabel.font = UIFontSize(14);
    
    [self.goodsAttrsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsNameLabel.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(12);
        make.right.mas_offset(-15);
    }];
    
    self.goodsAttrsLabel.textColor = UIFontMiddleGrayColor;
    self.goodsAttrsLabel.font = UIFontSize(12);
    
    [self.goodsSinglePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsAttrsLabel.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(12);
    }];
    self.goodsSinglePriceLabel.textColor = UIFontRedColor;
    self.goodsSinglePriceLabel.font = UIFontSize(17);
    
    self.applyBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.applyBtn.layer.borderWidth   = 0.5;
    self.applyBtn.layer.cornerRadius  = 3;
    self.applyBtn.layer.masksToBounds = 1;
    [self.applyBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.applyBtn setBackgroundColor:UIFontWhiteColor];
    [self.applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.height.mas_offset(kAutoWidth6(22));
        make.width.mas_offset(kAutoWidth6(60));
        make.bottom.mas_offset(-7);
    }];
    
    self.signBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.signBtn.layer.borderWidth   = 0.5;
    self.signBtn.layer.cornerRadius  = 3;
    self.signBtn.layer.masksToBounds = 1;
    [self.signBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.signBtn setBackgroundColor:UIFontWhiteColor];
    [self.signBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.applyBtn.mas_left).mas_offset(-12);
        make.height.mas_offset(kAutoWidth6(22));
        make.width.mas_offset(kAutoWidth6(60));
        make.bottom.mas_offset(-7);
    }];
    
    self.signBtn.hidden = 1;
    self.applyBtn.hidden = 1;
}

- (IBAction)apply:(Fcgo_IndexButton *)sender {
    if (self.applyBlock) {
        self.applyBlock(self.goodsModel,sender);
    }
}
- (IBAction)sign:(UIButton *)sender {
    if (self.signBlock) {
        self.signBlock(self.goodsModel);
    }
}

- (void)setGoodsModel:(Fcgo_OrderListGoodsModel *)goodsModel
{
    self.signBtn.hidden = 1;
    self.applyBtn.hidden = 1;
    
    _goodsModel = goodsModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.picurl] placeholderImage:[UIImage imageNamed:@"580X580"]];
     self.goodsNameLabel.text = goodsModel.goodsName;
    self.goodsAttrsLabel.text = [NSString stringWithFormat:@"%@ 数量X%@",goodsModel.property,goodsModel.num];//goodsModel.goodsProperty;
    
    NSString *goodsPrice = [NSString stringWithFormat:@"¥ %.2f",round([goodsModel.priceYUAN floatValue]*100)/100];
    NSString *frightPrice = [NSString stringWithFormat:@"(包含运费 ¥ %.2f)", round([goodsModel.freightYUAN floatValue]*100)/100];
    
    NSString *tmpString = [NSString stringWithFormat:@"%@ %@",goodsPrice, frightPrice];
    NSRange friRange = [tmpString rangeOfString:frightPrice];
    NSRange goodsRange = [tmpString rangeOfString:goodsPrice];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:tmpString];
    [attri addAttributes:@{NSFontAttributeName:UIFontSize(13),NSForegroundColorAttributeName:UIFontRedColor} range:friRange];
    [attri addAttributes:@{NSFontAttributeName:UIFontSize(17),NSForegroundColorAttributeName:UIFontRedColor} range:goodsRange];
    
    self.goodsSinglePriceLabel.attributedText = attri;
    
    if (goodsModel.orderGoodsStatus.intValue == -2 ||
        goodsModel.orderGoodsStatus.intValue == 3 ||
        goodsModel.orderGoodsStatus.intValue == 10 ||
        goodsModel.orderGoodsStatus.intValue == 20 ||
        goodsModel.orderGoodsStatus.intValue == 30 ||
        goodsModel.orderGoodsStatus.intValue == 40)
    {
        self.applyBtn.hidden = 0;
    }
    if (goodsModel.afterSaleId.intValue == 0) {
        [self.applyBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        self.applyBtn.select = NO;
    }
    else
    {
        [self.applyBtn setTitle:@"查看售后" forState:UIControlStateNormal];
        self.applyBtn.select = YES;
    }
}

@end
