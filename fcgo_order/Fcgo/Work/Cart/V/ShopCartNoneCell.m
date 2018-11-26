//
//  ShopCartNoneCell.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartNoneCell.h"

@implementation ShopCartNoneCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.noneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6px(72));
        make.width.height.mas_offset(kAutoWidth6px(516));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        
    }];
    
    self.noneLabel.textColor = UIFontSortGrayColor;//UIRGBColor(119, 119, 119, 1);
    self.noneLabel.font = [UIFont systemFontOfSize:13];
    [self.noneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noneImg.mas_bottom).mas_offset(kAutoWidth6px(54));
        make.left.right.mas_offset(0);
    }];
    
    self.none_goBtn.backgroundColor = UIFontRedColor;
    [self.none_goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.width.mas_offset(120);
        make.top.mas_equalTo(self.noneLabel.mas_bottom).mas_offset(kAutoWidth6px(66));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    [self.none_goBtn addTarget:self action:@selector(goToVisit1) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomview.backgroundColor = UIBackGroundColor;
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

- (void)goToVisit1
{
    self.goToVisit();
}

@end
