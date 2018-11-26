//
//  Fcgo_GoodsInfoBottomButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoBottomButton.h"

@implementation Fcgo_GoodsInfoBottomButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self addSubview:self.iconTitleLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.iconCountLabel];
    
    [self addSubview:self.heartButton];
    
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
    
    self.iconCountLabel.layer.cornerRadius = 5;
    self.iconCountLabel.layer.masksToBounds = 1;
    
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
        _iconCountLabel.hidden = 1;
        _iconCountLabel.adjustsFontSizeToFitWidth = YES;
        _iconCountLabel.backgroundColor = UIFontRedColor;
        _iconCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconCountLabel;
}

- (LEECoolButton *)heartButton
{
    if (!_heartButton) {
        LEECoolButton *heartButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"goodsinfo_love"] ImageFrame:CGRectMake(0, 0, 22, 22)];
        heartButton.imageOn = [UIImage imageNamed:@"goodsinfo_red-love"];
        heartButton.imageOff =  [UIImage imageNamed:@"goodsinfo_love"];
        
        heartButton.circleColor = UIFontRedColor;
        heartButton.lineColor = [UIColor colorWithRed:226/255.0f green:96/255.0f blue:96/255.0f alpha:1.0f];
        heartButton.userInteractionEnabled = 0;
        _heartButton = heartButton;
    }
    return _heartButton;
}

@end

