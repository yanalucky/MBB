//
//  Fcgo_OrderConfirmGoodsTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmGoodsTableCell.h"

@interface Fcgo_OrderConfirmGoodsTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;

@property (weak, nonatomic) IBOutlet UILabel *goodsAttrs;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation Fcgo_OrderConfirmGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.selectionStyle = 0;
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_offset(15);
        make.height.width.mas_offset(80);
    }];
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsImg.mas_top).mas_offset(kAutoWidth6(14));
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
        make.right.mas_offset(-15);
    }];
    self.goodsName.numberOfLines = 2;
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = UIFontSize(15);
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
    }];
    self.goodsPrice.textColor = UIStringColor(@"#f63378");
    self.goodsPrice.font = UIFontSize(15);
    
    
    [self.goodsAttrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsPrice.mas_top).mas_offset(-8);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
        make.right.mas_offset(-15);
    }];
    
    self.goodsAttrs.textColor = UIFontMiddleGrayColor;
    self.goodsAttrs.font = UIFontSize(12);
    
    
    [self.goodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsPrice.mas_centerY);
        make.right.mas_offset(-15);
    }];
    self.goodsCount.textColor = UIFontMiddleGrayColor;
    self.goodsCount.font = UIFontSize(14);
    self.bottomView.backgroundColor = UISepratorLineColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setModel:(Fcgo_OrderGoodsModel *)model
{
    _model = model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.picurl]placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsName.text  = model.goodsName;
    self.goodsAttrs.text = model.property;
    NSString *goodsPrice = [NSString stringWithFormat:@"%.2f",model.unitPriceYUAN.doubleValue + model.materYuan.doubleValue];
    NSString *frightString = [NSString stringWithFormat:@"运费 ¥ %@",model.frightYUAN.stringValue];
//    if(!model.materYuan || [model.materYuan isKindOfClass:[NSNull class]])
//    {
//        model.materYuan = [NSNumber numberWithFloat:0.00];
//    }
//    NSString *materString = [NSString stringWithFormat:@"包装费¥ %@",model.materYuan.stringValue];
//    NSString *tmpString = [NSString stringWithFormat:@"¥ %@ %@ %@",goodsPrice, frightString, materString];
    NSString *tmpString = [NSString stringWithFormat:@"¥ %@ %@",goodsPrice, frightString];
    NSRange friRange = [tmpString rangeOfString:frightString];
    //NSRange materRange = [tmpString rangeOfString:materString];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:tmpString];
    [attri addAttributes:@{NSFontAttributeName:UIFontSize(13)} range:friRange];
    
    
    NSRange friRange1 = [tmpString rangeOfString:@"运费"];
    [attri addAttributes:@{NSForegroundColorAttributeName:UIFontMiddleGrayColor} range:friRange1];
    
    //[attri addAttributes:@{NSFontAttributeName:UIFontSize(13)} range:materRange];
//    self.goodsPrice.text = [NSString stringWithFormat:@"¥ %@(运费 %@)",goodsPrice, model.fright.stringValue];
    self.goodsPrice.attributedText = attri;
    self.goodsCount.text = [NSString stringWithFormat:@"X%@",model.goodsTypeBo.goodsNumber];
}
@end

