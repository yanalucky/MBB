//
//  Fcgo_MarketShopManngerCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketShopManngerCell.h"

@implementation Fcgo_MarketShopManngerCell

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
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(-10);
        make.width.mas_offset(kAutoWidth6(250));
    }];
    self.descriptionLabel.textColor = UIFontMiddleGrayColor;
    self.descriptionLabel.font = UIFontSize(15);
}

@end
