//
//  Fcgo_ShopInformationTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ShopInformationTableViewCell.h"

@implementation Fcgo_ShopInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
    }];
    self.titleLabel.textColor =  UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(-15);
        make.width.mas_offset(kAutoWidth6(250));
    }];
    self.descriptionLabel.textColor =  UIFontMainGrayColor;
    self.descriptionLabel.font = UIFontSize(15);
}

@end
