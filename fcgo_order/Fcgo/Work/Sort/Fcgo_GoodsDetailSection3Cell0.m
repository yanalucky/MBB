//
//  Fcgo_GoodsDetailSection3Cell0.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailSection3Cell0.h"

@implementation Fcgo_GoodsDetailSection3Cell0

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.selectionStyle  = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = UIFontMainGrayColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
        
    }];
    
    [self.enterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.choseLabel.font = [UIFont systemFontOfSize:15];
    self.choseLabel.textColor = UIFontRedColor;
    
    [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
        make.width.mas_offset(kAutoWidth6(200));
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(5);
    }];
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];

}
@end
