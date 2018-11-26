//
//  Fcgo_MsgTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgTableCell.h"

@interface Fcgo_MsgTableCell()



@end

@implementation Fcgo_MsgTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.msgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(7);
        make.bottom.mas_offset(-7);
        make.left.mas_offset(15);
        make.width.mas_equalTo(weakSelf.msgImageView.mas_height);
    }];
    
    [self.msgTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.msgImageView.mas_centerY).mas_offset(-3);
        make.left.mas_equalTo(weakSelf.msgImageView.mas_right).mas_offset(10);
        make.width.mas_offset(100);
    }];
    self.msgTitleLabel.textColor = UIFontMainGrayColor;
    self.msgTitleLabel.font = UIFontSize(15);
    
    [self.msgDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.msgTitleLabel);
        make.right.mas_offset(-15);
    }];
    self.msgDateLabel.textColor = UIFontMiddleGrayColor;
    self.msgDateLabel.font = UIFontSize(12);
    
    [self.msgDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.msgImageView.mas_centerY).mas_offset(3);
        make.left.mas_equalTo(weakSelf.msgImageView.mas_right).mas_offset(10);
        make.right.mas_offset(kAutoWidth6(-50));
    }];
    self.msgDetailLabel.textColor = UIFontMiddleGrayColor;
    self.msgDetailLabel.font = UIFontSize(13);
}

@end
