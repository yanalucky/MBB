//
//  Fcgo_GoodsDetailBottomButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailBottomButton.h"

@implementation Fcgo_GoodsDetailBottomButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupUI];
}

- (void)setupUI
{
    [self addSubview:self.iconTitleLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.iconCountLabel];
    [self addSubview:self.heartButton];
    self.iconCountLabel.layer.cornerRadius = 5;
    self.iconCountLabel.layer.masksToBounds = 1;
    WEAKSELF(weakSelf);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.height.width.mas_offset(25);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);

    }];
//    [self.iconCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_offset(10);
//        make.centerY.mas_equalTo(weakSelf.iconImageView.mas_top).mas_offset(5);
//        make.centerX.mas_equalTo(weakSelf.iconImageView.mas_right).mas_offset(0);
//    }];
    [self.heartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(6);
        make.height.width.mas_offset(22);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    [self.iconTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-3);
        make.left.right.mas_offset(0);
    }];
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        //_iconImageView.backgroundColor = [UIColor redColor];
    }
    return _iconImageView;
}

- (UILabel *)iconTitleLabel
{
    if (!_iconTitleLabel){
        _iconTitleLabel = [[UILabel alloc]init];
        _iconTitleLabel.textColor = UIFontMainGrayColor;
        _iconTitleLabel.font = [UIFont systemFontOfSize:11];
        _iconTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconTitleLabel;
}

- (UILabel *)iconCountLabel

{
    if (!_iconCountLabel) {
        _iconCountLabel = [[UILabel alloc]init];
        _iconCountLabel.textColor = UIFontWhiteColor;
        _iconCountLabel.font = [UIFont systemFontOfSize:8];
        _iconCountLabel.alpha = 1;
        _iconCountLabel.text = @"2";
        _iconCountLabel.adjustsFontSizeToFitWidth = YES;
        _iconCountLabel.backgroundColor = UIFontRedColor;
        _iconCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconCountLabel;
}

- (LEECoolButton *)heartButton
{
    if (!_heartButton) {
        LEECoolButton *heartButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"table-bar_icon_love"] ImageFrame:CGRectMake(0, 0, 22, 22)];
        heartButton.imageOn = [UIImage imageNamed:@"table-bar_icon_red-love"];
        heartButton.imageOff =  [UIImage imageNamed:@"table-bar_icon_love"];
        
        heartButton.circleColor = UIFontRedColor;
        heartButton.lineColor = [UIColor colorWithRed:226/255.0f green:96/255.0f blue:96/255.0f alpha:1.0f];
        heartButton.userInteractionEnabled = 0;
        _heartButton = heartButton;
    }
    return _heartButton;
}

@end
