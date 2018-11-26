//
//  Fcgo_SearchHistoryCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SearchHistoryCollectionViewCell.h"

@implementation Fcgo_SearchHistoryCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

@end
