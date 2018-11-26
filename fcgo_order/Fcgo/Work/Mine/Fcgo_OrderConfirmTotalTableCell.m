//
//  Fcgo_OrderConfirmTotalTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmTotalTableCell.h"

@interface Fcgo_OrderConfirmTotalTableCell ()

@property (strong, nonatomic) IBOutlet UIView    *bottomLineView;

@end


@implementation Fcgo_OrderConfirmTotalTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.selectionStyle = 0;
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_offset(15);
    }];
    self.goodsCountLabel.textColor = UIFontMainGrayColor;
    self.goodsCountLabel.font = UIFontSize(14);
    
    [self.goodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsCountLabel);
        make.right.mas_offset(-15);
    }];
    
    self.goodsCount.textColor = UIFontRedColor;
    self.goodsCount.font = UIFontSize(14);
    
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsCountLabel.mas_bottom).mas_offset(8);
        make.left.mas_offset(15);
    }];
    
    self.freightLabel.textColor = UIFontMainGrayColor;
    self.freightLabel.font = UIFontSize(14);
    
    [self.freight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.freightLabel);
        make.right.mas_offset(-15);
    }];
    
    self.freight.textColor = UIFontRedColor;
    self.freight.font = UIFontSize(14);
    
//    [self.materLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.freightLabel.mas_bottom).offset(8);
//        make.left.mas_offset(15);
//    }];
//    self.materLabel.textColor = UIFontMainGrayColor;
//    self.materLabel.font = UIFontSize(14);
//
//    [self.mater mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-15);
//        make.centerY.mas_equalTo(self.materLabel);
//    }];
//    self.mater.textColor = UIFontRedColor;
//    self.mater.font = UIFontSize(14);
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.freightLabel.mas_bottom).mas_offset(8);
        make.left.mas_offset(15);
    }];
    
    self.totalLabel.textColor = UIFontMainGrayColor;
    self.totalLabel.font = UIFontSize(14);
    
    [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.totalLabel);
        make.right.mas_offset(-15);
    }];
    
    self.total.textColor = UIFontRedColor;
    self.total.font = UIFontSize(14);
    
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
    
    self.mater.hidden = 1;
    self.materLabel.hidden = 1;
}

@end
