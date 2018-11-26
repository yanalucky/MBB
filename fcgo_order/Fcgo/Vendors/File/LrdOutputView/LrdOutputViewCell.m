//
//  LrdOutputViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "LrdOutputViewCell.h"

@implementation LrdOutputViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    WEAKSELF(weakSelf);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.bottom.mas_offset(-10);
        make.width.mas_equalTo(weakSelf.iconImageView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).mas_offset(5);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(-10);
    }];
}

@end
