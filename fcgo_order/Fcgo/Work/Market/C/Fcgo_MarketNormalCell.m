//
//  Fcgo_MarketNormalCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketNormalCell.h"

@implementation Fcgo_MarketNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.backgroundColor = UIFontWhiteColor;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.top.mas_offset(kAutoWidth6(20));
        make.height.width.mas_offset(kAutoWidth6(28));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imgView.mas_bottom).mas_offset(kAutoWidth6(10));
        make.left.right.mas_offset(0);
    }];
    self.titleLabel.textColor = UIFontSortGrayColor;
}

@end
