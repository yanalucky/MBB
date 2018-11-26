//
//  Fcgo_MineContainImageViewLabelButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineContainImageViewLabelButton.h"

@implementation Fcgo_MineContainImageViewLabelButton

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.btnImageView];
    [self addSubview:self.iconCountLabel];
    [self addSubview:self.btnLabel];
    
    [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kAutoWidth6(32));
        make.right.mas_offset(kAutoWidth6(-32));
        make.top.mas_offset(kAutoWidth6(8));
        make.height.mas_equalTo(weakSelf.btnImageView.mas_width);
    }];
    
    [self.iconCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.btnImageView.mas_right).mas_offset(-2);
       make.top.mas_offset(kAutoWidth6(4));
        make.height.width.mas_offset(14);
    }];
    
    [self.btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.btnImageView.mas_bottom).mas_offset(kAutoWidth6(8));
    }];
}

- (void)setCountValue:(NSInteger)value {
    self.iconCountLabel.hidden = value <= 0;
    self.iconCountLabel.text = @(value).stringValue;
}

- (UIImageView *)btnImageView
{
    if (!_btnImageView) {
        _btnImageView = [[UIImageView alloc]init];
        
    }
    return _btnImageView;
}

- (UILabel *)btnLabel
{
    if (!_btnLabel) {
        _btnLabel = [[UILabel alloc]init];
        _btnLabel.font = [UIFont systemFontOfSize:12];
        _btnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _btnLabel;
}

- (UILabel *)iconCountLabel

{
    if (!_iconCountLabel) {
        _iconCountLabel = [[UILabel alloc]init];
        _iconCountLabel.textColor = UIFontWhiteColor;
        _iconCountLabel.font = [UIFont systemFontOfSize:9];
        _iconCountLabel.hidden = 1;
        _iconCountLabel.text = @"";
        _iconCountLabel.adjustsFontSizeToFitWidth = YES;
        _iconCountLabel.backgroundColor = UIFontRedColor;
        _iconCountLabel.layer.cornerRadius = 7;
        _iconCountLabel.layer.masksToBounds = 1;
        _iconCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconCountLabel;
}

@end
