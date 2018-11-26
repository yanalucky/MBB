//
//  Fcgo_Market_CustomerManngerDetailCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_CustomerManngerDetailCell.h"

@interface Fcgo_Market_CustomerManngerDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation Fcgo_Market_CustomerManngerDetailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
    }];
    self.orderIdLabel.textColor = UIFontMainGrayColor;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.orderIdLabel.mas_bottom).mas_offset(8);
    }];
    self.timeLabel.textColor = UIFontMiddleGrayColor;
    
   [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
    }];
    self.amountLabel.textColor = UIFontRedColor;
    
    self.bottomLine.backgroundColor = UISepratorLineColor;
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.bottomLine.backgroundColor = UIBackGroundColor;
}


@end


