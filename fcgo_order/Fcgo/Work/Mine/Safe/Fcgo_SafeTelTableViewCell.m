//
//  Fcgo_SafeTelTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SafeTelTableViewCell.h"

@implementation Fcgo_SafeTelTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.backgroundColor = UIBackGroundColor;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

@end
