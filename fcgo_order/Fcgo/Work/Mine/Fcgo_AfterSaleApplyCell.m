//
//  Fcgo_AfterSaleApplyCell.m
//  Fcgo
//
//  Created by fcg on 2017/11/27.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AfterSaleApplyCell.h"

@interface Fcgo_AfterSaleApplyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel     *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *detailBtn;
@end
@implementation Fcgo_AfterSaleApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    // Initialization code
}
- (void)setUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
   
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(kAutoWidth6(12));
        make.left.mas_equalTo(weakSelf).offset(kAutoWidth6(12));
        make.height.width.mas_offset(kAutoWidth6(80));
    }];
    
    
    self.goodsNameLabel.textColor = UIFontMainGrayColor;
    self.goodsNameLabel.font = UIFontSize(16);
    self.goodsNameLabel.numberOfLines = 2;
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(kAutoWidth6(12));
        make.right.mas_offset(-kAutoWidth6(12));
    }];
    
    self.goodsPriceLabel.textColor = UIFontSortGrayColor;
    self.goodsPriceLabel.font = UIFontSize(12);
    self.goodsPriceLabel.numberOfLines = 2;
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsNameLabel.mas_bottom).offset(kAutoWidth6(12));
        make.left.mas_equalTo(weakSelf.goodsNameLabel);
        make.right.mas_offset(-kAutoWidth6(60));
    }];
   
    self.goodsCountLabel.textColor = UIFontSortGrayColor;
    self.goodsCountLabel.font = UIFontSize(12);
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.goodsPriceLabel);
        make.right.mas_offset(-kAutoWidth6(12));
    }];
    
    self.detailBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.detailBtn.layer.borderWidth   = 0.5;
    self.detailBtn.layer.cornerRadius  = 3;
    self.detailBtn.layer.masksToBounds = 1;
    [self.detailBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [self.detailBtn setBackgroundColor:UIFontWhiteColor];
    self.detailBtn.enabled = NO;
    [self.detailBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-kAutoWidth6(12));
        make.height.mas_offset(kAutoWidth6(25));
        make.width.mas_offset(kAutoWidth6(70));
        make.bottom.equalTo(weakSelf).offset(-kAutoWidth6(12));
    }];
    
  
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.bottomLineView.backgroundColor = UIBackGroundColor;
}
- (void)setModel:(Fcgo_AfterSalesServiceListModel *)model
{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsSkuPicurl]placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsNameLabel.text = model.goodsName;
  
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"%@",model.properties];
  
    self.goodsCountLabel.text = [NSString stringWithFormat:@"X%@",model.goodsBuynum];
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
