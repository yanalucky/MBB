//
//  Fcgo_GoodsDetailSection4Cell0.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailSection4Cell0.h"

@interface Fcgo_GoodsDetailSection4Cell0 ()


@property (weak, nonatomic) IBOutlet UIImageView *brandImg;
@property (weak, nonatomic) IBOutlet UILabel     *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *brandSaleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *enterImg;
@property (weak, nonatomic) IBOutlet UIView      *bottomview;

@end

@implementation Fcgo_GoodsDetailSection4Cell0

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.selectionStyle  = 0;
    [self.brandImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.width.mas_offset(40*140/62);
        make.height.mas_offset(40);
    }];
    //    self.brandImg.layer.cornerRadius = 20;
    //    self.brandImg.layer.borderColor = BackGroundColor.CGColor;
    //    self.brandImg.layer.borderWidth = 0.5;
    //    self.brandImg.layer.masksToBounds = YES;
    
    self.brandNameLabel.font = [UIFont systemFontOfSize:17];
    self.brandNameLabel.textColor = UIFontMainGrayColor;
    [self.brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.brandImg.mas_top).mas_offset(-2);
        make.left.mas_equalTo(self.brandImg.mas_right).mas_offset(8);
        make.width.mas_offset(kAutoWidth6(180));
    }];
    
    self.brandSaleLabel.font = [UIFont systemFontOfSize:13];
    self.brandSaleLabel.textColor = UIFontMiddleGrayColor;
    [self.brandSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.brandImg.mas_bottom).mas_offset(2);
        make.left.mas_equalTo(self.brandImg.mas_right).mas_offset(8);
    }];
    
    [self.enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView).mas_offset(-2.5);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.bottomview.backgroundColor = UIBackGroundColor;
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(5);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setBrandModel:(Fcgo_BrandModel *)brandModel
{
    _brandModel = brandModel;
    [self.brandImg sd_setImageWithURL:[NSURL URLWithString:brandModel.brand_logo]placeholderImage:[UIImage imageNamed:@"456X228（品牌）"]];
    self.brandNameLabel.text = brandModel.brand_name;
    self.brandSaleLabel.text = [NSString stringWithFormat:@"在售商品 %@ 件",brandModel.brandSaleNum];
}

@end
