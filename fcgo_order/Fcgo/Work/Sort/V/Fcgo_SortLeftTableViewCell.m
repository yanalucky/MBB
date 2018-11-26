//
//  Fcgo_SortLeftTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortLeftTableViewCell.h"

@implementation Fcgo_SortLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle  = 0;
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(3));
    }];
    self.leftLineView.backgroundColor = UIFontRedColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(kAutoWidth6(-3));
        make.left.mas_equalTo(weakSelf.leftLineView.mas_right).mas_offset(0);

    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(14);
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
       self.titleLabel.textColor = UIFontRedColor;
       self.leftLineView.alpha = 1;
        self.titleLabel.font = UIFontSize(15);

        
    }
    else
    {
        self.titleLabel.textColor = UIFontMainGrayColor;
        self.leftLineView.alpha = 0;
        self.titleLabel.font = UIFontSize(14);

    }
}

@end
