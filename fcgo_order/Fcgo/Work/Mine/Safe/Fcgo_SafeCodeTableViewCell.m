//
//  Fcgo_SafeCodeTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SafeCodeTableViewCell.h"

@implementation Fcgo_SafeCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    
    self.selectionStyle = 0;
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(90);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(30);
    }];
    
    [self.codeBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.codeBtn.mas_left).mas_offset(-5);
        make.width.mas_offset(1);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(20);
    }];
    self.lineView.backgroundColor = UIFontRedColor;

    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = UIFontMainGrayColor;
    self.textField.tintColor = UIFontMainGrayColor;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.mas_offset(kAutoWidth6(200));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(30);
    }];
}
- (IBAction)send:(UIButton *)sender
{
    if (self.sendBlock) {
        self.sendBlock(sender);
    }
   
}






@end
