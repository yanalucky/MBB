//
//  Fcgo_OrderConfirmAdressTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmAdressTableCell.h"

@interface Fcgo_OrderConfirmAdressTableCell ()


@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *customerTelImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerTelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adressImageView;
@property (weak, nonatomic) IBOutlet UILabel     *adressLabel;
@property (strong, nonatomic) IBOutlet UIView    *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation Fcgo_OrderConfirmAdressTableCell

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
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerNameLabel.mas_left);
        make.centerY.mas_equalTo(weakSelf.adressImageView);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-12);
    }];
    self.adressLabel.textColor = UIFontMainGrayColor;
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
    
}

- (void)setModel:(Fcgo_AddressModel *)model
{
    _model = model;
    self.customerNameLabel.text = model.consigee;
    self.customerTelLabel.text = model.consigeePhone;
    self.adressLabel.text = [NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail];
}

@end



