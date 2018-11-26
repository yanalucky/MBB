//
//  Fcgo_HomeCollectionWholePointGoodsCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionWholePointGoodsCell.h"


@interface Fcgo_HomeCollectionWholePointGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *actPricelabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;



@end

@implementation Fcgo_HomeCollectionWholePointGoodsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    WEAKSELF(weakSelf);
    self.backgroundColor = UIFontWhiteColor;
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(6));
        make.left.mas_offset(kAutoWidth6(6));
        make.right.mas_offset(kAutoWidth6(-6));
        make.height.mas_equalTo(weakSelf.goodsImageView.mas_width);
    }];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).mas_offset(kAutoWidth6(5));
        make.left.mas_offset(kAutoWidth6(6));
        make.height.mas_offset(kAutoWidth6(12.5));
        make.width.mas_offset(kAutoWidth6(27));
    }];
    [self.actPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.iconImg.mas_bottom).mas_offset(kAutoWidth6(3));
    }];
    self.actPricelabel.font =  UIFontSacleSize(14);
    self.actPricelabel.textColor = UIFontMainGrayColor;
}

- (void)setModel:(Fcgo_WholePointGoodsModel *)model
{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.picurl]placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.actPricelabel.text = [NSString stringWithFormat:@"¥ %@",model.bisIntegralPriceSup];
}

@end
