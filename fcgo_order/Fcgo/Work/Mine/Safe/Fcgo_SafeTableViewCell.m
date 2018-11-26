//
//  Fcgo_SafeTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SafeTableViewCell.h"

@implementation Fcgo_SafeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = UIFontMainGrayColor;
    self.textField.tintColor = UIFontMainGrayColor;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(kAutoWidth6px(-10));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(30);
    }];
}

@end
