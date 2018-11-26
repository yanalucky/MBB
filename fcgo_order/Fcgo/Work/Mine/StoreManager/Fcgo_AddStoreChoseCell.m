//
//  Fcgo_AddStoreChoseCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AddStoreChoseCell.h"

@interface Fcgo_AddStoreChoseCell()

@end

@implementation Fcgo_AddStoreChoseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
    }];
    self.choseLabel.textColor = UIFontMiddleGrayColor;
    self.choseLabel.font = UIFontSize(15);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.choseLabel.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
}

@end

