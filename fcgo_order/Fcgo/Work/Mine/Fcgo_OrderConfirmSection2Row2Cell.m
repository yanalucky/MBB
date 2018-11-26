//
//  Fcgo_OrderConfirmSection2Row2Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmSection2Row2Cell.h"

@interface Fcgo_OrderConfirmSection2Row2Cell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;

@property (strong, nonatomic) IBOutlet UIView    *bottomLineView;

@end

@implementation Fcgo_OrderConfirmSection2Row2Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(0);
        make.right.mas_offset(-15);
        //make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(12);
        make.left.mas_offset(85);
    }];
    self.textField.textColor = UIFontMainGrayColor;
    self.textField.font = UIFontSize(15);
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

@end


