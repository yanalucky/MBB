//
//  Fcgo_GoodsListTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsListTableCell.h"

@interface Fcgo_GoodsListTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSalePrice;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation Fcgo_GoodsListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.mas_offset(15);
        make.height.width.mas_offset(80);
    }];
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImg.mas_top).mas_offset(7);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
        make.right.mas_offset(-15);
    }];
    self.goodsName.numberOfLines = 2;
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = UIFontSize(15);
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(-7);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
    }];
    self.goodsPrice.textColor = UIStringColor(@"#f63378");
    self.goodsPrice.font = UIFontSize(17);
    
    [self.goodsSalePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsPrice.mas_centerY);
        make.right.mas_offset(-15);
    }];
    self.goodsSalePrice.textColor = UIStringColor(@"#f63378");
    self.goodsSalePrice.font = UIFontSize(12);
    self.bottomView.backgroundColor = UISepratorLineColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.goodsSalePrice.hidden = 1;
}

- (void)setModel:(Fcgo_HomeGoodsModel *)model
{
    _model = model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.picurlLogo]placeholderImage:[UIImage imageNamed:@"580X580"]];
    NSString *str = @"";
    switch (model.texe.integerValue) {
        case 1:
            str = @"【一般贸易】";
            break;
        case 2:
            str = @"【跨境保税】";
            break;
        case 3:
            str = @"【海外直邮】";
            break;
            
        default:
            break;
    }
    self.goodsName.text = [str stringByAppendingString:model.goodsName?:@""];
    self.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[model.priceYUAN floatValue]];
    self.goodsSalePrice.text = [NSString stringWithFormat:@"建议零售价:¥ %.2f",[model.jprice floatValue]];
}

@end
