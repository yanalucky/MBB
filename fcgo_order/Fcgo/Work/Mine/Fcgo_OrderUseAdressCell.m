//
//  Fcgo_OrderUseAdressCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderUseAdressCell.h"

@interface Fcgo_OrderUseAdressCell ()


@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *customerTelImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerTelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adressImageView;
@property (weak, nonatomic) IBOutlet UILabel     *adressLabel;
@property (weak, nonatomic) IBOutlet UIView      *middleLineView;

@end

@implementation Fcgo_OrderUseAdressCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.customerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_offset(15);
        make.height.width.mas_offset(18);
    }];
    
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.customerImageView.mas_bottom);
        make.width.mas_offset(70);
    }];
    
    self.customerNameLabel.textColor = UIFontMainGrayColor;
    
    [self.customerTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_equalTo(weakSelf.customerNameLabel.mas_right).mas_offset(10);
        make.height.width.mas_offset(18);
    }];
    
    [self.customerTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerTelImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.customerTelImageView.mas_bottom);
    }];
    
    self.customerTelLabel.textColor = UIFontMainGrayColor;
    
    [self.adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.customerImageView.mas_bottom).mas_offset(18);
        make.height.width.mas_offset(18);
    }];
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerNameLabel.mas_left);
        make.centerY.mas_equalTo(weakSelf.adressImageView);
        make.right.mas_offset(-15);
    }];
    
    self.adressLabel.textColor = UIFontMainGrayColor;
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleLineView.backgroundColor = UISepratorLineColor;
}

- (void)setModel:(Fcgo_AddressModel *)model
{
    _model = model;
    self.customerNameLabel.text = model.consigee;
    self.customerTelLabel.text = model.consigeePhone;
    self.adressLabel.text = [NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail];
}

@end


