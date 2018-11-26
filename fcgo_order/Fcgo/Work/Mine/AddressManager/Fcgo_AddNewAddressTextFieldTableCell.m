//
//  Fcgo_AddNewAddressTextFieldTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddNewAddressTextFieldTableCell.h"

@interface Fcgo_AddNewAddressTextFieldTableCell ()



@end

@implementation Fcgo_AddNewAddressTextFieldTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.bottom.mas_offset(0);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(5);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    [self.inputLabel setValue:UIRGBColor(190, 190, 190, 1) forKeyPath:@"_placeholderLabel.textColor"];
    self.inputLabel.font = UIFontSize(15);
    self.inputLabel.textColor = UIFontMainGrayColor;
    self.inputLabel.tintColor = UIFontMainGrayColor;
}

@end
