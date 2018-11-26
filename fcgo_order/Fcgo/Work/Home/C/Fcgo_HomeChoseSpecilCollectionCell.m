//
//  Fcgo_HomeChoseSpecilCollectionCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeChoseSpecilCollectionCell.h"

@implementation Fcgo_HomeChoseSpecilCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        //make.width.mas_offset(AutoWidth6px(346));
        make.right.mas_offset(0);
        make.height.mas_equalTo(weakSelf.goodsImg.mas_width);
    }];
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(8);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    self.goodsName.numberOfLines = 2;
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = UIFontSize(13);

    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-3);
        make.left.right.mas_offset(0);
    }];
    self.goodsPrice.textColor = UIFontRedColor;
    self.goodsPrice.font = UIFontSize(15);
}

- (void)setModel:(Fcgo_HomeGoodsModel *)model
{
    _model = model;
    [self.goodsImg  sd_setImageWithURL:[NSURL  URLWithString:model.picurlLogo]placeholderImage:[UIImage imageNamed:@"580X580"]];
    [self.goodsName setText:model.goodsName];
    [self.goodsPrice  setText:[NSString  stringWithFormat:@"￥%.2f",[model.price doubleValue]]];
    
}

@end
