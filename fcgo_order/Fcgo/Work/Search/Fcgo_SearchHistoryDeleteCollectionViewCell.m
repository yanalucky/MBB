//
//  Fcgo_SearchHistoryDeleteCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SearchHistoryDeleteCollectionViewCell.h"

@implementation Fcgo_SearchHistoryDeleteCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.contentView.backgroundColor = UIFontWhiteColor;
    
    self.layer.cornerRadius = 4;
    self.layer.borderColor = UIFontMiddleGrayColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = 1;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(13);

}

@end
