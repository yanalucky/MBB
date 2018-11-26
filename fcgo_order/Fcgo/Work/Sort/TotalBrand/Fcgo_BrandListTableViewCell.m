//
//  Fcgo_BrandListTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BrandListTableViewCell.h"

@implementation Fcgo_BrandListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.bottom.mas_offset(0);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);

    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
        make.left.mas_offset(0);
    }];
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    self.bottomLineView.alpha = 0;
}

@end
