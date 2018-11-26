//
//  Fcgo_Market_DataStatisticsCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_DataStatisticsCell.h"

@interface Fcgo_Market_DataStatisticsCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation Fcgo_Market_DataStatisticsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2);
    }];
    
    self.dayLabel.textColor = UIFontMainGrayColor;
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(2);
    }];
    self.timeLabel.textColor = UIFontMiddleGrayColor;
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dayLabel.mas_right).mas_offset(kAutoWidth6(20));
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.height.width.mas_offset(kAutoWidth6(40));
    }];
    self.headerImg.layer.cornerRadius = kAutoWidth6(18);
    self.headerImg.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(15));
        make.centerY.mas_equalTo(weakSelf.dayLabel.mas_centerY);
    }];
    self.nameLabel.textColor = UIFontMainGrayColor;
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(15));
        make.top.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(2);
    }];
    self.orderIdLabel.textColor = UIFontMainGrayColor;
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
    }];
    self.amountLabel.textColor = UIFontRedColor;
    
    self.bottomLine.backgroundColor = UISepratorLineColor;
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}


@end

