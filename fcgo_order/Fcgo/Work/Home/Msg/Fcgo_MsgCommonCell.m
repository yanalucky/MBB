//
//  Fcgo_MsgCommonCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgCommonCell.h"

@implementation Fcgo_MsgCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        
    }];
    self.dateLabel.textColor = UIFontMiddleGrayColor;
    self.dateLabel.font = UIFontSize(12);
}

@end
