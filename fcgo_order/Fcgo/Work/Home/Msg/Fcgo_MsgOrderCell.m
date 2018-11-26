//
//  Fcgo_MsgOrderCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgOrderCell.h"

@interface Fcgo_MsgOrderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *logisticsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

@end

@implementation Fcgo_MsgOrderCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.contentView.backgroundColor = UIBackGroundColor;
    self.selectionStyle = 0;
    WEAKSELF(weakSelf)
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImgView.mas_centerY);
        make.left.mas_equalTo(weakSelf.iconImgView.mas_right).mas_offset(10);
    }];
    self.timeLabel.textColor = UIFontMainGrayColor;
    self.timeLabel.font = UIFontSize(12);
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
        make.bottom.mas_offset(0);
    }];
    self.whiteView.backgroundColor = UIFontWhiteColor;
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.whiteView.mas_top).mas_offset(10);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(10);
    }];
    self.statusLabel.textColor = UIFontRedColor;
    self.statusLabel.font = UIFontSize(13);
    
    [self.logisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.statusLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-10);
        make.height.mas_offset(15);
        make.width.mas_offset(40);
    }];
    self.logisticsLabel.textColor = UIFontWhiteColor;
    self.logisticsLabel.font = UIFontSize(10);
    self.logisticsLabel.layer.cornerRadius = 3;
    self.logisticsLabel.layer.masksToBounds = YES;
    self.logisticsLabel.backgroundColor = UIRGBColor(150, 150, 150, 1);
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.statusLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
        make.width.height.mas_offset(70);
    }];
    self.goodsImgView.layer.cornerRadius = 3;
    self.goodsImgView.layer.borderColor  = UISepratorLineColor.CGColor;
    self.goodsImgView.layer.borderWidth  = 0.5;
    self.goodsImgView.layer.masksToBounds = YES;
    
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImgView.mas_bottom);
        make.left.mas_equalTo(weakSelf.goodsImgView.mas_left);
        make.right.mas_equalTo(weakSelf.goodsImgView.mas_right);
        make.height.mas_offset(15);
    }];
    self.goodsCountLabel.textColor = UIFontWhiteColor;
    self.goodsCountLabel.font = UIFontSize(10);
    self.goodsCountLabel.backgroundColor = UIRGBColor(0, 0, 0, 0.6);
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImgView.mas_top).mas_offset(3);
        make.left.mas_equalTo(weakSelf.goodsImgView.mas_right).mas_offset(10);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
    }];
    self.goodsNameLabel.textColor = UIFontMainGrayColor;
    self.goodsNameLabel.font = UIFontSize(13);
    self.goodsNameLabel.numberOfLines = 2;
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImgView.mas_bottom).mas_offset(-3);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
        make.left.mas_equalTo(weakSelf.goodsImgView.mas_right).mas_offset(10);
    }];
    self.orderIdLabel.textColor = UIFontMainGrayColor;
    self.orderIdLabel.font = UIFontSize(12);
}


@end

