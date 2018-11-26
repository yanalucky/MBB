//
//  Fcgo_MarketButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketButton.h"

@implementation Fcgo_MarketButton

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
       make.bottom.mas_equalTo(weakSelf.mas_centerY).mas_offset(kAutoWidth6(-1));
        
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.mas_centerY).mas_offset(kAutoWidth6(2));
    }];
}

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.font = UIFontSacleSize(14);
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.textColor = UIFontWhiteColor;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.font = UIFontSacleSize(12);
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = UIFontWhiteColor;
    }
    return _bottomLabel;
}



@end
